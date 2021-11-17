import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/quiz/components/questions.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:ui';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesState createState() => new _CategoriesState();
}

class _CategoriesState extends State<CategoriesScreen> {
  int selection;
  bool isLoading = false;

  initState() {
    super.initState();
    setState(() => isLoading = true);
    refreshQuizzes();
    setState(() => isLoading = false);
  }

  Future refreshQuizzes() async {
    setState(() => isLoading = true);
    loadQuizzes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
              child: Text("Logout"),
              textColor: Colors.white,
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage("assets/icons/bg0.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 1),
                    Text(
                        "Hello, ${username[0].toUpperCase()}${username.substring(1).toLowerCase()}. \nChoose a book to start the quiz: ",
                        style: CustomStyle.whiteboldheadline4(context),
                        textAlign: TextAlign.center),
                    Spacer(),
                    Container(
                      height: 400,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : FutureBuilder<List>(
                              future: loadQuizzes(),
                              builder: (context, future) {
                                if (!future.hasData)
                                  return Container(); // Display empty container if the list is empty
                                else {
                                  List<String> list = future.data;
                                  return ListView.builder(
                                    padding: EdgeInsets.fromLTRB(
                                        15.0, 15.0, 15.0, 15.0),
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Table(
                                              border: null,
                                              defaultVerticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              children: [
                                                TableRow(children: [
                                                  InkWell(
                                                    onTap: () => {
                                                      catName = list[index],
                                                      setQuiz(
                                                          context, list[index]),
                                                    },
                                                    child: Container(
                                                      height: 80,
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.all(
                                                          kDefaultPadding *
                                                              0.75), // 15
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            kPrimaryGradient,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      child: Text(
                                                        list[index],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .button
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ]),
                                          Divider(color: Colors.transparent)
                                        ],
                                      );
                                    },
                                  );
                                }
                              }),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

Future<List> loadQuizzes() async {
  await FirebaseFirestore.instance
      .collection("questions")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      quizzes = result.data();
    });
  }).catchError((error) => print('Error Getting Quiz Data!'));
  return quizzes.keys.toList();
}

void setQuiz(context, String s) {
  try {
    if (quizzes != null) {
      selectedQuiz = quizzes[s];
      selectedQuiz.shuffle();
      Get.to(() => QuizScreen());
    } else
      throw Exception("Error Getting Quiz!");
  } catch (e) {
    quizAlertDialog(context);
  }
}

quizAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error Getting Quiz!"),
    content: Text(
        "Error fetching quiz data from the server. Please try again later."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
