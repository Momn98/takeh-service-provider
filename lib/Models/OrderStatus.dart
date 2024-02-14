import 'package:flutter/material.dart';
import 'package:service_provider/Shared/Constant.dart';

class OrderStatus {
  int id = 0;
  String slug = '';
  String name = '';
  Color color = Colors.black;

  OrderStatus({
    this.id = 0,
    this.slug = '',
    this.name = '',
    this.color = Colors.black,
  });

  OrderStatus.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}
    try {
      this.color = hexToColor(data['color']);
    } catch (e) {}
  }
}
