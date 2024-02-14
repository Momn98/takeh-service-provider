import 'package:service_provider/Models/Option.dart';

class Question {
  int id = 0;
  String slug = '';
  String type = '';
  bool is_enabled = true;
  bool is_req = true;
  int min_val = 0;
  String name = '';
  String desc = '';
  //
  List<Option> options = [];

  int min = 0;
  int max = 0;
  int inRow = 0;
  double height = 0;
  String layout = 'GridView';

  Question({
    this.id = 0,
    this.slug = '',
    this.type = '',
    this.is_enabled = true,
    this.is_req = true,
    this.min_val = 0,
    this.name = '',
    this.desc = '',
    this.min = 0,
    this.max = 0,
    this.inRow = 0,
    this.layout = 'GridView',
  });

  Question.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.type = data['type'];
    } catch (e) {}
    try {
      this.is_enabled = data['is_enabled'];
    } catch (e) {}
    try {
      this.is_req = data['is_req'];
    } catch (e) {}
    try {
      this.min_val = data['min_val'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}
    try {
      this.desc = data['desc'];
    } catch (e) {}

    this.options = [];
    try {
      if (data['options'] != null)
        for (var element in data['options'])
          this.options.add(Option.fromAPI(element));
    } catch (e) {}

    try {
      if (this.type == 'slider') {
        if (this.slug.contains('{min=') && this.slug.contains('=min}')) {
          String start = '{min=';
          String end = '=min}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.min = int.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    try {
      if (this.type == 'slider') {
        if (this.slug.contains('{max=') && this.slug.contains('=max}')) {
          String start = '{max=';
          String end = '=max}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.max = int.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{row=') && this.slug.contains('=row}')) {
          String start = '{row=';
          String end = '=row}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.inRow = int.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{height=') && this.slug.contains('=height}')) {
          String start = '{height=';
          String end = '=height}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.height = double.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    //
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{layout=') && this.slug.contains('=layout}')) {
          String start = '{layout=';
          String end = '=layout}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.layout =
                this.slug.substring(startIndex + start.length, endIndex);
          } catch (e) {}
        }
      }
    } catch (e) {}
  }
}
