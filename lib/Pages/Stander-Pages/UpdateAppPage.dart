import 'package:open_store/open_store.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Shared/i18n.dart';

class UpdateAppPage extends StatelessWidget {
  const UpdateAppPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      body: Column(
        children: [
          setHeightSpace(50),
          Center(
            child: Container(
              width: 300,
              height: 300,
              child: Image(image: LogoImage.logoNoBack),
            ),
          ),
          setHeightSpace(50),
          globalButton(
            S.current.pleaseUpdateApp,
            () {
              OpenStore.instance.open(
                // AppStore id of your app for iOS
                // appStoreId: '6460545024',
                // Android app bundle package name
                androidAppBundleId: 'com.takeh.service_provider',
              );
            },
            backColor: Colors.transparent,
            borderColor: AppColor.orange,
            textColor: AppColor.orange,
          ),
          setHeightSpace(50),
        ],
      ),
    );
  }
}
