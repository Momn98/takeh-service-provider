import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FindNewOrderPopUpWidge extends StatefulWidget {
  const FindNewOrderPopUpWidge({super.key});
  @override
  State<FindNewOrderPopUpWidge> createState() => _FindNewOrderPopUpWidgeState();
}

class _FindNewOrderPopUpWidgeState extends State<FindNewOrderPopUpWidge> {
  bool inTrip = false;
  bool serviceStarted = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<AuthProvider>(
        builder: (_, v, __) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                setHeightSpace(20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: globalButton(
                    !v.driverStatus
                        ? S.current.clickToStartWork
                        : S.current.clickToTakeBreak,
                    () => v.changeStatus(context),
                    backColor: v.driverStatus ? Colors.green : null,
                    borderColor: v.driverStatus ? Colors.green : null,
                  ),
                ),
                setHeightSpace(20),
              ],
            ),
          );
        },
      ),
    );
  }
}
