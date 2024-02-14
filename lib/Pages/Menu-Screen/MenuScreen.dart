import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_provider/Pages/Account/ExtraSettingPage.dart';
import 'package:service_provider/Pages/Account/ProfilePage.dart';
import 'package:service_provider/Pages/Auth/AuthView.dart';
import 'package:service_provider/Pages/Orders/OrderListPage.dart';
import 'package:service_provider/Pages/Stander-Pages/ContactUs.dart';
import 'package:service_provider/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:service_provider/Pages/Wallet/WalletCard.dart';
import 'package:service_provider/Pages/Wallet/walletPopUp.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthProvider>(
        builder: (_, v, __) {
          return Drawer(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(40),
                bottomEnd: Radius.circular(40),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                setHeightSpace(20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  globalText("ID ${v.user.id}"),
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
                        setHeightSpace(10),
                        // WalletCard(),
                        InkWell(
                          onTap: () => walletPopUp(context),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                            ),
                            alignment: Alignment.center,
                            child: WalletCard(),
                          ),
                        ),
                        setHeightSpace(30),
                        settingIcon(S.current.orders, () {
                          Scaffold.of(context).closeDrawer();
                          NavMove.goToPage(context, OrderListPage(),
                              mustLogin: true);
                        }),
                        settingIcon(S.current.shareApp, () {
                          Scaffold.of(context).closeDrawer();
                          FlutterShare.share(
                            title: S.current.shareAppNow,
                            text: S.current.shareAppNow,
                            linkUrl:
                                tabBarProvider.setting.share_link + '/share',
                          );
                        }),
                        settingIcon(S.current.account, () {
                          Scaffold.of(context).closeDrawer();
                          NavMove.goToPage(context, ProfilePage(),
                              mustLogin: true);
                        }),
                        settingIcon(S.current.settings, () {
                          Scaffold.of(context).closeDrawer();
                          NavMove.goToPage(context, ExtraSettingPage(),
                              mustLogin: true);
                        }),
                        settingIcon(S.current.aboutApp, () {
                          Scaffold.of(context).closeDrawer();
                          NavMove.goToPage(
                              context, PoliciesPage(page: 'about'));
                        }),
                        settingIcon(
                          S.current.contactUs,
                          () {
                            Scaffold.of(context).closeDrawer();
                            NavMove.goToPage(context, ContactUsPage());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (v.isLogIn)
                  settingIcon(
                    S.current.signOut,
                    () => v.logOut(context),
                    image: Icons.login,
                    color: Colors.grey,
                    under: false,
                    arrow: false,
                    iconColor: Colors.red,
                  )
                else
                  settingIcon(
                    S.current.logIn,
                    () => NavMove.goToPage(context, AuthView()),
                    image: Icons.power_settings_new_outlined,
                    color: Colors.green,
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
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        globalText(
                          '${S.current.appName} 2024',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget settingIcon(
    String? name,
    Function()? toDo, {
    var image,
    String? extraText,
    Color? extraColor,
    Color? color,
    Color? iconColor,
    bool under = true,
    bool arrow = true,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: GestureDetector(
        onTap: toDo,
        child: Container(
          decoration: BoxDecoration(
            border: under ? Border(bottom: BorderSide(width: 0.4)) : null,
          ),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null) ...[
                if (image is AssetImage) ...[
                  Image(image: image, height: 25),
                ] else if (image is IconData) ...[
                  Icon(image, color: iconColor ?? AppColor.secondary)
                ] else if (image.contains('.svg')) ...[
                  SvgPicture.asset(
                    image,
                    color: iconColor ?? AppColor.secondary,
                    height: 35,
                    width: 20,
                  ),
                ],
                setWithSpace(15),
              ],

              //

              if (name != null)
                globalText(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: iconColor ?? null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
