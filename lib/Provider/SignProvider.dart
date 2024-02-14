import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:service_provider/Models/Category.dart';
import 'package:service_provider/Models/Country.dart';
import 'package:service_provider/Models/City.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SignProvider extends ChangeNotifier {
  SignProvider() {
    clear();
  }

  clear() {
    isLogin = true;
    formKeyLogin = new GlobalKey<FormState>();
    formKeySignUp = new GlobalKey<FormState>();
    formKeySignUpPersonalInfo = new GlobalKey<FormState>();
    formKeySignUpWorkInfo = new GlobalKey<FormState>();
    number = PhoneNumber(isoCode: 'JO');
    _acceptTerms = false;
    _errorAcceptTerms = false;

    fName = TextEditingController();
    lName = TextEditingController();

    country = Country();
    city = City();
    category = Category();

    frontID = null;
    backID = null;
    //
    frontDriverLicense = null;
    backDriverLicense = null;
    //
    frontCarLicense = null;
    backCarLicense = null;

    signUpData = {};

    // pass = TextEditingController();
    image = null;
  }

  bool isLogin = true;
  GlobalKey<FormState> formKeyLogin = new GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignUp = new GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignUpPersonalInfo = new GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignUpWorkInfo = new GlobalKey<FormState>();
  PhoneNumber number = PhoneNumber(isoCode: 'JO');

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  // TextEditingController pass = TextEditingController();

  bool _acceptTerms = false;
  bool get acceptTerms => _acceptTerms;
  set acceptTerms(bool acceptTerms) {
    _acceptTerms = acceptTerms;
    errorAcceptTerms = false;
    notifyListeners();
  }

  bool _errorAcceptTerms = false;
  bool get errorAcceptTerms => _errorAcceptTerms;
  set errorAcceptTerms(bool errorAcceptTerms) {
    _errorAcceptTerms = errorAcceptTerms;
    notifyListeners();
  }

  Country country = Country();
  City city = City();

  Category category = Category();

  setCategory(Category category) {
    this.category = category;
    notifyListeners();
  }

  XFile? image;

  XFile? frontID;
  XFile? backID;
  //
  XFile? frontDriverLicense;
  XFile? backDriverLicense;
  //
  XFile? frontCarLicense;
  XFile? backCarLicense;

  //
  //
  List<Map> answers = [];
  int answersIndex(int id) {
    return answers.indexWhere((element) => element['question_id'] == id);
  }

  bool selectValue = false;

  //
  //
  Map signUpData = {};

  TextEditingController car_model = TextEditingController();
  TextEditingController car_type = TextEditingController();
  TextEditingController car_year = TextEditingController();
  TextEditingController car_number = TextEditingController();
  TextEditingController car_color = TextEditingController();

  setData() async {
    List<int> options = [];

    for (var answer in answers) options.add(answer['answer']);

    signUpData = {
      'sign_up_user': 'sp',
      'first_name': fName.text.toString(),
      'last_name': lName.text.toString(),
      // 'password': pass.text.toString(),
      'phone': number.phoneNumber.toString(),
      //
      'country_id': country.id.toString(),
      'city_id': city.id.toString(),
      'category_id': category.id.toString(),
      //
      'answers': jsonEncode(options),

      'car_model': car_model.text.toString(),
      'car_type': car_type.text.toString(),
      'car_year': car_year.text.toString(),
      'car_number': car_number.text.toString(),
      'car_color': car_color.text.toString(),
    };

    if (image != null) {
      try {
        List<int> imageBytes = await image!.readAsBytes();
        signUpData.addAll({
          'image': jsonEncode(base64Encode(imageBytes)),
        });
      } catch (e) {
        // screenMessage("error in read as bytes -> image");
      }
    }

    if (frontID != null) {
      try {
        List<int> imageBytes = await frontID!.readAsBytes();
        signUpData.addAll({
          'front_id': jsonEncode(base64Encode(imageBytes)),
        });
      } catch (e) {
        // screenMessage("error in read as bytes -> front_id");
      }
    }

    if (backID != null) {
      try {
        List<int> imageBytes = await backID!.readAsBytes();
        signUpData.addAll({
          'back_id': jsonEncode(base64Encode(imageBytes)),
        });
      } catch (e) {
        // screenMessage("error in read as bytes -> back_id");
      }
    }

    if (frontDriverLicense != null) {
      try {
        List<int> imageBytes = await frontDriverLicense!.readAsBytes();
        signUpData.addAll({
          'front_driver_license': jsonEncode(base64Encode(imageBytes)),
        });
      } catch (e) {
        // screenMessage("error in read as bytes -> front_driver_license");
      }
    }

    if (backDriverLicense != null) {
      try {
        List<int> imageBytes = await backDriverLicense!.readAsBytes();
        signUpData.addAll({
          'back_driver_license': jsonEncode(base64Encode(imageBytes)),
        });
      } catch (e) {
        // screenMessage("error in read as bytes -> back_driver_license");
      }
    }

    if (frontCarLicense != null) {
      try {
        List<int> imageBytes = await frontCarLicense!.readAsBytes();
        signUpData.addAll({
          'front_car_license': jsonEncode(base64Encode(imageBytes)),
        });
      } catch (e) {
        // screenMessage("error in read as bytes -> front_car_license");
      }
    }

    if (backCarLicense != null) {
      try {
        List<int> imageBytes = await backCarLicense!.readAsBytes();
        signUpData.addAll({
          'back_car_license': jsonEncode(base64Encode(imageBytes)),
        });
      } catch (e) {
        // screenMessage("error in read as bytes -> back_car_license");
      }
    }
  }
}
