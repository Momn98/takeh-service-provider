import 'package:service_provider/Pages/Stander-Pages/SplashScreen.dart';
import 'package:service_provider/Provider/UserRealTimeProvider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:service_provider/Provider/LocationProvider.dart';
import 'package:service_provider/Provider/RealTimeProvider.dart';
import 'package:service_provider/Provider/QrCodeProvider.dart';
import 'package:service_provider/Provider/TabBarProvider.dart';
import 'package:service_provider/Provider/OrderProvider.dart';
import 'package:service_provider/Provider/SignProvider.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Provider/HomeProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:service_provider/Shared/Providers.dart';
import 'package:service_provider/firebase_options.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/Shared/FCM.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wakelock/wakelock.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// Flutter version 3.16.3 on channel stable
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // if (message.data['page'].contains('order')) {
  if (message.notification != null) {
    NotificationService.showNotification(
      title: message.notification!.title.toString(),
      body: message.notification!.body.toString(),
    );
  }
  // }

  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  await NotificationService.initializeNotification();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: providers,
      child: TheMainApp(),
    );
  }
}

late TabBarProvider tabBarProvider;
late AuthProvider authProvider;
late SignProvider signProvider;
late HomeProvider homeProvider;
late QrCodeProvider qrCodeProvider;
late LocationProvider locationProvider;
late RealTimeProvider realTimeProvider;
late UserRealTimeProvider userRealTimeProvider;
late OrderProvider orderProvider;

class TheMainApp extends StatefulWidget {
  @override
  State<TheMainApp> createState() => _TheMainAppState();
}

class _TheMainAppState extends State<TheMainApp> {
  @override
  void initState() {
    Wakelock.enable();
    tabBarProvider = Provider.of<TabBarProvider>(context, listen: false);
    realTimeProvider = Provider.of<RealTimeProvider>(context, listen: false);
    userRealTimeProvider =
        Provider.of<UserRealTimeProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    signProvider = Provider.of<SignProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    qrCodeProvider = Provider.of<QrCodeProvider>(context, listen: false);
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarProvider>(
      builder: (_, v, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: v.locale,
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: S.current.appName,
          home: SplashScreen(),
        );
      },
    );
  }
}

// https://www.google.com/maps/dir/31.959413,35.8643556/31.9568787,35.8479273/@31.9587111,35.8696116,15z/data=!3m1!4b1!4m6!4m5!1m1!4e1!1m1!4e1!3e0?entry=ttu

// 31.959603,35.864312
// 31.956869,35.847903