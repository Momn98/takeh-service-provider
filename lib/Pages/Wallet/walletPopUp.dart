import 'package:service_provider/Models/WalletTransaction.dart';
import 'package:service_provider/Provider/AuthProvider.dart';
import 'package:service_provider/Provider/HomeProvider.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/main.dart';

walletPopUp(BuildContext context) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WalletWidget();
    },
  );
}

class WalletWidget extends StatefulWidget {
  const WalletWidget({super.key});

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  ScrollController _sc = ScrollController();

  @override
  void initState() {
    homeProvider.clearTrans();

    homeProvider.getWalletTransactions();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent)
        homeProvider.getWalletTransactions();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer2<HomeProvider, AuthProvider>(
        builder: (_, v, v2, __) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                setHeightSpace(10),
                Stack(
                  children: [
                    Center(
                      child: globalText(
                        S.current.showBalance,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //
                    PositionedDirectional(
                      end: 0,
                      child: InkWell(
                        onTap: () => NavMove.closeDialog(context),
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Divider(),
                setHeightSpace(20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      globalText(
                        '${v2.user.wallet.toStringAsFixed(2)} ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                      setWithSpace(5),
                      globalText(
                        S.current.jd,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                        ),
                        child: globalText(
                          S.current.availableBalance,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                setHeightSpace(20),
                if (v.transactions.length == 0) ...[
                  setHeightSpace(50),
                  if (v.haveMoreTransactions)
                    Center(child: CircularProgressIndicator())
                  else
                    Center(child: globalText(S.current.noTransactions)),
                ],
                Expanded(
                  child: SingleChildScrollView(
                    controller: _sc,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: v.transactions.length,
                      itemBuilder: (context, index) {
                        WalletTransaction trans = v.transactions[index];

                        return Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: globalText(
                                        '${S.current.transactionID}: ${trans.id}',
                                      ),
                                    ),
                                    globalText(
                                      trans.status.name,
                                      style: TextStyle(
                                        color: trans.status.color,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 0.5),
                                if (trans.note.id > 0)
                                  globalText(trans.note.name),
                                //
                                globalText(
                                    '${S.current.theAmount}: ${trans.amount.toStringAsFixed(2)}'),
                                setHeightSpace(10),
                                Divider(),
                                globalText(
                                  '${S.current.date}: ${trans.created_at}',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
}
