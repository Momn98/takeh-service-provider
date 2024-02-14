import 'package:app_activity_launcher/app_activity_launcher.dart';
import 'package:service_provider/Pages/Orders/openOrderPopUp.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/FCM.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Models/Order.dart';
import 'package:service_provider/Models/User.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:service_provider/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class UserRealTimeProvider extends ChangeNotifier {
  late Channel privateUserChannel;
  late User user;
  bool isOrderPopUp = false;

  var audioPlayer = AssetsAudioPlayer.newPlayer();

  UserRealTimeProvider() {
    audioPlayer.open(
      Audio(AppAudio.newOrder1),
      showNotification: false,
      autoStart: false,
      forceOpen: false,
      loopMode: LoopMode.single,
    );
  }

  linkToUser(BuildContext context) async {
    await realTimeProvider.connect();
    user = authProvider.user;

    privateUserChannel =
        await realTimeProvider.pusher.subscribe('private-user.${user.id}');

    privateUserChannel.bind('new-order', (PusherEvent? event) async {
      if (event?.data != null) {
        Map data = jsonDecode(event!.data ?? '');

        if (data['action'] == 'open' && !isOrderPopUp) {
          orderProvider.order = Order.fromAPI(data['order']);

          if (orderProvider.order.id == 0) return;

          isOrderPopUp = true;

          NotificationService.showNotification(
            title: 'يوجد طلب جديد',
            body: 'يوجد طلب جديد',
          );

          // try {
          //   // NavMove.goToPage(context, ProfilePage());
          //   var _app = AppActivityLauncher();
          //   await _app.openActivity(
          //       appId: "com.takeh.service_provider", activity: "MainActivity");
          //   // returns false if there was an error
          // } catch (e) {}

          AppActivityLauncher _app = AppActivityLauncher();
          await _app.openActivity(
              appId: "com.takeh.service_provider", activity: "MainActivity");

          audioPlayer.play();
          var res = await openNewOrderPopUp(context);
          audioPlayer.pause();

          if (res == null) orderProvider.updateOrder(Order());

          isOrderPopUp = false;
          if (res != null && res['accept']) {
            await orderProvider.changeOrderStatus(context, 3, '');

            orderProvider.orders.add(orderProvider.order);

            orderProvider.updateOrder(orderProvider.order);

            orderProvider.linkToOrder(context);

            locationProvider.clearMarker();
            locationProvider.setStartEndMarker(
              orderProvider.order.from_address.latitude,
              orderProvider.order.from_address.longitude,
              orderProvider.order.to_address.latitude,
              orderProvider.order.to_address.longitude,
            );
            //
            locationProvider.clearPolylines();
            locationProvider.createPolylines(
              orderProvider.order.from_address.latitude,
              orderProvider.order.from_address.longitude,
              orderProvider.order.to_address.latitude,
              orderProvider.order.to_address.longitude,
            );

            return;
          }

          return;
        }

        if (data['action'] == 'close' && isOrderPopUp) {
          orderProvider.updateOrder(Order());
          isOrderPopUp = false;
          audioPlayer.pause();
          NavMove.closeDialog(context);
        }
      }
    });

    privateUserChannel.bind('update-order', (PusherEvent? event) async {
      if (event?.data != null) {
        Map data = jsonDecode(event!.data ?? '');

        Order order = Order.fromAPI(data['order']);

        if (order.id == orderProvider.order.id)
          orderProvider.updateOrder(order);

        orderProvider.updateOrderInOrders(order);

        notifyListeners();

        if (data['action'] == 'update-sp') {
          //

          // if (order.status.id == 4) {
          //   var resRate = await chooseYesNoDialog(
          //     context,
          //     S.current.rateTheCustomer,
          //     withRate: true,
          //     showNo: false,
          //     withInput: true,
          //     textInput: S.current.howIsTheCustomer,
          //   );
          //   if (resRate == null) return;
          //   Map apiData = {
          //     'order_id': order.id.toString(),
          //   };
          //   try {
          //     if (resRate['input'] != null)
          //       apiData.addAll({
          //         'text': resRate['input'].toString(),
          //       });
          //   } catch (e) {}
          //   try {
          //     apiData.addAll({
          //       'stars_count': resRate['rate'].toString(),
          //     });
          //   } catch (e) {}
          //   await orderProvider.rateOrder(context, apiData, order.id);
          // }

          //
        }

        notifyListeners();
      }
    });
  }
}
