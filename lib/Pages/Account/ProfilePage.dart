import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Global/input.dart';
import 'package:service_provider/Global/selectImagePopUp.dart';
import 'package:service_provider/Models/User.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = authProvider.user;

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'JO');

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    number = PhoneNumber(isoCode: 'JO', phoneNumber: user.phone);

    fName.text = user.firstName;
    lName.text = user.lastName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      vertical: 0,
      appBar: HomeAppBar(text: S.current.personalInformation),
      body: Consumer<AuthProvider>(
        builder: (_, v, __) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  setHeightSpace(10),

                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: InkWell(
                      onTap: () async {
                        var res =
                            await selectImagePopUp(context, onlyOne: true);

                        if (res != null && res['is_picked']) {
                          XFile file = res['pickeds'][0];
                          List<int> imageBytes = await file.readAsBytes();
                          String base64Image = base64Encode(imageBytes);
                          await authProvider.updateUserApi(context, {
                            'image': jsonEncode(base64Image),
                          });
                          setState(() {});
                        }
                      },
                      child: Stack(
                        children: [
                          ClipOval(
                            child: NetworkImagePlace(
                              image: v.user.image,
                              fit: BoxFit.cover,
                              all: 90,
                            ),
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
                  ),

                  setHeightSpace(10),

                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: NetworkImagePlace(
                              image: v.user.sp.category.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          setWithSpace(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              globalText(
                                v.user.sp.category.name,
                                maxLines: 2,
                              ),
                              setHeightSpace(10),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: v.user.rate,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  onRatingUpdate: (rating) => null,
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  setHeightSpace(10),

                  if (user.sp.category.slug.contains('car-info')) ...[
                    Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: authTextFiled(
                                    TextEditingController(
                                        text: v.user.sp.car_type),
                                    label: S.current.type,
                                    enabled: false,
                                  ),
                                ),
                                //
                                setWithSpace(10),
                                //
                                Expanded(
                                  child: authTextFiled(
                                    TextEditingController(
                                        text: v.user.sp.car_model),
                                    label: S.current.model,
                                    enabled: false,
                                  ),
                                ),
                              ],
                            ),
                            setHeightSpace(10),
                            Row(
                              children: [
                                Expanded(
                                  child: authTextFiled(
                                    TextEditingController(
                                        text: v.user.sp.car_year),
                                    label: S.current.year,
                                    enabled: false,
                                  ),
                                ),
                                setWithSpace(10),
                                Expanded(
                                  flex: 2,
                                  child: authTextFiled(
                                    TextEditingController(
                                        text: v.user.sp.car_number),
                                    label: S.current.carNumber,
                                    enabled: false,
                                  ),
                                ),
                              ],
                            ),
                            setHeightSpace(10),
                            authTextFiled(
                              TextEditingController(text: v.user.sp.car_color),
                              label: S.current.carColor,
                              enabled: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    setHeightSpace(15),
                  ],

                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: authTextFiled(
                                  fName,
                                  label: S.current.fName,
                                  enabled: false,
                                ),
                              ),
                              setWithSpace(10),
                              Expanded(
                                child: authTextFiled(
                                  lName,
                                  label: S.current.lName,
                                  enabled: false,
                                ),
                              ),
                            ],
                          ),
                          setHeightSpace(15),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: InternationalPhoneNumberInput(
                              isEnabled: false,
                              onInputChanged: (v) => null,
                              selectorTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              initialValue: number,
                              inputDecoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 20, 0),
                                hintText: S.current.phoneNumber,
                                border: border(Colors.grey.shade300),
                                focusedBorder: border(Colors.grey.shade300),
                                enabledBorder: border(Colors.grey.shade300),
                                errorBorder: border(Colors.red),
                                disabledBorder: border(Colors.grey),
                                fillColor: Colors.grey.shade300,
                                filled: true,
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
                        ],
                      ),
                    ),
                  ),

                  setHeightSpace(15),
                  //
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: globalText(
                      S.current.weWillNeverShareYourData,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ),

                  // user.sp.category.slug.contains('other')
                  // globalText('car type : ${user.sp.car_type}'),
                  // globalText('car model : ${user.sp.car_model}'),
                  // globalText('car year : ${user.sp.car_year}'),
                  // globalText('car number : ${user.sp.car_number}'),
                  // globalText('car color : ${user.sp.car_color}'),

                  setHeightSpace(30),

                  // globalButton(S.current.update, () async {
                  //   FocusScope.of(context).unfocus();
                  //   if (this._formKey.currentState!.validate()) {
                  //     this._formKey.currentState!.save();
                  //     await authProvider.updateUserApi(context, {
                  //       'first_name': fName.text,
                  //       // 'last_name': lName.text,
                  //       // 'phone': number.phoneNumber,
                  //       // 'birth_day': birthDay.text,
                  //     });
                  //   }
                  // }),

                  setHeightSpace(30),
                ],
              ),
            ),
          );
        },
      ),
      //
    );
  }
}
