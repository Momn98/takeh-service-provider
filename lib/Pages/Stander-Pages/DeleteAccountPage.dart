import 'package:service_provider/Global/ChooseYesNo.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:flutter/material.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(text: S.current.deleteAccount),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  setHeightSpace(20),
                  globalText(
                    S.current.deleteThisAccount,
                    style: TextStyle(fontSize: 21),
                  ),
                  setHeightSpace(10),
                  globalText(
                    S.current.doYouWantToDeleteThisAccount,
                  ),
                  setHeightSpace(20),
                  globalText(
                    S.current.deleteParagraph,
                  ),
                  setHeightSpace(10),
                  InkWell(
                    onTap: () => launchUrlString('mailto:info@takeh.com'),
                    child: Row(
                      children: [
                        globalText(S.current.email),
                        setWithSpace(5),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: globalText(S.current.deleteEmail),
                        ),
                      ],
                    ),
                  ),
                  setHeightSpace(5),
                  // InkWell(
                  //   onTap: () => launchUrlString('tel:+962782562016'),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       globalText(S.current.phoneNumber),
                  //       setWithSpace(5),
                  //       Directionality(
                  //         textDirection: TextDirection.ltr,
                  //         child: globalText(S.current.deletePhone),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  setHeightSpace(20),
                  globalText(S.current.doYouWantToContinue),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              var popRes = await chooseYesNoDialog(
                context,
                S.current.confirmDeleteThisAccount,
                yesText: S.current.yes,
                yesColor: hexToColor('#C00202'),
                noText: S.current.no,
                noColor: Colors.green,
              );

              if (popRes != null && popRes['choose']) {
                authProvider.deleteAccount(context);
              }
            },
            child: Card(
              elevation: 4,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: globalText(
                  S.current.theDelete,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
