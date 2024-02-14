import 'package:flutter/material.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Global/SocialMedia.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/i18n.dart';

class BlockedPage extends StatelessWidget {
  const BlockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(
        preferredSize: Size.fromHeight(75),
        color: Colors.transparent,
        elevation: 0,
        text: S.current.sorryYourAccountBlocked,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GlobalImage.unlock,
          ),
          setHeightSpace(30),
          globalText(
            S.current.pleaseContactUsToRemoveBlock,
            style: TextStyle(fontSize: 17),
          ),
          setHeightSpace(20),
          // globalText(
          //   S.current.or,
          //   style: TextStyle(fontSize: 17),
          // ),
          // setHeightSpace(20),
          // globalButton(
          //   S.current.signOut,
          //   () => authProvider.logOut(context),
          // ),
          SocialMedia(),
          setHeightSpace(20),
        ],
      ),
    );
  }
}
