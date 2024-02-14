import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:service_provider/Pages/Orders/findNewOrderPopUp.dart';
import 'package:service_provider/Pages/Orders/activeOrderPopUp.dart';
import 'package:service_provider/Pages/Menu-Screen/MenuScreen.dart';
import 'package:service_provider/Provider/LocationProvider.dart';
import 'package:service_provider/Pages/Wallet/WalletCard.dart';
import 'package:service_provider/Provider/OrderProvider.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isTrafficEnabled = false;

  @override
  void initState() {
    locationProvider.getLocation(context);
    orderProvider.getNorRatedOrder(context);
    orderProvider.getActiveOrder(context);

    super.initState();
  }

  @override
  void dispose() {
    locationProvider.controller = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuScreen(),
      appBar: HomeAppBar(
        color: AppColor.orange,
        iconColor: Colors.white,
        showMenuBar: true,
        extra: [
          Expanded(
            child: WalletCard(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Consumer<LocationProvider>(
                  builder: (_, v, __) {
                    if (!v.haveLocation) return Container();
                    return Stack(
                      children: [
                        GoogleMap(
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: v.position,
                          markers: Set<Marker>.from(v.markers.values),
                          polylines: Set<Polyline>.of(v.polylines.values),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          tiltGesturesEnabled: true,
                          zoomGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          trafficEnabled: _isTrafficEnabled,
                          onMapCreated: (GoogleMapController con) {
                            v.controller.complete(con);
                            v.animateTo(
                              v.position.target.latitude,
                              v.position.target.longitude,
                            );

                            locationProvider.getLiveTrack();
                          },
                          onCameraMoveStarted: () {
                            // Do something on camera move started
                          },
                          onCameraMove: (cameraPosition) {
                            v.position = cameraPosition;
                          },
                        ),
                        PositionedDirectional(
                          bottom: 110.0,
                          start: 16.0,
                          child: Material(
                            color: Colors.white,
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(50),
                            child: IconButton(
                              iconSize: 30,
                              icon: Icon(
                                _isTrafficEnabled
                                    ? Icons.traffic
                                    : Icons.traffic,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isTrafficEnabled = !_isTrafficEnabled;
                                });
                              },
                              splashRadius: 30,
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 10.0,
                          start: 16.0,
                          child: Material(
                            color: Colors.white,
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(50),
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _zoomIn();
                                  },
                                  splashRadius: 30,
                                ),
                                IconButton(
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.minimize,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _zoomOut();
                                  },
                                  splashRadius: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Consumer<OrderProvider>(
                builder: (_, v, __) {
                  if (v.order.id != 0 && ![8, 9].contains(v.order.status.id))
                    return Container(
                      child: ActiveOrderPopUpWidge(),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                    );

                  return Container(
                    child: FindNewOrderPopUpWidge(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _zoomIn() async {
    final GoogleMapController controller =
        await locationProvider.controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() async {
    final GoogleMapController controller =
        await locationProvider.controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }
}
