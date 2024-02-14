import 'package:service_provider/Models/FirebaseNotification.dart';
import 'package:service_provider/Models/Slider.dart' as s;
import 'package:service_provider/Models/Category.dart';
import 'package:service_provider/Api/HomeApi.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/StaticPage.dart';
import 'package:service_provider/Models/WalletTransaction.dart';

class HomeProvider extends ChangeNotifier {
  HomeApi _api = HomeApi();

  start() async {
    await this.getHomeData();
    return;
  }

  // HomeProvider() {
  //   start();
  // }

  List<s.Slider> _sliders = [];
  List<s.Slider> get sliders => _sliders;
  set sliders(List<s.Slider> sliders) => _sliders = sliders;

  List<Category> _categorys = [];
  List<Category> get categorys => _categorys;
  set categorys(List<Category> categorys) => _categorys = categorys;

  getHomeData() async {
    Map homeData = await this._api.getHome();

    this.categorys = homeData['categorys'];
    this.sliders = homeData['sliders'];
  }

  int notificationsCount = 0;
  List<FirebaseNotification> _notifications = [];
  List<FirebaseNotification> get notifications => _notifications;
  set notifications(List<FirebaseNotification> notifications) {
    _notifications = notifications;
  }

  int _notifiPage = 1;
  bool haveMoreNotifications = true;

  clear() {
    _notifications = [];
    _notifiPage = 1;
    haveMoreNotifications = true;
  }

  getNotifications() async {
    List<FirebaseNotification> notifications =
        await _api.getNotifications(_notifiPage);

    _notifications.addAll(notifications);
    _notifiPage++;

    if (notifications.length < 15) haveMoreNotifications = false;

    notifyListeners();
  }

  StaticPage staticPage = StaticPage();
  bool haveStaticPage = false;
  getPoliciesApi(String page) async {
    haveStaticPage = false;
    staticPage = StaticPage();
    await _api.getStaticPage(page).then((value) {
      staticPage = value;
      haveStaticPage = true;
    });

    notifyListeners();
  }

  List<WalletTransaction> _transactions = [];
  List<WalletTransaction> get transactions => _transactions;
  set transactions(List<WalletTransaction> transactions) {
    _transactions = transactions;
  }

  int _transactionsPage = 1;
  bool haveMoreTransactions = true;

  clearTrans() {
    this.transactions = [];
    _transactionsPage = 1;
    haveMoreTransactions = true;
  }

  getWalletTransactions() async {
    List<WalletTransaction> _transactions =
        await _api.getWalletTransactions(_transactionsPage);

    this.transactions.addAll(_transactions);
    _transactionsPage++;

    if (transactions.length < 15) haveMoreTransactions = false;

    notifyListeners();
  }
}
