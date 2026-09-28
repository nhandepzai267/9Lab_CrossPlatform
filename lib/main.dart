import 'package:flutter/material.dart';
import 'quiz_brain.dart';

void main() {
  runApp(const QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain _quizBrain = QuizBrain();
  final List<Widget> _scoreKeeper = [];
  bool _quizFinished = false;
  int _score = 0;

  void _checkAnswer(bool userAnswer) {
    if (_quizFinished) return;

    final bool correctAnswer = _quizBrain.getCorrectAnswer();
    final bool isCorrect = userAnswer == correctAnswer;

    setState(() {
      _scoreKeeper.add(
        Icon(
          isCorrect ? Icons.check_circle : Icons.cancel,
          color: isCorrect ? Colors.greenAccent : Colors.redAccent,
          size: 28.0,
        ),
      );

      if (isCorrect) _score++;

      if (_quizBrain.isFinished()) {
        _quizFinished = true;
      } else {
        _quizBrain.nextQuestion();
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _quizBrain.reset();
      _scoreKeeper.clear();
      _quizFinished = false;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30.0),
              // Header
              const Text(
                '🧠 Quizzler',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Điểm: $_score / ${_quizBrain.totalQuestions}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 30.0),

              // Question card
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFF0F3460),
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: _quizFinished
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _score == _quizBrain.totalQuestions
                                      ? '🎉 Xuất sắc!'
                                      : _score >= 3
                                          ? '👏 Khá tốt!'
                                          : '😅 Cố lên!',
                                  style: const TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Bạn đúng $_score/${_quizBrain.totalQuestions} câu!',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              _quizBrain.getQuestionText(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),

              // True button
              if (!_quizFinished)
                ElevatedButton(
                  onPressed: () => _checkAnswer(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: const Text(
                    '✅  ĐÚNG',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),

              const SizedBox(height: 12.0),

              // False button
              if (!_quizFinished)
                ElevatedButton(
                  onPressed: () => _checkAnswer(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: const Text(
                    '❌  SAI',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),

              // Restart button
              if (_quizFinished)
                ElevatedButton(
                  onPressed: _restartQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F3460),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: const Text(
                    '🔄  Chơi lại',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),

              const SizedBox(height: 20.0),

              // Score keeper icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _scoreKeeper,
              ),

              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
