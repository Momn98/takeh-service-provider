import 'package:flutter/material.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';

// ignore: must_be_immutable
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar({
    Key? key,
    this.preferredSize = const Size.fromHeight(56),
    this.bottomPreferredSize = const Size.fromHeight(0),
    this.showLanguage = false,
    this.showNotification = false,
    this.showSetting = false,
    this.showMenuBar = false,
    this.showSupport = false,
    this.showBack = false,
    this.hideBack = false,
    this.extra = const [],
    this.text,
    this.style = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 15,
    ),
    this.color,
    this.iconColor,
    this.elevation = 1,
    this.leading,
    this.bottom,
  }) : super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final Size bottomPreferredSize; // default is 56.0

  final bool showLanguage;
  final bool showNotification;
  final bool showSetting;
  final bool showMenuBar;
  final bool showSupport;
  final bool showBack;
  final bool hideBack;
  List<Widget> extra = [];

  final String? text;
  final TextStyle style;
  final Color? color;
  final Color? iconColor;
  final double? elevation;
  final Widget? leading;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // foregroundColor: Colors.red,
      // shadowColor: Colors.red,
      // surfaceTintColor: Colors.red,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: color ?? AppColor.primary,
      //   // <-- SEE HERE
      //   statusBarIconBrightness: Brightness.dark,
      //   // <-- For Android SEE HERE (dark icons)
      //   statusBarBrightness: Brightness.dark,
      //   // <-- For iOS SEE HERE (dark icons)
      // ),
      leading: leading,
      centerTitle: true,
      toolbarHeight: preferredSize.height,
      iconTheme: IconThemeData(color: iconColor ?? Colors.black, size: 30),
      backgroundColor: color ?? Colors.white,
      elevation: color == Colors.transparent ? 0 : elevation,
      title: text != null ? globalText(text!, style: style) : SizedBox(),

      actions: [
        for (Widget extr in extra) extr,
        if (extra.length > 0) setWithSpace(10),
      ],

      //
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: bottom ?? Container(),
      ),
    );
  }

  Widget appbarButtons(void Function()? onTap, text) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 5),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: text is String
              ? globalText(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                )
              : text is IconData
                  ? Icon(text, color: AppColor.orange)
                  : text,
        ),
      ),
    );
  }
}
