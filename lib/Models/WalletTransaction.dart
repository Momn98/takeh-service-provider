import 'package:service_provider/Models/WalletNote.dart';
import 'package:service_provider/Models/WalletStatus.dart';

Future<List<WalletTransaction>> loopWalletTransactions(List data) async {
  List<WalletTransaction> _arr = [];
  for (var item in data) _arr.add(WalletTransaction.fromAPI(item));
  return _arr;
}

class WalletTransaction {
  int id = 0;
  String slug = '';
  double amount = 0.0;
  WalletNote note = WalletNote();
  WalletStatus status = WalletStatus();
  String text = '';

  String date = '';
  String time = '';
  String created_at = '';
  String created_ago = '';

  WalletTransaction({
    this.id = 0,
    this.slug = '',
    this.amount = 0.0,
    this.text = '',
    this.date = '',
    this.time = '',
    this.created_at = '',
    this.created_ago = '',
  });

  WalletTransaction.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.amount = data['amount'];
    } catch (e) {}
    try {
      this.note = WalletNote.fromAPI(data['wallet_note']);
    } catch (e) {}
    try {
      this.status = WalletStatus.fromAPI(data['wallet_status']);
    } catch (e) {}
    try {
      this.text = data['text'];
    } catch (e) {}

    try {
      this.date = data['date'];
    } catch (e) {}
    try {
      this.time = data['time'];
    } catch (e) {}
    try {
      this.created_at = data['created_at'];
    } catch (e) {}
    try {
      this.created_ago = data['created_ago'];
    } catch (e) {}
  }
}
