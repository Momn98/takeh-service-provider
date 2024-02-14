import 'package:service_provider/Models/Question.dart';

Future<List<Category>> loopCategorys(List data) async {
  List<Category> _arr = [];
  for (var item in data) _arr.add(Category.fromAPI(item));
  return _arr;
}

class Category {
  int id = 0;
  String slug = '';
  String name = '';
  String image = '';

  double employee_price = 0.0;
  String note = '';

  int percentage = 0;

  List<Question> questions = [];
  List<Question> sp_questions = [];

  Category({
    this.id = 0,
    this.slug = '',
    this.name = '',
    this.image = '',
    this.employee_price = 0.0,
    this.note = '',
    this.percentage = 0,
  });

  Category.fromAPI(Map data) {
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
      this.image = data['image'];
    } catch (e) {}
    try {
      this.employee_price = data['employee_price'] + 0.0;
    } catch (e) {}
    try {
      this.note = data['note'];
    } catch (e) {}
    try {
      this.percentage = data['percentage'] + 0;
    } catch (e) {}

    this.questions = [];
    try {
      if (data['questions'] != null)
        for (var element in data['questions'])
          this.questions.add(Question.fromAPI(element));
    } catch (e) {}

    this.sp_questions = [];
    try {
      if (data['sp_questions'] != null)
        for (var element in data['sp_questions'])
          this.sp_questions.add(Question.fromAPI(element));
    } catch (e) {}
  }
}
