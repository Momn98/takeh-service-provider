import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:service_provider/Global/selectImagePopUp.dart';
import 'package:service_provider/Pages/Auth/SignUpPagePersonalInfo.dart';
import 'package:service_provider/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:service_provider/Provider/SignProvider.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Global/input.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignProvider>(
      builder: (_, v, __) {
        return GlobalSafeArea(
          appBar: HomeAppBar(text: S.current.hello),
          body: Container(
            child: Form(
              key: v.formKeySignUp,
              child: Column(
                children: [
                  //
                  globalText(
                    S.current.addYourDetailsToUseOurApp,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  //
                  setHeightSpace(10),
                  //
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Stack(
                      children: [
                        imageCard(
                          S.current.profile,
                          v.image,
                          () async {
                            FocusScope.of(context).unfocus();
                            var res = await selectImagePopUp(context,
                                onlyOne: true, enableGallery: true);

                            if (res != null && res['is_picked'])
                              setState(() => v.image = res['pickeds'][0]);
                          },
                        ),
                        PositionedDirectional(
                          end: 5,
                          bottom: 5,
                          child: Container(
                            child: Icon(Icons.camera),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  setHeightSpace(15),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: authTextFiled(
                          v.fName,
                          label: S.current.fName,
                          validator: (value) => value!.isNotEmpty
                              ? null
                              : S.current.enterValidName,
                        ),
                      ),
                      //
                      setWithSpace(15),
                      //
                      Expanded(
                        child: authTextFiled(
                          v.lName,
                          label: S.current.lName,
                          validator: (value) => value!.isNotEmpty
                              ? null
                              : S.current.enterValidName,
                        ),
                      ),
                    ],
                  ),
                  //
                  setHeightSpace(15),
                  //
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (val) {},
                      isEnabled: false,
                      initialValue: v.number,
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        hintText: S.current.phoneNumber,
                        border: border(AppColor.secondary),
                        focusedBorder: border(AppColor.orange),
                        enabledBorder: border(AppColor.orange),
                        errorBorder: border(Colors.red),
                        disabledBorder: border(Colors.grey),
                      ),
                      errorMessage: S.current.phoneNumberNotValid,
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 10,
                        useEmoji: true,
                      ),
                    ),
                  ),
                  //
                  setHeightSpace(15),
                  // authTextFiled(
                  //   v.pass,
                  //   S.current.password,
                  //   validator: (value) => value!.isNotEmpty
                  //       ? null
                  //       : S.current.thisFieldIsRequired,
                  //   keyboardType: TextInputType.visiblePassword,
                  // ),
                  // setHeightSpace(15),
                  //

                  Row(
                    children: [
                      InkWell(
                        onTap: () => v.acceptTerms = !v.acceptTerms,
                        child: Icon(
                          v.acceptTerms
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 20,
                          color: v.errorAcceptTerms
                              ? hexToColor('#C00202')
                              : v.acceptTerms
                                  ? Colors.green
                                  : Colors.black,
                        ),
                      ),
                      setWithSpace(10),
                      InkWell(
                        onTap: () => NavMove.goToPage(
                            context, PoliciesPage(page: 'terms')),
                        child: Row(
                          children: [
                            globalText(
                              S.current.acceptTerms1,
                              style: TextStyle(
                                color: v.errorAcceptTerms
                                    ? hexToColor('#C00202')
                                    : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            setWithSpace(5),
                            globalText(
                              S.current.acceptTerms2,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

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

                        if (v.image == null) {
                          screenMessage(S.current.pleaseUploadPersonalImage);
                          return;
                        }

                        if (!v.acceptTerms) {
                          screenMessage(S.current.pleaseAcceptTerms);
                          v.errorAcceptTerms = true;
                          return;
                        }

                        return NavMove.goToPage(
                            context, SignUpPagePersonalInfo());
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
          side: BorderSide(color: Colors.black),
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
          child: globalText(
            text,
            style: TextStyle(
              color: hexToColor('#D4D4D4'),
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }
}
