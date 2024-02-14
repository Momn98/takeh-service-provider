import 'package:service_provider/Global/input.dart';
import 'package:service_provider/Provider/TabBarProvider.dart';
import 'package:service_provider/Provider/SignProvider.dart';
import 'package:service_provider/Global/HomeAppBar.dart';
import 'package:service_provider/Models/Category.dart';
import 'package:service_provider/Models/Question.dart';
import 'package:service_provider/Shared/Constant.dart';
import 'package:service_provider/Shared/Globals.dart';
import 'package:service_provider/Models/Option.dart';
import 'package:service_provider/Shared/NavMove.dart';
import 'package:service_provider/Shared/i18n.dart';
import 'package:service_provider/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SignUpPageWorkInfo extends StatefulWidget {
  const SignUpPageWorkInfo({super.key});
  @override
  State<SignUpPageWorkInfo> createState() => _SignUpPageWorkInfoState();
}

class _SignUpPageWorkInfoState extends State<SignUpPageWorkInfo> {
  bool catChange = false;

  List<String> years = [
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
  ];

  @override
  void initState() {
    super.initState();
    signProvider.category = tabBarProvider.categorys.first;
    signProvider.answers = [];
    for (Question q in signProvider.category.questions)
      signProvider.answers.add({'question_id': q.id, 'type': q.type});

    if (signProvider.category.sp_questions.length > 0) {
      signProvider.selectValue = false;
    } else {
      signProvider.selectValue = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignProvider, TabBarProvider>(
      builder: (_, v, v2, __) {
        return GlobalSafeArea(
          appBar: HomeAppBar(text: S.current.hello),
          body: SingleChildScrollView(
            child: Form(
              key: v.formKeySignUpWorkInfo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  setHeightSpace(15),
                  globalText(S.current.selectYourWorkService),
                  setHeightSpace(10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<Category>(
                      items: v2.categorys
                          .map(
                            (e) => DropdownMenuItem<Category>(
                              value: e,
                              child: globalText(e.name),
                            ),
                          )
                          .toList(),
                      isExpanded: true,
                      value: v.category,
                      underline: Container(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            catChange = true;
                          });

                          v.setCategory(value);
                          v.answers = [];

                          for (Question q in value.questions) {
                            v.answers
                                .add({'question_id': q.id, 'type': q.type});
                          }

                          if (v.category.sp_questions.length > 0)
                            v.selectValue = false;
                          else
                            v.selectValue = true;

                          setState(() {});

                          Timer.periodic(Duration(seconds: 1), (timer) {
                            if (!mounted) return;
                            setState(() {
                              catChange = false;
                            });
                          });
                        }
                      },
                    ),
                  ),
                  // 9.45
                  setHeightSpace(25),
                  //

                  if (!catChange) ...[
                    if (v.category.slug.contains('car-info')) ...[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: authTextFiled(
                                      v.car_type,
                                      label: S.current.type,
                                    ),
                                  ),
                                  //
                                  setWithSpace(10),
                                  //
                                  Expanded(
                                    child: authTextFiled(
                                      v.car_model,
                                      label: S.current.model,
                                    ),
                                  ),
                                ],
                              ),
                              setHeightSpace(10),
                              Row(
                                children: [
                                  Expanded(
                                    child: PopupMenuButton(
                                      offset: Offset(0, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: authTextFiled(
                                        v.car_year,
                                        label: S.current.year,
                                        enabled: false,
                                      ),
                                      onSelected: (value) {
                                        FocusScope.of(context).unfocus();

                                        if (value != null)
                                          v.car_year.text = value;
                                      },
                                      itemBuilder: (ctx) => [
                                        for (String year in years)
                                          popUp(context, year),
                                      ],
                                    ),
                                  ),
                                  setWithSpace(10),
                                  Expanded(
                                    flex: 2,
                                    child: authTextFiled(
                                      v.car_number,
                                      label: S.current.carNumber,
                                    ),
                                  ),
                                ],
                              ),
                              setHeightSpace(10),
                              authTextFiled(
                                v.car_color,
                                label: S.current.carColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //
                      setHeightSpace(10),
                    ],

                    //

                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: v.category.sp_questions.length,
                      itemBuilder: (context, index) {
                        Question question = v.category.sp_questions[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                if (question.type == 'options')
                                  globalText(
                                    question.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                //
                                setHeightSpace(5),
                                //
                                if (question.type == 'options') // // //
                                  OptionWidgitCard(question),
                                // //
                                // //
                                if (question.type == 'slider') // // //
                                  SliderWidgitCard(question),
                                // //
                                // //
                                // if (question.type == 'images') // // //
                                //   ImagesWidgitCard(question),
                                // //
                                // //
                                // if (question.type == 'input') // // //
                                //   InputWidgitCard(question),
                                // //
                                // //
                                // if (question.type == 'address') // // //
                                //   AddressWidgitCard(question),
                                // //
                                // //
                                // if (question.type == 'from-to-address') // // //
                                //   FromToAddressWidgitCard(question),
                                // //
                                // //
                                // if (question.type == 'date-time') // // //
                                //   DateTimeWidgitCard(question),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                  //
                  setHeightSpace(10),
                  //
                  Container(
                    width: double.infinity,
                    child: globalButton(
                      S.current.okayAndContinue,
                      fontWeight: FontWeight.normal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      () async {
                        FocusScope.of(context).unfocus();
                        if (!v.formKeySignUpWorkInfo.currentState!.validate())
                          return;

                        if (!v.selectValue)
                          return screenMessage(
                              S.current.pleaseSelectWorkOption);

                        await v.setData();

                        // return await authProvider.signUp(context, v.signUpData, false);

                        NavMove.goOTPPage(context, v.signUpData, false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //
  PopupMenuItem popUp(BuildContext ctx, String title) {
    return PopupMenuItem(
      value: title,
      child: Center(child: globalText(title)),
    );
  }
}

class OptionWidgitCard extends StatefulWidget {
  final Question question;
  const OptionWidgitCard(this.question, {super.key});
  @override
  State<OptionWidgitCard> createState() => _OptionWidgitCardState();
}

class _OptionWidgitCardState extends State<OptionWidgitCard> {
  late Question question;
  int selectedOption = 0;
  int questionIndex = 0;
  @override
  void initState() {
    question = widget.question;

    signProvider.answers.add({
      'question_id': question.id,
      'type': question.type,
      'answer': 0,
    });

    questionIndex = signProvider.answersIndex(question.id);

    signProvider.selectValue = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (question.layout == 'GridView')
      return Consumer<SignProvider>(
        builder: (_, v, __) {
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: question.inRow,
              crossAxisSpacing: 5,
              mainAxisExtent: question.height,
            ),
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              Option option = question.options[index];
              return Card(
                color: selectedOption == option.id ? AppColor.orange : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedOption = option.id;
                      v.answers[questionIndex]['answer'] = option.id;
                      v.selectValue = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (option.image.length > 0)
                          Expanded(
                            flex: 2,
                            child: NetworkImagePlace(
                              image: option.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        setHeightSpace(3),
                        globalText(
                          option.name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    //
    if (question.layout == 'List.row')
      return Consumer<SignProvider>(
        builder: (_, v, __) {
          return Container(
            height: question.height,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                Option option = question.options[index];
                return Card(
                  color: selectedOption == option.id ? AppColor.orange : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = option.id;
                        v.answers[questionIndex]['answer'] = option.id;
                        v.selectValue = true;
                      });
                    },
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.all(6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (option.image.length > 0)
                            Expanded(
                              flex: 2,
                              child: NetworkImagePlace(
                                image: option.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          setHeightSpace(3),
                          globalText(
                            option.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    //
    return Consumer<SignProvider>(
      builder: (_, v, __) {
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: question.options.length,
          itemBuilder: (context, index) {
            Option option = question.options[index];
            return Card(
              color: selectedOption == option.id ? AppColor.orange : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = option.id;
                    v.answers[questionIndex]['answer'] = option.id;
                    v.selectValue = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (option.image.length > 0)
                        Expanded(
                          flex: 2,
                          child: NetworkImagePlace(
                            image: option.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      setHeightSpace(3),
                      globalText(
                        option.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SliderWidgitCard extends StatefulWidget {
  final Question question;
  const SliderWidgitCard(this.question, {super.key});
  @override
  State<SliderWidgitCard> createState() => _SliderWidgitCardState();
}

class _SliderWidgitCardState extends State<SliderWidgitCard> {
  double val = 0.0;
  late Question question;
  int questionIndex = 0;
  @override
  void initState() {
    question = widget.question;

    val = question.min_val.toDouble();
    questionIndex = signProvider.answersIndex(question.id);

    signProvider.answers.add({
      'question_id': question.id,
      'type': question.type,
      'answer': 0,
    });

    signProvider.selectValue = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignProvider>(
      builder: (_, v, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            globalText(
              "${question.name}: ${val.toStringAsFixed(0)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Slider(
              min: question.min.toDouble(),
              max: question.max.toDouble(),
              divisions: question.max - question.min,
              value: val,
              onChanged: (value) {
                setState(() {
                  val = value;
                  v.answers[questionIndex]['answer'] = val;
                  v.selectValue = true;
                });
              },
            ),
            // globalText(question.desc),
          ],
        );
      },
    );
  }
}
