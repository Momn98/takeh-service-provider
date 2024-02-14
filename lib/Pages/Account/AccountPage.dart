import 'package:service_provider/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:service_provider/Pages/Account/ExtraSettingPage.dart';
import 'package:service_provider/Pages/Account/ProfilePage.dart';
import 'package:service_provider/Pages/Wallet/WalletCard.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:service_provider/Pages/Auth/AuthView.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_provider/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    authProvider.getWallet();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(
        preferredSize: Size.fromHeight(0),
        color: Colors.transparent,
        elevation: 0,
      ),
      vertical: 0,
      horizontal: 0,
      body: Consumer<AuthProvider>(
        builder: (_, v, __) {
          return Column(
            children: [
              Container(
                // padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: WalletCard(),
              ),
              setHeightSpace(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (v.isLogIn)
                        Row(
                          children: [
                            setWithSpace(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  globalText(v.user.name),
                                  setHeightSpace(5),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: globalText(v.user.phone),
                                  ),
                                  setHeightSpace(5),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: v.user.rate,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      onRatingUpdate: (rating) => null,
                                      itemBuilder: (context, _) =>
                                          Icon(Icons.star, color: Colors.amber),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: v.isLogIn
                                    ? NetworkImagePlace(
                                        image: v.user.image,
                                        fit: BoxFit.cover,
                                        all: 90,
                                      )
                                    : Image(image: LogoImage.logo),
                              ),
                            ),
                            setWithSpace(20),
                          ],
                        ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: NetworkImagePlace(
                                image: v.user.sp.category.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            setWithSpace(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                globalText(
                                  v.user.sp.category.name,
                                  maxLines: 2,
                                ),
                                if (v.user.sp.work_option.id > 0)
                                  globalText(
                                    v.user.sp.work_option.name,
                                    maxLines: 2,
                                  ),
                                setHeightSpace(10),
                              ],
                            ),
                          ],
                        ),
                      ),

                      setHeightSpace(30),
                      // settingIcon(
                      //     IconImage.history, S.current.rideHistory, () {
                      //   Scaffold.of(context).closeDrawer();
                      //   NavMove.goToPage(context, RideHistoryPage(),
                      //       mustLogin: true);
                      // }),

                      settingIcon(
                        Icons.account_circle_outlined,
                        S.current.account,
                        () => NavMove.goToPage(context, ProfilePage(),
                            mustLogin: true),
                      ),

                      settingIcon(
                        Icons.settings_outlined,
                        S.current.settings,
                        () => NavMove.goToPage(context, ExtraSettingPage()),
                      ),

                      settingIcon(Icons.share_outlined, S.current.shareApp, () {
                        FlutterShare.share(
                          title: S.current.shareAppNow,
                          text: S.current.shareAppNow,
                          linkUrl: tabBarProvider.setting.share_link + '/share',
                        );
                      }),

                      settingIcon(
                        Icons.info_outline,
                        S.current.aboutApp,
                        () => NavMove.goToPage(
                            context, PoliciesPage(page: 'about-app')),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  setHeightSpace(20),
                  if (v.isLogIn)
                    settingIcon(
                      Icons.login_outlined,
                      S.current.signOut,
                      () => v.logOut(context),
                      color: Colors.grey,
                      under: false,
                      arrow: false,
                      iconColor: Colors.red,
                    )
                  else
                    settingIcon(
                      Icons.power_settings_new_outlined,
                      S.current.logIn,
                      () => NavMove.goToPage(context, AuthView()),
                      iconColor: Colors.green,
                      under: false,
                      arrow: false,
                    ),

                  //
                  InkWell(
                    onTap: () =>
                        NavMove.goToPage(context, PoliciesPage(page: 'terms')),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 20, 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: globalText(
                              S.current.termsAndCondition,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          globalText(
                            '${S.current.appName} 2023',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget settingIcon(
    var image,
    String? name,
    Function()? toDo, {
    String? extraText,
    Color? extraColor,
    Color? color,
    Color? iconColor,
    bool under = true,
    bool arrow = true,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: toDo,
        child: Container(
          // decoration: BoxDecoration(
          //   border: under ? Border(bottom: BorderSide(width: 0.4)) : null,
          // ),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image is AssetImage) ...[
                Image(image: image, height: 25),
              ] else if (image is IconData) ...[
                Icon(image, color: iconColor ?? Colors.black)
              ] else if (image is Icon) ...[
                image
              ] else if (image.contains('.svg')) ...[
                SvgPicture.asset(
                  image,
                  color: iconColor ?? AppColor.secondary,
                  height: 35,
                  width: 20,
                ),
              ],
              setWithSpace(15),
              if (name != null)
                globalText(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              setWithSpace(15),
            ],
          ),
        ),
      ),
    );
  }
}
