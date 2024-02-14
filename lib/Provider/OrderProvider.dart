import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:service_provider/Api/OrderApi.dart';
import 'package:service_provider/Global/ChooseYesNo.dart';
import 'package:service_provider/Global/loadingDialog.dart';
import 'package:service_provider/Models/Order.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';
import 'dart:convert';

class OrderProvider extends ChangeNotifier {
  OrderApi _api = OrderApi();

  Order order = Order();

  updateOrder(Order ord) {
    order = ord;
    notifyListeners();
  }

  updateOrderInOrders(Order ord) {
    int index = orders.indexWhere((element) => element.id == ord.id);
    if (index > -1) {
      orders[index] = ord;
      notifyListeners();
    }
  }

  List<Order> orders = [];
  bool haveMoreOrders = true;
  int _ordersPage = 1;
  String status = 'active';

  Future getOrders() async {
    List<Order> orders = await _api.getOrders(_ordersPage, status);

    this.orders.addAll(orders);
    _ordersPage++;

    if (orders.length < 15) haveMoreOrders = false;

    notifyListeners();

    return;
  }

  Future changePageStatus(String newStatus) {
    status = newStatus;
    _ordersPage = 1;
    haveMoreOrders = true;
    orders = [];

    return getOrders();
  }

  Future changeOrderStatus(
      BuildContext context, int newStatus, String reason) async {
    loadingDialog(context);

    Map data = {
      'order_id': this.order.id.toString(),
      'new_status_id': newStatus.toString(),
      'reason': reason.toString(),
      'latitude': locationProvider.position.target.latitude.toString(),
      'longitude': locationProvider.position.target.longitude.toString(),
    };

    Order? order = await _api.changeOrder(data);
    if (order != null) {
      this.order = order;
    } else {
      this.order = Order();
    }

    notifyListeners();
    NavMove.closeDialog(context);

    return;
  }

  rateOrder(BuildContext context, Map data, int id) async {
    loadingDialog(context);
    // Rate? rate =
    await _api.rateOrder(data);

    // if (rate != null) {
    //   int index = orders.indexWhere((element) => element.id == id);
    //   if (index > -1) orders[index].driver_rate = rate;
    // }

    NavMove.closeDialog(context);

    notifyListeners();
  }

  //

  Future getNorRatedOrder(BuildContext context) async {
    Order? order = await _api.getNorRatedOrder();

    if (order != null) {
      var res = await chooseYesNoDialog(
        context,
        S.current.rateTheCustomer,
        showNo: false,
        withRate: true,
        withInput: true,
        textInput: S.current.howIsTheCustomer,
      );

      if (res != null && res['choose']) {
        Map data = {
          'order_id': order.id.toString(),
          'text': res['input'].toString(),
          'stars_count': res['rate'].toString(),
        };

        rateOrder(context, data, order.id);
      }
    }

    notifyListeners();
  }

  Future getActiveOrder(BuildContext context) async {
    Order? order = await _api.getActiveOrder();

    if (order != null) {
      this.order = order;

      linkToOrder(context);

      locationProvider.clearMarker();
      locationProvider.setStartEndMarker(
        order.from_address.latitude,
        order.from_address.longitude,
        order.to_address.latitude,
        order.to_address.longitude,
      );
      //
      locationProvider.clearPolylines();
      locationProvider.createPolylines(
        order.from_address.latitude,
        order.from_address.longitude,
        order.to_address.latitude,
        order.to_address.longitude,
      );

      // } else {
      // findNewOrderPopUp(context);
    }

    notifyListeners();
  }

  //
  //
  //
  //
  //
  late Channel privateOrderChannel;

  linkToOrder(BuildContext context) async {
    privateOrderChannel =
        await realTimeProvider.pusher.subscribe('private-order.${order.id}');
  }

  sendCurrentPositionOnOrder(LatLng latLng) async {
    if (!authProvider.isLogIn) return;

    if (order.id > 0 && [3, 4, 5, 6].contains(order.status.id)) {
      privateOrderChannel.trigger(
        'driver-location',
        jsonEncode(
            {"latitude": latLng.latitude, "longitude": latLng.longitude}),
      );
    }
  }

  String _cancelReason = '';
  String get cancelReason => _cancelReason;
  set cancelReason(String value) {
    _cancelReason = value;
    notifyListeners();
  }

  bool _other = false;
  bool get other => _other;
  set other(bool value) {
    _other = value;
    notifyListeners();
  }

  TextEditingController otherReason = TextEditingController();
}
