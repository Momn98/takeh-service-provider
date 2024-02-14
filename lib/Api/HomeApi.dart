import 'package:service_provider/Models/Applang.dart';
import 'package:service_provider/Models/Country.dart';
import 'package:service_provider/Models/FirebaseNotification.dart';
import 'package:service_provider/Models/ServiceProviderLocation.dart';
import 'package:service_provider/Models/Slider.dart' as s;
import 'package:service_provider/Models/StaticPage.dart';
import 'package:service_provider/Models/Appsetting.dart';
import 'package:service_provider/Models/Category.dart';
import 'package:service_provider/Models/ApiData.dart';
import 'package:service_provider/Models/Slider.dart';
import 'package:service_provider/Api/Api_util.dart';
import 'package:service_provider/Models/WalletTransaction.dart';

class HomeApi {
  Future<Map> getAppSetting() async {
    int version = 1;
    Appsetting setting = Appsetting();
    List<Country> countrys = [];
    List<Applang> applangs = [];
    List<Category> categorys = [];

    String url = ApiUtil.App_Setting;

    ApiData response = await theGet(url);

    if (response.statusCode == 200 && response.data != null) {
      if (response.data['version'] != null) version = response.data['version'];

      if (response.data['setting'] != null)
        setting = Appsetting.fromAPI(response.data['setting']);

      if (response.data['countrys'] != null)
        countrys = await loopCountrys(response.data['countrys']);

      if (response.data['applangs'] != null)
        applangs = await loopApplangs(response.data['applangs']);

      if (response.data['categorys'] != null)
        categorys = await loopCategorys(response.data['categorys']);
    }

    return {
      'version': version,
      'setting': setting,
      'countrys': countrys,
      'applangs': applangs,
      'categorys': categorys,
    };
  }

  //
  Future<Map> getHome() async {
    List<Category> categorys = [];
    List<s.Slider> sliders = [];

    String url = ApiUtil.App_Home;
    ApiData response = await theGet(url);

    if (response.statusCode == 200 && response.data != null) {
      if (response.data['categorys'] != null)
        categorys = await loopCategorys(response.data['categorys']);

      if (response.data['sliders'] != null)
        sliders = await loopSliders(response.data['sliders']);
    }

    return {
      'categorys': categorys,
      'sliders': sliders,
    };
  }

  Future<List<FirebaseNotification>> getNotifications(int page) async {
    List<FirebaseNotification> notifications = [];

    String url = ApiUtil.Notifications + '?page=$page';
    ApiData response = await theGet(url);

    if (response.statusCode == 200)
      notifications =
          await loopFirebaseNotifications(response.data['notifications']);

    return notifications;
  }

  Future<StaticPage> getStaticPage(String pageLink) async {
    StaticPage page = StaticPage();
    String url = ApiUtil.Static_Page + '?static_page=$pageLink';
    ApiData response = await theGet(url);
    if (response.statusCode == 200)
      page = StaticPage.fromAPI(response.data['static_page']);
    return page;
  }

  //
  Future<ServiceProviderLocation?> saveLocation(Map data) async {
    String url = ApiUtil.Location;
    ApiData response = await theSend(url, data);

    if (response.statusCode == 201) {
      if (response.data != null && response.data['location'] != null)
        return ServiceProviderLocation.fromAPI(response.data['location']);
    }

    return null;
  }

  Future<List<WalletTransaction>> getWalletTransactions(int page) async {
    List<WalletTransaction> transactions = [];

    String url = ApiUtil.Wallet_Transaction + '?page=$page';
    ApiData response = await theGet(url);

    if (response.statusCode == 200)
      transactions =
          await loopWalletTransactions(response.data['transactions']);

    return transactions;
  }
}
