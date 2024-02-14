import 'package:service_provider/Pages/Wallet/walletPopUp.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, v, __) {
        return Row(
          children: [
            // Container(
            //   child: Image(image: LogoImage.logoNoBack),
            //   height: 60,
            //   width: 60,
            // ),
            Spacer(),
            InkWell(
              onTap: () => walletPopUp(context),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wallet,
                      color: AppColor.orange,
                      size: 20,
                    ),
                    setWithSpace(5),
                    globalText(
                      v.user.wallet.toStringAsFixed(2),
                      style: TextStyle(
                        color: AppColor.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    setWithSpace(5),
                    globalText(
                      S.current.jd,
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
