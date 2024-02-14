import 'package:service_provider/Global/selectImagePopUp.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Provider/OrderProvider.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Models/Appimage.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Models/Answer.dart';
import 'package:service_provider/Global/input.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

openNewOrderPopUp(BuildContext context) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (BuildContext context) {
      return OpenNewOrderPopUpWidge();
    },
  );
}

class OpenNewOrderPopUpWidge extends StatefulWidget {
  const OpenNewOrderPopUpWidge({super.key});
  @override
  State<OpenNewOrderPopUpWidge> createState() => _OpenNewOrderPopUpWidgeState();
}

class _OpenNewOrderPopUpWidgeState extends State<OpenNewOrderPopUpWidge> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer2<AuthProvider, OrderProvider>(
        builder: (_, auth, v, __) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.70,
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: globalText(
                        S.current.newOrder,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    //
                    PositionedDirectional(
                      end: 0,
                      child: InkWell(
                        onTap: () => NavMove.closeDialog(context),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        setHeightSpace(10),
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
                                setHeightSpace(10),
                              ],
                            ),
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
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: v.order.answers.length,
                          itemBuilder: (context, index) {
                            Answer answer = v.order.answers[index];

                            if (answer.type == 'date-time' ||
                                answer.type == 'from-to-address')
                              return Container();

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (answer.type != 'slider')
                                      globalText(
                                        answer.question.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    //
                                    //
                                    if (answer.type == 'options') // // //
                                      OptionWidgitCard(answer),
                                    //
                                    //
                                    if (answer.type == 'slider') // // //
                                      SliderWidgitCard(answer),
                                    //
                                    //
                                    if (answer.type == 'images') // // //
                                      ImagesWidgitCard(answer),
                                    //
                                    //
                                    if (answer.type == 'input') // // //
                                      InputWidgitCard(answer),
                                    //
                                    //
                                    if (answer.type == 'address') // // //
                                      AddressWidgitCard(answer),
                                    //
                                    //
                                    // if (answer.type == 'from-to-address') // // //
                                    //   FromToAddressWidgitCard(answer),
                                    //
                                    //
                                    if (answer.type == 'date-time') // // //
                                      DateTimeWidgitCard(answer),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                setHeightSpace(20),
                Row(
                  children: [
                    globalButton(
                      S.current.cancel,
                      () {
                        userRealTimeProvider.isOrderPopUp = false;
                        NavMove.goBack(context);
                      },
                      backColor: Colors.transparent,
                      borderColor: Colors.red,
                      textColor: Colors.red,
                      fontWeight: FontWeight.normal,
                    ),
                    setWithSpace(10),
                    Expanded(
                      flex: 2,
                      child: globalButton(
                        S.current.accept,
                        () => NavMove.goBack(context, data: {'accept': true}),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                setHeightSpace(25),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OptionWidgitCard extends StatefulWidget {
  final Answer answer;
  const OptionWidgitCard(this.answer, {super.key});

  @override
  State<OptionWidgitCard> createState() => _OptionWidgitCardState();
}

class _OptionWidgitCardState extends State<OptionWidgitCard> {
  late Answer answer;
  @override
  void initState() {
    answer = widget.answer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: answer.question.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (answer.option.image.length > 0) ...[
            Expanded(
              child: NetworkImagePlace(
                image: answer.option.image,
                fit: BoxFit.contain,
              ),
            ),
            setWithSpace(10),
          ],
          Expanded(
            flex: 2,
            child: globalText(
              answer.option.name,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

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
        // Slider(
        //   thumbColor: Colors.grey,
        //   activeColor: Colors.grey,
        //   inactiveColor: Colors.grey.shade300,
        //   min: answer.question.min.toDouble(),
        //   max: answer.question.max.toDouble(),
        //   value: double.parse(answer.answer),
        //   onChanged: (value) => null,
        // ),
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
        // setHeightSpace(10),
        // Card(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     side: BorderSide(color: Colors.black),
        //   ),
        //   child: InkWell(
        //     // onTap: () async {
        //     //   String googleUrl =
        //     //       'https://www.google.com/maps/search/?api=1&query=${orderProvider.order.from_address.latitude},${orderProvider.order.from_address.longitude}';
        //     //   // ignore: deprecated_member_use
        //     //   await launch(googleUrl);
        //     // },
        //     child: Container(
        //       width: double.infinity,
        //       padding: EdgeInsets.all(10),
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Container(
        //             child: GlobalImage.address_from,
        //             width: 15,
        //             height: 15,
        //           ),
        //           setWithSpace(5),
        //           Expanded(
        //             child: globalText(
        //               orderProvider.order.from_address.location,
        //             ),
        //           ),
        //           setWithSpace(5),
        //           Container(
        //             child: Image(image: GlobalImage.location),
        //             width: 20,
        //             height: 20,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
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
          child: InkWell(
            // onTap: () async {
            //   String googleUrl =
            //       'https://www.google.com/maps/search/?api=1&query=${orderProvider.order.from_address.latitude},${orderProvider.order.from_address.longitude}';
            //   // ignore: deprecated_member_use
            //   await launch(googleUrl);
            // },
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
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.black),
          ),
          child: InkWell(
            // onTap: () async {
            //   String googleUrl =
            //       'https://www.google.com/maps/search/?api=1&query=${orderProvider.order.to_address.latitude},${orderProvider.order.to_address.longitude}';
            //   // ignore: deprecated_member_use
            //   await launch(googleUrl);
            // },
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
        // setHeightSpace(10),
        globalText(
          "${S.current.time}: ${answer.answer}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        setHeightSpace(10),
      ],
    );
  }
}
