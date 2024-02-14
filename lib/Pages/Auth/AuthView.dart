import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Global/input.dart';
import 'package:service_provider/Pages/Auth/okayAndContinuePopUp.dart';
import 'package:service_provider/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Provider/SignProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/main.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  PhoneNumber number = PhoneNumber(isoCode: 'JO');

  @override
  void initState() {
    signProvider.clear();

    // authProvider.showPassword = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignProvider, AuthProvider>(
      builder: (_, v, av, __) {
        return GlobalSafeArea(
          appBar: HomeAppBar(text: 'Hello'),
          body: Container(
            child: Form(
              key: v.formKeyLogin,
              child: Column(
                children: [
                  setHeightSpace(20),
                  globalText(
                    S.current.addYourNumberWeWillSendYouOtpCode,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  setHeightSpace(30),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (val) {
                        number = val;
                        v.number = number;
                      },
                      initialValue: number,
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        hintText: S.current.phoneNumber,
                        border: border(Colors.grey),
                        focusedBorder: border(Colors.grey),
                        enabledBorder: border(Colors.grey),
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
                      // isEnabled: !av.showPassword,
                    ),
                  ),
                  // setHeightSpace(15),
                  // if (av.showPassword)
                  //   authTextFiled(
                  //     v.pass,
                  //     S.current.password,
                  //     validator: (value) => value!.isNotEmpty
                  //         ? null
                  //         : S.current.thisFieldIsRequired,
                  //     keyboardType: TextInputType.visiblePassword,
                  //   ),
                  Spacer(),
                  InkWell(
                    onTap: () =>
                        NavMove.goToPage(context, PoliciesPage(page: 'terms')),
                    child: globalText(
                      S.current.readOurPrivacyPolicy,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  setHeightSpace(20),
                  Container(
                    width: double.infinity,
                    child: globalButton(
                      S.current.okayAndContinue,
                      fontWeight: FontWeight.normal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      () async {
                        FocusScope.of(context).unfocus();

                        if (v.formKeyLogin.currentState!.validate()) {
                          var res = await okayAndContinuePopUp(context);

                          if (res == null) return;
                          if (!res['continue']) return v.clear();

                          // if (!av.showPassword) {
                          await authProvider.chickThe(
                            context,
                            {'phone': v.number.phoneNumber},
                          );
                          // } else {
                          //   await v.setData();

                          //   // return await authProvider.signUp(
                          //   //     context, v.signUpData, false);

                          //   await authProvider.logIn(
                          //     context,
                          //     {
                          //       'phone': v.number.phoneNumber,
                          //       'password': v.pass.text.toString(),
                          //     },
                          //     true,
                          //   );
                          // }

                          // await authProvider.logIn(context, widget.data, widget.haveAccount);
                          // NavMoveNoReturn.goToPage(context, HomeTabBarView());
                        }
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
}
