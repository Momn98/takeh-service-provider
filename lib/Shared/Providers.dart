import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Provider/HomeProvider.dart';
import 'package:service_provider/Provider/LocationProvider.dart';
import 'package:service_provider/Provider/OrderProvider.dart';
import 'package:service_provider/Provider/QrCodeProvider.dart';
import 'package:service_provider/Provider/RealTimeProvider.dart';
import 'package:service_provider/Provider/SignProvider.dart';
import 'package:service_provider/Provider/TabBarProvider.dart';
import 'package:service_provider/Provider/UserRealTimeProvider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<TabBarProvider>.value(value: TabBarProvider()),
  ChangeNotifierProvider<RealTimeProvider>.value(value: RealTimeProvider()),
  ChangeNotifierProvider<UserRealTimeProvider>.value(
      value: UserRealTimeProvider()),
  ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
  ChangeNotifierProvider<SignProvider>.value(value: SignProvider()),
  ChangeNotifierProvider<HomeProvider>.value(value: HomeProvider()),
  ChangeNotifierProvider<QrCodeProvider>.value(value: QrCodeProvider()),
  ChangeNotifierProvider<LocationProvider>.value(value: LocationProvider()),
  ChangeNotifierProvider<OrderProvider>.value(value: OrderProvider()),
];
