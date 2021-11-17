class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({this.id, this.question, this.answer, this.options});
}

class Score {
  final String name;
  final String email;
  final String category;
  final int score;
  final DateTime datetime;
  Score({this.name, this.category, this.score, this.datetime, this.email});
}

Map<String, dynamic> quizzes;
List selectedQuiz;

void setQuiz(c) {
  selectedQuiz = c;
  print("passed");
}
