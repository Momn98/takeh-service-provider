import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Global/ChooseYesNo.dart';
import 'package:service_provider/Global/input.dart';
import 'package:service_provider/Global/selectImagePopUp.dart';
import 'package:service_provider/Models/Answer.dart';
import 'package:service_provider/Models/Appimage.dart';
import 'package:service_provider/Models/Order.dart';
import 'package:service_provider/Pages/Orders/OneOrderPage.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Provider/OrderProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ActiveOrderPopUpWidge extends StatefulWidget {
  const ActiveOrderPopUpWidge({super.key});
  @override
  State<ActiveOrderPopUpWidge> createState() => _ActiveOrderPopUpWidgeState();
}

class _ActiveOrderPopUpWidgeState extends State<ActiveOrderPopUpWidge> {
  late Timer timer;
  int seconds = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(oneSec, (Timer timer) {
      if (!mounted) return;
      setState(() {
        seconds++;
      });
    });
  }

  void stopTimer() {
    try {
      timer.cancel();
    } catch (e) {}
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer2<AuthProvider, OrderProvider>(
        builder: (_, auth, v, __) {
          return RefreshIndicator(
            onRefresh: () async {
              return;
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.40,
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // globalText('text ${v.order.slug}'),
                  Row(
                    children: [
                      if (seconds > 0)
                        globalText(
                          formatTime(seconds),
                          style: TextStyle(fontSize: 13),
                        ),
                      if ([2, 3, 4, 5].contains(v.order.status.id)) ...[
                        Spacer(),
                        globalButton(
                          S.current.cancelTheOrder,
                          () => confirmCanseleOrder(context),
                          backColor: Colors.transparent,
                          borderColor: Colors.red,
                          textColor: Colors.red,
                          vertical: 5,
                          horizontal: 10,
                          fontSize: 14,
                        ),
                      ],
                    ],
                  ),

                  setHeightSpace(10),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  globalText(
                                    v.order.user.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  //
                                  setHeightSpace(5),
                                  //
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // ignore: deprecated_member_use
                                          launch('tel:${v.order.user.phone}');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Image.asset(
                                            IconSvg.call,
                                            color: Colors.green,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      setWithSpace(10),
                                      InkWell(
                                        onTap: () async {
                                          WhatsAppUnilink link =
                                              WhatsAppUnilink(
                                            phoneNumber: v.order.user.phone,
                                          );
                                          // ignore: deprecated_member_use
                                          await launch('$link');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          // decoration: BoxDecoration(
                                          //   borderRadius:
                                          //       BorderRadius.circular(90),
                                          //   color: Colors.green,
                                          // ),
                                          child: Image.asset(
                                            IconSvg.messenger,
                                            color: Colors.green,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  setHeightSpace(10),
                                ],
                              ),

                              //
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: hexToColor('#FFD84E'),
                                      child: v.order.user.image.length > 0
                                          ? NetworkImagePlace(
                                              image: v.order.user.image,
                                              fit: BoxFit.cover,
                                              all: 90,
                                            )
                                          : Icon(Icons.person),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  globalText(
                                    v.order.status.name,
                                    style:
                                        TextStyle(color: v.order.status.color),
                                  ),
                                  setHeightSpace(10),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: v.order.answers.length,
                            itemBuilder: (context, index) {
                              Answer answer = v.order.answers[index];

                              if (answer.type == 'date-time' ||
                                  answer.type == 'from-to-address')
                                return Container();

                              return Container();
                              // Card(
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              //   child: Container(
                              //     padding: EdgeInsets.all(10),
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         if (answer.type != 'slider')
                              //           // globalText(
                              //           //   answer.question.name,
                              //           //   style: TextStyle(
                              //           //     fontWeight: FontWeight.bold,
                              //           //     fontSize: 16,
                              //           //   ),
                              //           // ),
                              //           //
                              //           //
                              //           // if (answer.type == 'options') // // //
                              //           //   OptionWidgitCard(answer),
                              //           //
                              //           //
                              //           if (answer.type == 'slider') // // //
                              //             SliderWidgitCard(answer),
                              //         //
                              //         //
                              //         if (answer.type == 'images') // // //
                              //           ImagesWidgitCard(answer),
                              //         //
                              //         //
                              //         if (answer.type == 'input') // // //
                              //           InputWidgitCard(answer),
                              //         //
                              //         //
                              //         if (answer.type == 'address') // // //
                              //           AddressWidgitCard(answer),
                              //         //
                              //         //
                              //         if (answer.type ==
                              //             'from-to-address') // // //
                              //           FromToAddressWidgitCard(answer),
                              //         //
                              //         //
                              //         if (answer.type == 'date-time') // // //
                              //           DateTimeWidgitCard(answer),
                              //       ],
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                          setHeightSpace(25),
                          Row(
                            children: [
                              if (v.order.status.id == 3) ...[
                                Expanded(
                                  flex: 3,
                                  child: globalButton(
                                    S.current.goToCustomer,
                                    () async {
                                      v.changeOrderStatus(context, 4, '');
                                    },
                                  ),
                                ),
                              ] else if (v.order.status.id == 4) ...[
                                Expanded(
                                  flex: 3,
                                  child: globalButton(
                                    S.current.arivedToCustomer,
                                    () => v.changeOrderStatus(context, 5, ''),
                                  ),
                                ),
                              ] else if (v.order.status.id == 5) ...[
                                Expanded(
                                  flex: 3,
                                  child: globalButton(
                                    S.current.startOrder,
                                    () async {
                                      var resStart = await chooseYesNoDialog(
                                          context, S.current.confirmStartRide);
                                      if (resStart == null) return;
                                      await v.changeOrderStatus(context, 6, '');

                                      startTimer();
                                    },
                                  ),
                                ),
                              ] else if (v.order.status.id == 6) ...[
                                Expanded(
                                  flex: 3,
                                  child: globalButton(
                                    S.current.finishOrder,
                                    () async {
                                      var resFinish = await chooseYesNoDialog(
                                          context, S.current.confirmFinishRide);
                                      if (resFinish == null) return;

                                      var resRate = await chooseYesNoDialog(
                                        context,
                                        S.current.rateTheCustomer,
                                        withRate: true,
                                        showNo: false,
                                        withInput: true,
                                        textInput: S.current.howIsTheCustomer,
                                      );

                                      Map data = {
                                        'order_id': v.order.id.toString(),
                                      };

                                      try {
                                        if (resRate['input'] != null)
                                          data.addAll({
                                            'text': resRate['input'].toString(),
                                          });
                                      } catch (e) {}
                                      try {
                                        data.addAll({
                                          'stars_count':
                                              resRate['rate'].toString(),
                                        });
                                      } catch (e) {}

                                      await v.rateOrder(
                                          context, data, v.order.id);

                                      await v.changeOrderStatus(context, 7, '');

                                      try {
                                        stopTimer();
                                      } catch (e) {}

                                      await NavMove.goToPage(context,
                                          OneOrderPage(fromActive: true));

                                      setState(() {});
                                      orderProvider.updateOrder(Order());
                                      authProvider.location.status = 'online';
                                      setState(() {});

                                      setState(() {
                                        try {
                                          locationProvider.clearMarker();
                                        } catch (e) {}

                                        try {
                                          locationProvider.clearPolylines();
                                        } catch (e) {}
                                      });
                                    },
                                  ),
                                ),
                              ],
                              if ([3, 4, 5, 6].contains(v.order.status.id)) ...[
                                setWithSpace(10),
                                globalButton(
                                  S.current.map,
                                  icon: Icon(Icons.location_pin,
                                      color: AppColor.orange, size: 20),
                                  // iconLocation: 'end',
                                  () async {
                                    if ([3, 4, 5].contains(v.order.status.id)) {
                                      String googleUrl =
                                          'https://www.google.com/maps/search/?api=1&query=${v.order.from_address.latitude},${v.order.from_address.longitude}';
                                      // ignore: deprecated_member_use
                                      await launch(googleUrl);
                                    } else if ([6]
                                        .contains(v.order.status.id)) {
                                      String googleUrl =
                                          'https://www.google.com/maps/search/?api=1&query=${v.order.to_address.latitude},${v.order.to_address.longitude}';
                                      // ignore: deprecated_member_use
                                      await launch(googleUrl);
                                    }
                                  },
                                  fontSize: 15,
                                  backColor: Colors.transparent,
                                  textColor: Colors.black,
                                ),
                                setWithSpace(5),
                              ],
                            ],
                          ),
                          setHeightSpace(10),
                        ],
                      ),
                    ),
                  ),

                  setHeightSpace(25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  confirmCanseleOrder(BuildContext context, {String? extraText}) async {
    orderProvider.cancelReason = '';
    orderProvider.other = false;
    orderProvider.otherReason = TextEditingController();

    var res = await chooseYesNoDialog(
      context,
      S.current.confirmCancelTheOrder,
      extraText: extraText,
      extraStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      widgets: [
        Consumer<OrderProvider>(
          builder: (_, v, __) {
            return Column(
              children: [
                canselReasonButton(S.current.reason1),
                canselReasonButton(S.current.reason2),
                canselReasonButton(S.current.reason3),
                setHeightSpace(10),
                Row(
                  children: [
                    globalButton(
                      S.current.other,
                      () {
                        v.cancelReason = '';
                        v.other = true;
                      },
                      backColor: v.other ? AppColor.orange : Colors.transparent,
                      textColor: !v.other ? AppColor.orange : Colors.white,
                      borderColor: !v.other ? AppColor.orange : Colors.white,
                    ),
                    setWithSpace(10),
                    if (v.other)
                      Expanded(
                        child: authTextFiled(
                          v.otherReason,
                          hint: S.current.cancelReason,
                          onChanged: (p0) {
                            v.cancelReason = p0;
                          },
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );

    if (res == null) return;

    if (orderProvider.cancelReason == '') {
      return confirmCanseleOrder(context,
          extraText: S.current.thisFieldIsRequired);
    }

    await orderProvider.changeOrderStatus(
        context, 8, orderProvider.cancelReason);

    orderProvider.order = Order();

    if (!mounted) return;
    try {
      locationProvider.clearMarker();
    } catch (e) {}
    try {
      locationProvider.clearPolylines();
    } catch (e) {}
    setState(() {});
  }

  Widget canselReasonButton(String reason) {
    return InkWell(
      onTap: () {
        orderProvider.cancelReason = reason;
        orderProvider.other = false;
        orderProvider.otherReason = TextEditingController();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Radio(
                value: reason,
                groupValue: orderProvider.cancelReason,
                onChanged: (value) {
                  if (value != null) {
                    orderProvider.cancelReason = reason;
                    orderProvider.other = false;
                    orderProvider.otherReason = TextEditingController();
                  }
                },
              ),
            ),
            Expanded(child: globalText(reason)),
          ],
        ),
      ),
    );
  }

//
}

// class OptionWidgitCard extends StatefulWidget {
//   final Answer answer;
//   const OptionWidgitCard(this.answer, {super.key});

//   @override
//   State<OptionWidgitCard> createState() => _OptionWidgitCardState();
// }

// class _OptionWidgitCardState extends State<OptionWidgitCard> {
//   late Answer answer;
//   @override
//   void initState() {
//     answer = widget.answer;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: answer.question.height,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           if (answer.option.image.length > 0) ...[
//             Expanded(
//               child: NetworkImagePlace(
//                 image: answer.option.image,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             setWithSpace(10),
//           ],
//           Expanded(
//             flex: 2,
//             child: globalText(
//               answer.option.name,
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SliderWidgitCard extends StatefulWidget {
  final Answer answer;
  const SliderWidgitCard(this.answer, {super.key});

  @override
  State<SliderWidgitCard> createState() => _SliderWidgitCardState();
}

class _SliderWidgitCardState extends State<SliderWidgitCard> {
  late Answer answer;
  @override
  void initState() {
    answer = widget.answer;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        globalText(
          "${answer.question.name}: ${answer.answer}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        setHeightSpace(10),
      ],
    );
  }
}

class ImagesWidgitCard extends StatefulWidget {
  final Answer answer;
  const ImagesWidgitCard(this.answer, {super.key});

  @override
  State<ImagesWidgitCard> createState() => _ImagesWidgitCardState();
}

class _ImagesWidgitCardState extends State<ImagesWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
        ),
        itemCount: answer.images.length,
        itemBuilder: (context, index) {
          Appimage image = answer.images[index];

          return InkWell(
            onTap: () => NavMove.goToPage(
                context, ImageShowPage(image.image, index: index)),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: index == 0 ? AppColor.secondary : AppColor.orange,
                  width: index == 0 ? 2 : 1,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Image.network(image.image)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputWidgitCard extends StatefulWidget {
  final Answer answer;
  const InputWidgitCard(this.answer, {super.key});

  @override
  State<InputWidgitCard> createState() => _InputWidgitCardState();
}

class _InputWidgitCardState extends State<InputWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: TextEditingController(text: answer.answer),
          enabled: false,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.start,
          style: TextStyle(overflow: TextOverflow.visible),
          scrollPadding: EdgeInsets.all(5),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: border(AppColor.secondary),
            fillColor: Colors.white,
            alignLabelWithHint: true,
            hintMaxLines: 2,
            filled: true,
          ),
        ),
        setHeightSpace(10),
      ],
    );
  }
}

class AddressWidgitCard extends StatefulWidget {
  final Answer answer;
  const AddressWidgitCard(this.answer, {Key? key}) : super(key: key);
  @override
  State<AddressWidgitCard> createState() => _AddressWidgitCardState();
}

class _AddressWidgitCardState extends State<AddressWidgitCard> {
  late Answer answer;
  Completer<GoogleMapController> controller = Completer();
  late CameraPosition cameraPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<void> animateTo(double lat, double lng) async {
    final c = await controller.future;
    final p = CameraPosition(
      target: LatLng(lat, lng),
      zoom: cameraPosition.zoom,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  @override
  void initState() {
    answer = widget.answer;
    cameraPosition = CameraPosition(
      target: LatLng(orderProvider.order.from_address.latitude,
          orderProvider.order.from_address.longitude),
      zoom: 17,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        setHeightSpace(5),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                scrollGesturesEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: cameraPosition,
                markers: Set<Marker>.from(markers.values),
                onMapCreated: (GoogleMapController con) {
                  controller.complete(con);

                  markers[MarkerId(
                          'location-${orderProvider.order.from_address.id}')] =
                      Marker(
                    markerId: MarkerId(
                        'location-${orderProvider.order.from_address.id}'),
                    position: LatLng(
                      orderProvider.order.from_address.latitude,
                      orderProvider.order.from_address.longitude,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange),
                  );

                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FromToAddressWidgitCard extends StatefulWidget {
  final Answer answer;
  const FromToAddressWidgitCard(this.answer, {super.key});

  @override
  State<FromToAddressWidgitCard> createState() =>
      _FromToAddressWidgitCardState();
}

class _FromToAddressWidgitCardState extends State<FromToAddressWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  child: GlobalImage.address_from,
                  width: 15,
                  height: 15,
                ),
                setWithSpace(5),
                Expanded(
                  child: globalText(
                    orderProvider.order.from_address.location,
                    maxLines: 1,
                  ),
                ),
                setWithSpace(5),
                Container(
                  child: Image(image: GlobalImage.location),
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black),
          ),
          child: InkWell(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: GlobalImage.address_to,
                    width: 15,
                    height: 15,
                  ),
                  setWithSpace(5),
                  Expanded(
                    child: globalText(
                      orderProvider.order.to_address.location,
                      maxLines: 1,
                    ),
                  ),
                  setWithSpace(5),
                  Container(
                    child: Image(image: GlobalImage.location),
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DateTimeWidgitCard extends StatefulWidget {
  final Answer answer;
  const DateTimeWidgitCard(this.answer, {super.key});

  @override
  State<DateTimeWidgitCard> createState() => _DateTimeWidgitCardState();
}

class _DateTimeWidgitCardState extends State<DateTimeWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: double.infinity),
        globalText(
          "${S.current.time}: ${answer.answer}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        setHeightSpace(10),
      ],
    );
  }
}
