import 'package:service_provider/Models/Appimage.dart';
import 'package:service_provider/Models/Option.dart';
import 'package:service_provider/Models/Question.dart';

Future<List<Answer>> loopAnswers(List data) async {
  List<Answer> _arr = [];
  for (var item in data) _arr.add(Answer.fromAPI(item));
  return _arr;
}

class Answer {
  int id = 0;
  String slug = '';
  Question question = Question();
  String type = '';
  String answer = '';
  List<Appimage> images = [];
  // Address from_address = Address();
  // Address to_address = Address();
  Option option = Option();
  // List<Address> from_to_address = [];
  // Address to_address = Address();

  Answer({
    this.id = 0,
    this.slug = '',
    this.type = '',
    this.answer = '',
  });

  Answer.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.question = Question.fromAPI(data['question']);
    } catch (e) {}
    try {
      this.type = data['answer_type'];
    } catch (e) {}
    try {
      this.answer = data['the_answer'];
    } catch (e) {}

    this.images = [];
    try {
      if (data['images'] != null)
        for (var element in data['images'])
          this.images.add(Appimage.fromAPI(element));
    } catch (e) {}
    try {
      this.option = Option.fromAPI(data['option']);
    } catch (e) {}
  }
}
