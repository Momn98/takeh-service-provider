import 'package:service_provider/Pages/Auth/SignUpPageWorkInfo.dart';
import 'package:service_provider/Global/selectImagePopUp.dart';
import 'package:service_provider/Provider/TabBarProvider.dart';
import 'package:service_provider/Provider/SignProvider.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Models/Country.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/Models/City.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class SignUpPagePersonalInfo extends StatefulWidget {
  const SignUpPagePersonalInfo({super.key});

  @override
  State<SignUpPagePersonalInfo> createState() => _SignUpPagePersonalInfoState();
}

class _SignUpPagePersonalInfoState extends State<SignUpPagePersonalInfo> {
  @override
  void initState() {
    signProvider.country = tabBarProvider.countrys.first;
    signProvider.city = signProvider.country.citys.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignProvider, TabBarProvider>(
      builder: (_, v, v2, __) {
        return GlobalSafeArea(
          appBar: HomeAppBar(text: S.current.hello),
          body: SingleChildScrollView(
            child: Form(
              key: v.formKeySignUpPersonalInfo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  globalText(S.current.selectYourCountry),
                  setHeightSpace(10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<Country>(
                      items: v2.countrys
                          .map(
                            (e) => DropdownMenuItem<Country>(
                              value: e,
                              child: globalText(e.name),
                            ),
                          )
                          .toList(),
                      isExpanded: true,
                      value: v.country,
                      underline: Container(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => v.country = value);
                        }
                      },
                    ),
                  ),
                  setHeightSpace(15),

                  globalText(S.current.selectYourCity),
                  setHeightSpace(10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<City>(
                      items: v.country.citys
                          .map(
                            (e) => DropdownMenuItem<City>(
                              value: e,
                              child: globalText(e.name),
                            ),
                          )
                          .toList(),
                      isExpanded: true,
                      value: v.city,
                      underline: Container(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => v.city = value);
                        }
                      },
                    ),
                  ),
                  //
                  setHeightSpace(15),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: imageCard(S.current.uploadFrontDriverLicense,
                            v.frontDriverLicense, () async {
                          FocusScope.of(context).unfocus();
                          var res =
                              await selectImagePopUp(context, onlyOne: true);
                          if (res != null && res['is_picked'])
                            setState(
                                () => v.frontDriverLicense = res['pickeds'][0]);
                        }),
                      ),
                      // //
                      // setWithSpace(10),
                      // //
                      // Expanded(
                      //   child: imageCard(S.current.uploadBackDriverLicense,
                      //       v.backDriverLicense, () async {
                      //     FocusScope.of(context).unfocus();
                      //     var res =
                      //         await selectImagePopUp(context, onlyOne: true);
                      //     if (res != null && res['is_picked'])
                      //       setState(
                      //           () => v.backDriverLicense = res['pickeds'][0]);
                      //   }),
                      // ),
                    ],
                  ),
                  //
                  setHeightSpace(25),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: imageCard(
                            S.current.uploadFrontCarLicense, v.frontCarLicense,
                            () async {
                          FocusScope.of(context).unfocus();
                          var res =
                              await selectImagePopUp(context, onlyOne: true);
                          if (res != null && res['is_picked'])
                            setState(
                                () => v.frontCarLicense = res['pickeds'][0]);
                        }),
                      ),
                      // //
                      // setWithSpace(10),
                      // //
                      // Expanded(
                      //   child: imageCard(
                      //       S.current.uploadBackCarLicense, v.backCarLicense,
                      //       () async {
                      //     FocusScope.of(context).unfocus();
                      //     var res =
                      //         await selectImagePopUp(context, onlyOne: true);
                      //     if (res != null && res['is_picked'])
                      //       setState(
                      //           () => v.backCarLicense = res['pickeds'][0]);
                      //   }),
                      // ),
                    ],
                  ),

                  setHeightSpace(25),

                  Row(
                    children: [
                      Expanded(
                        child: imageCard(
                            S.current.uploadFrontVehicle, v.frontID, () async {
                          FocusScope.of(context).unfocus();
                          var res =
                              await selectImagePopUp(context, onlyOne: true);
                          if (res != null && res['is_picked'])
                            setState(() => v.frontID = res['pickeds'][0]);
                        }),
                      ),
                      // //
                      // setWithSpace(10),
                      // //
                      // Expanded(
                      //   child: imageCard(S.current.uploadBackVehicle, v.backID,
                      //       () async {
                      //     FocusScope.of(context).unfocus();
                      //     var res =
                      //         await selectImagePopUp(context, onlyOne: true);
                      //     if (res != null && res['is_picked'])
                      //       setState(() => v.backID = res['pickeds'][0]);
                      //   }),
                      // ),
                    ],
                  ),

                  setHeightSpace(20),
                  Container(
                    width: double.infinity,
                    child: globalButton(
                      S.current.Continue,
                      fontWeight: FontWeight.normal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // textColor: Colors.white,
                      () async {
                        FocusScope.of(context).unfocus();
                        if (!v.formKeySignUp.currentState!.validate()) return;

                        if (v.frontDriverLicense == null)
                          return screenMessage(
                              S.current.selectFrontDriverLicense);
                        // if (v.backDriverLicense == null)
                        //   return screenMessage(S.current.selectBackVehicle);

                        if (v.frontCarLicense == null)
                          return screenMessage(S.current.selectFrontCarLicense);
                        // if (v.backCarLicense == null)
                        //   return screenMessage(S.current.selectBackDriverLicense);

                        if (v.frontID == null)
                          return screenMessage(S.current.selectFrontVehicle);
                        // if (v.backID == null)
                        //   return screenMessage(S.current.selectBackCarLicense);

                        NavMove.goToPage(context, SignUpPageWorkInfo());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //
  Widget imageCard(String text, XFile? xFile, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: hexToColor('#ECECEC'),
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Container(
          height: 150,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: xFile != null
                ? DecorationImage(
                    image: FileImage(File(xFile.path)),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: GlobalImage.id_card),
              Spacer(),
              Center(
                child: globalText(
                  text,
                  style: TextStyle(
                    color: hexToColor('#D4D4D4'),
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
              setHeightSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
