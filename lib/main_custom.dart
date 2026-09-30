import 'package:flutter/material.dart';
import 'dart:math';

// PHIÊN BẢN VẼ CHẤM XÚC XẮC - KHÔNG CẦN HÌNH ẢNH
// Đổi tên file này thành main.dart nếu muốn dùng

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[900],
        appBar: AppBar(
          title: const Text('Dicee'),
          backgroundColor: Colors.red[900],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: const DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void changeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: changeDiceFace,
                child: DiceWidget(number: leftDiceNumber),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: changeDiceFace,
                child: DiceWidget(number: rightDiceNumber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiceWidget extends StatelessWidget {
  final int number;

  const DiceWidget({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: DicePainter(number: number),
        ),
      ),
    );
  }
}

class DicePainter extends CustomPainter {
  final int number;

  DicePainter({required this.number});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red[900]!
      ..style = PaintingStyle.fill;

    final dotRadius = size.width * 0.08;
    final padding = size.width * 0.25;

    // Vị trí các chấm
    final center = Offset(size.width / 2, size.height / 2);
    final topLeft = Offset(padding, padding);
    final topRight = Offset(size.width - padding, padding);
    final middleLeft = Offset(padding, size.height / 2);
    final middleRight = Offset(size.width - padding, size.height / 2);
    final bottomLeft = Offset(padding, size.height - padding);
    final bottomRight = Offset(size.width - padding, size.height - padding);

    // Vẽ các chấm theo số
    switch (number) {
      case 1:
        canvas.drawCircle(center, dotRadius, paint);
        break;
      case 2:
        canvas.drawCircle(topLeft, dotRadius, paint);
        canvas.drawCircle(bottomRight, dotRadius, paint);
        break;
      case 3:
        canvas.drawCircle(topLeft, dotRadius, paint);
        canvas.drawCircle(center, dotRadius, paint);
        canvas.drawCircle(bottomRight, dotRadius, paint);
        break;
      case 4:
        canvas.drawCircle(topLeft, dotRadius, paint);
        canvas.drawCircle(topRight, dotRadius, paint);
        canvas.drawCircle(bottomLeft, dotRadius, paint);
        canvas.drawCircle(bottomRight, dotRadius, paint);
        break;
      case 5:
        canvas.drawCircle(topLeft, dotRadius, paint);
        canvas.drawCircle(topRight, dotRadius, paint);
        canvas.drawCircle(center, dotRadius, paint);
        canvas.drawCircle(bottomLeft, dotRadius, paint);
        canvas.drawCircle(bottomRight, dotRadius, paint);
        break;
      case 6:
        canvas.drawCircle(topLeft, dotRadius, paint);
        canvas.drawCircle(topRight, dotRadius, paint);
        canvas.drawCircle(middleLeft, dotRadius, paint);
        canvas.drawCircle(middleRight, dotRadius, paint);
        canvas.drawCircle(bottomLeft, dotRadius, paint);
        canvas.drawCircle(bottomRight, dotRadius, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
