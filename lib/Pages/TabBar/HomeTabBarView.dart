import 'package:quick_nav/quick_nav.dart';
import 'package:service_provider/Pages/Stander-Pages/NotificationListPage.dart';
import 'package:service_provider/Pages/Stander-Pages/UpdateAppPage.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:service_provider/Pages/Orders/OrderListPage.dart';
import 'package:service_provider/Pages/Account/AccountPage.dart';
import 'package:service_provider/Pages/Home/HomePage.dart';
import 'package:service_provider/Pages/TabBar/supportPopUp.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/FCM.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/SharedManaged.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeTabBarView extends StatefulWidget {
  const HomeTabBarView({super.key});

  @override
  State<HomeTabBarView> createState() => _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<HomeTabBarView>
    with WidgetsBindingObserver {
  List<Widget> pages = [
    HomePage(),
    // ScanQrPage(),
    OrderListPage(),
    Container(),
    NotificationListPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    QuickNav.I.checkPermission().then((value) {
      if (!value!) QuickNav.I.askPermission();
    });
    homeProvider.start();

    realTimeProvider.connect();
    userRealTimeProvider.linkToUser(context);

    Future.delayed(Duration(seconds: 1), () {
      Fcm.initConfigure(context);
    });

    Timer(Duration(seconds: 1), () {
      if (tabBarProvider.setting.app_version > appVersion)
        NavMoveNoReturn.goToPage(context, UpdateAppPage());
    });

    // locationProvider.getLocation(context);

    super.initState();
  }

  @override
  void dispose() {
    locationProvider.controller = Completer();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    QuickNav.I.initService(screenHeight: MediaQuery.sizeOf(context).height);

    bool isBackGround = state == AppLifecycleState.paused;

    if (!isBackGround) {
      orderProvider.getActiveOrder(context);
      orderProvider.getNorRatedOrder(context);
      QuickNav.I.stopService();
    } else {
      QuickNav.I.startService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey.shade100,
        body: DoubleBackToCloseApp(
          child: pages[SharedManager.shared.currentIndex],
          // child: HomePage(),
          snackBar: SnackBar(
            backgroundColor: Colors.black,
            content: globalText(
              S.current.tapBackAgain,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: SharedManager.shared.currentIndex,
          onTap: (int id) {
            if (!mounted) return;
            if (id == 2) return supportPopUp(context);
            setState(() => SharedManager.shared.currentIndex = id);
            authProvider.getWallet();
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: AppColor.orange,
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontFamily: tabBarProvider.locale.languageCode == 'ar'
                ? Familys.Tajawal_Regular
                : Familys.futura_medium_bt,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontFamily: tabBarProvider.locale.languageCode == 'ar'
                ? Familys.Tajawal_Regular
                : Familys.futura_medium_bt,
          ),
          items: [
            navItem(IconSvg.home, S.current.home),
            // navItem(IconSvg.scan, S.current.scan),
            navItem(IconSvg.orders, S.current.orders),
            navItem(IconSvg.support, S.current.support),
            navItem(IconSvg.notification, S.current.notifications),
            navItem(IconSvg.profile, S.current.profile),
          ],
        ),
      ),
    );
  }

  //
  BottomNavigationBarItem navItem(String icon, String? label) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, height: 20),
      activeIcon: Image.asset(icon, height: 20, color: AppColor.orange),
      label: label,
    );
  }
}
