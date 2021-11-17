import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/categories.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/screens/quiz/components/questions.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  bool _showBackToTopButton = false;
  ScrollController _scrollController;

  Map<String, dynamic> scores;
  int correct_answers;
  int incorrect_answers;
  int numof_questions;
  int scoreper;

  QuestionController _qnController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _qnController = Get.put(QuestionController());
    correct_answers = _qnController.numOfCorrectAns;
    numof_questions = _qnController.questions.length;
    incorrect_answers =
        _qnController.questions.length - _qnController.numOfCorrectAns;
    scoreper =
        ((_qnController.numOfCorrectAns / _qnController.questions.length) * 100)
            .round();

    refreshScores();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 100) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  Future refreshScores() async {
    setState(() => isLoading = true);
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CategoriesScreen()),
                    (Route<dynamic> route) => false);
              }),
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            height: 125,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/bg0.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: ScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 60.0),
                  Text("${username.toUpperCase()}",
                      style: CustomStyle.whiteboldheadline4(context)),
                  SizedBox(height: 20.0),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text("Total Questions",
                          style: CustomStyle.blackboldheadline5(context)),
                      trailing: Text("${numof_questions}",
                          style: CustomStyle.pinkboldheadline5(context)),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text("Correct Answers",
                          style: CustomStyle.blackboldheadline5(context)),
                      trailing: Text("${correct_answers}/${numof_questions}",
                          style: CustomStyle.greenboldheadline5(context)),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text("Incorrect Answers",
                          style: CustomStyle.blackboldheadline5(context)),
                      trailing: Text("${incorrect_answers}/${numof_questions}",
                          style: CustomStyle.redboldheadline5(context)),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text("Score",
                          style: CustomStyle.blackboldheadline5(context)),
                      trailing: Text("${scoreper}%",
                          style: CustomStyle.pinkboldheadline5(context)),
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: _showBackToTopButton == false
            ? null
            : FloatingActionButton(
                onPressed: _scrollToTop,
                child: Icon(Icons.arrow_upward),
              ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
