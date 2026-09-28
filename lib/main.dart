import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const Magic8BallApp());
}

class Magic8BallApp extends StatelessWidget {
  const Magic8BallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 Ball',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Magic8BallPage(),
    );
  }
}

class Magic8BallPage extends StatefulWidget {
  const Magic8BallPage({super.key});

  @override
  State<Magic8BallPage> createState() => _Magic8BallPageState();
}

class _Magic8BallPageState extends State<Magic8BallPage>
    with SingleTickerProviderStateMixin {
  // Phân loại câu trả lời static const để tránh khởi tạo lại bộ nhớ
  static const List<String> _positiveAnswers = [
    'It is certain',
    'It is decidedly so',
    'Without a doubt',
    'Yes, definitely',
    'You may rely on it',
    'As I see it, yes',
    'Most likely',
    'Outlook good',
    'Yes',
    'Signs point to yes',
  ];

  static const List<String> _neutralAnswers = [
    'Reply hazy, try again',
    'Ask again later',
    'Better not tell you now',
    'Cannot predict now',
    'Concentrate and ask again',
  ];

  static const List<String> _negativeAnswers = [
    "Don't count on it",
    'My reply is no',
    'My sources say no',
    'Outlook not so good',
    'Very doubtful',
  ];

  // Danh sách 20 câu trả lời tổng hợp
  static const List<String> _answers = [
    ..._positiveAnswers,
    ..._neutralAnswers,
    ..._negativeAnswers,
  ];

  final Random _random = Random();
  String _currentAnswer = 'Ask me\nanything...';
  bool _isShaking = false;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  // Getter kiểm tra xem đã có kết quả hay chưa
  bool get _hasAnswer =>
      _currentAnswer != 'Ask me\nanything...' && _currentAnswer != '...';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.92), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.92, end: 1.05), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isShaking = false;
          _currentAnswer = _answers[_random.nextInt(_answers.length)];
        });
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _shake() {
    if (_isShaking) return;
    setState(() {
      _isShaking = true;
      _currentAnswer = '...';
    });
    _controller.forward();
  }

  Color _answerColor(String answer) {
    if (_positiveAnswers.contains(answer)) return const Color(0xFF4CAF50);
    if (_negativeAnswers.contains(answer)) return const Color(0xFFEF5350);
    return const Color(0xFFFFCA28);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '🎱 Magic 8 Ball',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Text(
              'Ask a yes/no question,\nthen tap the ball!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: _shake,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final shakeOffset = _isShaking && _controller.value < 0.8
                        ? sin(_controller.value * pi * 6) * 12
                        : 0.0;
                    return Transform.translate(
                      offset: Offset(shakeOffset, 0),
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Bóng ngoài đen
                      Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            center: Alignment(-0.3, -0.4),
                            radius: 0.85,
                            colors: [
                              Color(0xFF4A4A4A),
                              Color(0xFF1C1C1C),
                              Color(0xFF000000),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 30,
                              spreadRadius: 10,
                              offset: const Offset(8, 12),
                            ),
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.2),
                              blurRadius: 40,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      // Vòng tròn bên trong
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 0.9,
                            colors: [
                              const Color(0xFF3949AB).withOpacity(0.95),
                              const Color(0xFF1A237E).withOpacity(0.98),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3949AB).withOpacity(0.5),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: !_hasAnswer
                                ? Text(
                                    _currentAnswer == '...' ? '...' : '8',
                                    key: ValueKey(_currentAnswer),
                                    style: TextStyle(
                                      color: _currentAnswer == '...'
                                          ? Colors.white54
                                          : Colors.white,
                                      fontSize:
                                          _currentAnswer == '...' ? 28 : 52,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      _currentAnswer,
                                      key: ValueKey(_currentAnswer),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _answerColor(_currentAnswer),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      // Điểm sáng phản chiếu
                      Positioned(
                        top: 40,
                        left: 70,
                        child: Container(
                          width: 55,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.25),
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Nút Shake
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton.icon(
              onPressed: _isShaking ? null : _shake,
              icon: const Icon(Icons.vibration),
              label: const Text(
                'Shake It!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C4DFF),
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade700,
                disabledForegroundColor: Colors.white38,
                padding: const EdgeInsets.symmetric(
                    horizontal: 36, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
              ),
            ),
          ),
          // Kết quả phía dưới
          AnimatedOpacity(
            opacity: _hasAnswer ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              margin: const EdgeInsets.only(
                  left: 40, right: 40, bottom: 24),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hasAnswer
                      ? _answerColor(_currentAnswer).withOpacity(0.5)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Text(
                _hasAnswer ? _currentAnswer : '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _hasAnswer
                      ? _answerColor(_currentAnswer)
                      : Colors.transparent,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}