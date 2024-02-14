import 'dart:async';

import 'package:service_provider/Pages/Auth/SelectLangCountryFirstTime.dart';
import 'package:service_provider/Pages/Stander-Pages/BlockedPage.dart';
import 'package:service_provider/Pages/Stander-Pages/PendingPage.dart';
import 'package:service_provider/Models/ServiceProviderLocation.dart';
import 'package:service_provider/Pages/TabBar/HomeTabBarView.dart';
import 'package:service_provider/Pages/Auth/SignUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:service_provider/Global/loadingDialog.dart';
import 'package:service_provider/Shared/SharedManaged.dart';
import 'package:service_provider/Pages/Auth/AuthView.dart';
import 'package:service_provider/Global/ChooseYesNo.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Models/User.dart';
import 'package:service_provider/Api/UserApi.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserApi _api = UserApi();
  User user = User();

  bool isLogIn = false;
  bool isFirstTime = false;

  set userIn(bool val) {
    this.isLogIn = val;
    SharedPreferences.getInstance().then((value) {
      value.setBool(SharedKeys.isLogedIn, this.isLogIn);
    });
  }

  Future<bool> get isUserLogIn async {
    await SharedPreferences.getInstance().then((value) {
      this.isLogIn = value.getBool(SharedKeys.isLogedIn) ?? false;
    });
    return this.isLogIn;
  }

  setFirstTime() {
    SharedPreferences.getInstance().then((value) {
      value.setBool(SharedKeys.isFirstTime, false);
    });
    this.isFirstTime = false;
  }

  checkIfUserLogin(BuildContext context) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    isLogIn = pre.getBool(SharedKeys.isLogedIn) ?? false;
    isFirstTime = pre.getBool(SharedKeys.isFirstTime) ?? true;

    if (isFirstTime)
      return NavMoveNoReturn.goToPage(context, SelectLangCountryFirstTime());

    if (!isLogIn) return NavMoveNoReturn.goToPage(context, AuthView());

    getUser(context);
  }

  // bool _showPassword = false;
  // bool get showPassword => _showPassword;
  // set showPassword(bool value) {
  //   _showPassword = value;
  // }

  Future chickThe(
    BuildContext context,
    Map data, {
    bool isByLogin = true,
  }) async {
    loadingDialog(context);

    _api
        .checkPhone(data, show: isByLogin, isLogin: isByLogin)
        .then((value) async {
      NavMove.closeDialog(context);

      if (isByLogin && value['can_login'])
        return NavMove.goOTPPage(context, data, true);

      if (isByLogin && value['can_sign_up']) {
        var res = await chooseYesNoDialog(
          context,
          S.current.userNotFound,
          extraText: S.current.phoneNumberNotRejecteredWithAnyUser,
        );

        if (res != null && res['choose']) {
          signProvider.isLogin = false;

          return NavMoveNoReturn.goToPage(context, SignUpPage());
        }
      }

      notifyListeners();
      return;
    });
  }

  getUser(BuildContext context, {bool moveAfterDone = true}) {
    _api.getUser().then((value) async {
      if (value['good']) {
        this.user = value['user'];

        if (this.user.status == 'pending')
          return NavMoveNoReturn.goToPage(context, PendingPage());
        else if (this.user.status == 'blocked')
          return NavMoveNoReturn.goToPage(context, BlockedPage());

        notifyListeners();
        if (moveAfterDone)
          return NavMoveNoReturn.goToPage(context, HomeTabBarView());
      } else {
        if (moveAfterDone) return NavMoveNoReturn.goToPage(context, AuthView());
      }
    });
  }

  logIn(BuildContext context, Map data, bool showMessage) async {
    loadingDialog(context);
    _api.logIn(data).then((value) {
      NavMove.closeDialog(context);
      if (value != null && value != false) {
        this.isLogIn = true;
        this.user = value['user'];

        if (this.user.status == 'pending')
          return NavMoveNoReturn.goToPage(context, PendingPage());
        else if (this.user.status == 'blocked')
          return NavMoveNoReturn.goToPage(context, BlockedPage());

        // walletProvider.wallet = this.user.wallet;
        notifyListeners();
        NavMoveNoReturn.goToPage(context, HomeTabBarView());
      }
    });
  }

  signUp(BuildContext context, Map data, bool showMessage) async {
    loadingDialog(context);
    // bool isExest =
    //     await _api.checkPhone(data, show: showMessage, isLogin: false);

    // if (isExest) return screenMessage(S.current.alredyHaveAccount);
    // if (!isExest)

    // screenMessage("BEFORE SIGNUP");

    await _api.signUp(data).then((value) {
      // screenMessage("IN SIGNUP");
      NavMove.closeDialog(context);
      // screenMessage("IN ${value}");
      if (value != null && value != false) {
        if (value['good']) {
          this.user = value['user'];

          isLogIn = true;

          if (this.user.status == 'pending')
            return NavMoveNoReturn.goToPage(context, PendingPage());
          else if (this.user.status == 'blocked')
            return NavMoveNoReturn.goToPage(context, BlockedPage());

          NavMoveNoReturn.goToPage(context, HomeTabBarView());
        }
      }
    });

    // screenMessage("AFTER SIGNUP");
  }

  updateUserApi(BuildContext context, Map data) async {
    loadingDialog(context);
    this.user = await _api.updateUserInfo(data);
    screenMessage(S.current.updated);
    NavMove.closeDialog(context);
    notifyListeners();

    if (this.user.status == 'pending')
      return NavMoveNoReturn.goToPage(context, PendingPage());
    else if (this.user.status == 'blocked')
      return NavMoveNoReturn.goToPage(context, BlockedPage());
  }

  logOut(BuildContext context) async {
    loadingDialog(context);

    // try {
    //   realTimeProvider.pusher.unsubscribe('private-user.${user.id}');
    // } catch (e) {}

    await _api.logout();

    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferences.setBool(SharedKeys.isLogedIn, false);
    _sharedPreferences.setBool(SharedKeys.isFirstTime, true);
    _sharedPreferences.setString(SharedKeys.token, '');

    isLogIn = false;
    SharedManager.shared.currentIndex = 0;
    user = User();

    NavMove.closeDialog(context);
    NavMoveNoReturn.goMain(context);
  }

  //
  //
  //
  //
  ServiceProviderLocation _location = ServiceProviderLocation();
  ServiceProviderLocation get location => _location;
  set location(ServiceProviderLocation value) {
    _location = value;
    notifyListeners();
  }

  bool get driverStatus {
    if (_location.status == 'online') return true;
    if (_location.status == 'offline') return false;
    if (_location.status == 'busy') return false;

    return false;
  }

  changeStatus(BuildContext context) async {
    if (_location.status == 'busy') return;

    if (authProvider.user.sp.category.percentage > 0) {
      if (authProvider.user.wallet <= 0.25 && _location.status == 'offline')
        return screenMessage(S.current.noEnoughCashInWalletPleaseRecharge);
    }

    loadingDialog(context);

    Map data = {'location_status': 'offline'};

    if (_location.status == 'offline') {
      data['location_status'] = 'online';
    }

    this.user = await _api.updateUserInfo(data);

    location.status = data['location_status'];

    screenMessage(S.current.updated);
    NavMove.closeDialog(context);
    notifyListeners();
    if (this.user.status == 'pending')
      return NavMoveNoReturn.goToPage(context, PendingPage());
    else if (this.user.status == 'blocked')
      return NavMoveNoReturn.goToPage(context, BlockedPage());
  }

  bool codeSend = false;
  Future<bool> sendOtpCode(BuildContext context, String phone, String signature,
      {bool withLoading = true}) async {
    codeSend = false;
    if (withLoading) loadingDialog(context);

    bool res = await _api.sendOtpCode(phone, signature);

    if (withLoading) NavMove.closeDialog(context);
    // if (withLoading)
    notifyListeners();

    if (res) restartTimer();

    codeSend = res;

    return res;
  }

  Future<bool> checkOtpCode(
      BuildContext context, String phone, String code) async {
    loadingDialog(context);

    bool res = await _api.checkOtpCode(phone, code);

    NavMove.closeDialog(context);

    return res;
  }

  deleteAccount(BuildContext context) async {
    loadingDialog(context);

    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isDelete = await _api.deleteAccount();

    if (isDelete) {
      _sharedPreferences.setBool(SharedKeys.isLogedIn, false);
      _sharedPreferences.setString(SharedKeys.token, '');
      _sharedPreferences.setBool(SharedKeys.isFirstTime, true);

      isLogIn = false;
      SharedManager.shared.currentIndex = 0;
      user = User();
      NavMoveNoReturn.goMain(context);
    }
  }

  int timeDown = 30;
  bool stop = false;

  countDown() {
    if (timeDown == 0) return;
    if (stop) return;

    Timer(Duration(seconds: 1), () {
      timeDown--;
      notifyListeners();
      return countDown();
    });
  }

  restartTimer() {
    timeDown = 30;

    countDown();
  }

  getWallet() {
    _api.getUser().then((value) async {
      if (value['good']) {
        this.user.wallet = value['user'].wallet;

        notifyListeners();
      }
    });
  }
}
