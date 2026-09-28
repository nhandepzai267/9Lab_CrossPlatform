import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questions = [
    Question('Cá heo là loài động vật có vú?', true),
    Question('Mặt trời quay quanh Trái Đất?', false),
    Question('Con người có thể sống hơn 10 ngày mà không ngủ?', false),
    Question('Bạch tuộc có 3 trái tim?', true),
    Question('Nước sôi ở 100°C ở điều kiện bình thường?', true),
  ];

  String getQuestionText() {
    return _questions[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    return _questionNumber >= _questions.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }

  int get totalQuestions => _questions.length;
}
