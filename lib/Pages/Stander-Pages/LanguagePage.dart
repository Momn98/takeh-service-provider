import 'package:flutter/material.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Models/Applang.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/SharedManaged.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(text: S.current.language),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          globalText(
            S.current.selectLanguage,
            style: TextStyle(fontSize: 23),
          ),
          setHeightSpace(10),
          globalText(S.current.pleaseSelectYourPreferredLanguage),
          setHeightSpace(30),
          GridView.builder(
            itemCount: tabBarProvider.applangs.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 150,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Applang applang = tabBarProvider.applangs[index];
              return theLang(context, applang);
            },
          ),
        ],
      ),
    );
  }

  Widget theLang(BuildContext context, Applang applang) {
    return Card(
      color: tabBarProvider.locale.languageCode == applang.code
          ? AppColor.orange.withOpacity(1)
          : null,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          tabBarProvider.changeLanguage(applang);
          SharedManager.shared.currentIndex = 0;
          tabBarProvider.start();
          NavMoveNoReturn.goMain(context);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //   child: NetworkImagePlace(image: applang.flag),
              // ),
              // setHeightSpace(5),
              globalText(applang.name),
            ],
          ),
        ),
      ),
    );
  }
}
