import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'question_card.dart';
import 'progress_bar.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return new WillPopScope(
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ProgressBar(),
                ),
                SizedBox(height: kDefaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Obx(
                    () => Text.rich(
                      TextSpan(
                        text:
                            "Question ${_questionController.questionNumber.value}",
                        style: CustomStyle.whiteboldheadline4(context),
                        children: [
                          TextSpan(
                            text: "/${_questionController.questions.length}",
                            style: CustomStyle.whiteheadline5(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1.5),
                SizedBox(height: kDefaultPadding),
                Expanded(
                  child: PageView.builder(
                    // Block swipe to next qn
                    physics: NeverScrollableScrollPhysics(),
                    controller: _questionController.pageController,
                    onPageChanged: _questionController.updateQnNum,
                    itemCount: _questionController.questions.length,
                    itemBuilder: (context, index) => QuestionCard(
                        question: _questionController.questions[index]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
