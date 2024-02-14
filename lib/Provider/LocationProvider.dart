import 'package:image/image.dart' as IMG;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_picker/map_picker.dart';
import 'package:service_provider/Api/HomeApi.dart';
import 'package:service_provider/Global/ChooseYesNo.dart';
import 'package:service_provider/Models/ServiceProviderLocation.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';

class LocationProvider extends ChangeNotifier {
  HomeApi _api = HomeApi();

  // late Position currentPosition;
  Location location = Location();
  late LatLng theLocation;
  // ignore: unused_field
  Completer<GoogleMapController> controller = Completer();

  bool haveLocation = false;
  MapPickerController mapPickerController = MapPickerController();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  //
  late CameraPosition position;

  getLocation(BuildContext context) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      var res = await chooseYesNoDialog(
        context,
        S.current.pleaseEnableLocationService,
      );

      if (res != null && res['choose'])
        _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) return getLocation(context);
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      var res = await chooseYesNoDialog(
        context,
        S.current.appNeedsAccessToYourDevicesLocation,
      );

      if (res != null && res['choose'])
        _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted)
        return getLocation(context);
    }

    try {
      _locationData = await location.getLocation();
    } catch (e) {}

    this.position = CameraPosition(
      target: LatLng(_locationData.latitude!, _locationData.longitude!),
      zoom: 17,
    );

    haveLocation = true;

    location.enableBackgroundMode(enable: true);

    notifyListeners();

    saveCurentLocation(loop: true);

    return _locationData;
  }

  saveCurentLocation({bool loop = false}) async {
    if (!authProvider.isLogIn) return;
    if (!loop) return;

    Map data = {
      'latitude': position.target.latitude.toString(),
      'longitude': position.target.longitude.toString(),
    };

    ServiceProviderLocation? driver = await _api.saveLocation(data);

    if (driver != null) authProvider.location = driver;

    Timer(Duration(seconds: 10), () => saveCurentLocation(loop: loop));
  }

  Future<void> animateTo(double lat, double lng) async {
    final c = await controller.future;
    final p = CameraPosition(
      target: LatLng(lat, lng),
      zoom: position.zoom,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  // getLiveTrack() async {
  //   currentPosition = await GeolocatorPlatform.instance.getCurrentPosition(
  //     locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
  //   );

  //   theLocation = LatLng(currentPosition.latitude, currentPosition.longitude);

  //   cameraPosition = CameraPosition(
  //     zoom: 16,
  //     target: LatLng(
  //       currentPosition.latitude,
  //       currentPosition.longitude,
  //     ),
  //   );

  //   // _controller.animateCamera(
  //   //   CameraUpdate.newLatLngZoom(cameraPosition.target, 16),
  //   // );

  //   animateTo(cameraPosition.target.latitude, cameraPosition.target.longitude);

  //   //

  //   // locationProvider.setLocation(
  //   //     currentPosition.latitude, currentPosition.longitude);

  //   // Timer(Duration(seconds: 5), () => getLiveTrack());
  // }

  getLiveTrack() async {
    location.onLocationChanged.listen((LocationData curr) {
      if (!authProvider.isLogIn) return;

      position = CameraPosition(
        target: LatLng(curr.latitude!, curr.longitude!),
        zoom: position.zoom,
      );

      if (orderProvider.order.id > 0 && orderProvider.order.status.id > 2) {
        orderProvider.sendCurrentPositionOnOrder(position.target);
      }

      if (!authProvider.isLogIn) return;
      animateTo(position.target.latitude, position.target.longitude);
    });

    saveCurentLocation();
  }

  // // // // // // // // // //
  // // // // // // // // // //
  // Set<Marker> markers = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  // List<Marker> markers = <Marker>[];

  // String startCoordinatesString = '';
  // '($startLatitude, $startLongitude)';
  // String destinationCoordinatesString = '';
  // '($destinationLatitude, $destinationLongitude)';
  // Start Location Marker
  late Marker? startMarker;
  // Destination Location Marker
  late Marker? toMarker;

  clearMarker() {
    markers = {};
    // markers = [];
    startMarker = null;
    toMarker = null;

    notifyListeners();
  }

  moveTheMarker(Marker marker) {
    markers[marker.markerId] = marker;
    notifyListeners();
  }

  Uint8List? resizeImage(Uint8List data, width, height) {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    resizedData = Uint8List.fromList(IMG.encodePng(resized));
    return resizedData;
  }

  setStartEndMarker(
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
  ) async {
    Uint8List fromImgurl =
        (await rootBundle.load('assets/icons/from_marker.png'))
            .buffer
            .asUint8List();
    Uint8List? fromMarkerImage = resizeImage(fromImgurl, 90, 90);

    startMarker = Marker(
      markerId: MarkerId('start-location'),
      position: LatLng(fromLat, fromLong),
      infoWindow: InfoWindow(title: 'Start'),
      // icon: BitmapDescriptor.defaultMarker,
      icon: BitmapDescriptor.fromBytes(fromMarkerImage!),
    );
    toMarker = Marker(
      markerId: MarkerId('end-location'),
      position: LatLng(toLat, toLong),
      infoWindow: InfoWindow(title: 'End'),
      icon: BitmapDescriptor.defaultMarker,
      // icon: BitmapDescriptor.fromBytes(toMarkerImage!),
    );

    if (startMarker != null) markers[MarkerId('start-location')] = startMarker!;
    if (toMarker != null) markers[MarkerId('end-location')] = toMarker!;

    notifyListeners();
  }
  // // // // // // // // // //
  // // // // // // // // // //

  // Object for PolylinePoints
  late PolylinePoints polylinePoints;
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  clearPolylines() {
    polylinePoints = PolylinePoints();
    polylineCoordinates = [];
    polylines = {};

    notifyListeners();
  }

  createPolylines(
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
  ) async {
    // Initializing PolylinePoints

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapKey,
      PointLatLng(fromLat, fromLong),
      PointLatLng(toLat, toLong),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('route');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;

    notifyListeners();
  }

  getOrderLiveTrack() async {
    location.onLocationChanged.listen((LocationData curr) {
      if (!authProvider.isLogIn) return;

      position = CameraPosition(
        target: LatLng(curr.latitude!, curr.longitude!),
        zoom: position.zoom,
      );

      if (orderProvider.order.id > 0 && orderProvider.order.status.id > 2) {
        orderProvider.sendCurrentPositionOnOrder(position.target);
      }

      if (!authProvider.isLogIn) return;
      animateTo(position.target.latitude, position.target.longitude);
    });

    saveCurentLocation();
  }
}
