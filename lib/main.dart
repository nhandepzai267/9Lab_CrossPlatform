import 'package:flutter/material.dart';
import 'dart:math';

// Hàm main - điểm khởi đầu của ứng dụng
void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn banner "DEBUG"
      home: Scaffold(
        backgroundColor: Colors.white, // Màu nền trắng
        appBar: AppBar(
          title: const Text('Dicee'),
          backgroundColor: Colors.grey[800],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: const DicePage(), // Widget chính
      ),
    ),
  );
}

// StatefulWidget - Widget có thể thay đổi trạng thái
class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

// State class - quản lý dữ liệu và logic
class _DicePageState extends State<DicePage> {
  // Biến lưu số của xúc xắc trái và phải
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  // Hàm chuyển số thành emoji xúc xắc
  String getDiceEmoji(int number) {
    const diceEmojis = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
    return diceEmojis[number - 1]; // -1 vì array bắt đầu từ 0
  }

  // Hàm thay đổi mặt xúc xắc
  void changeDiceFace() {
    setState(() {
      // setState() báo cho Flutter biết cần vẽ lại UI
      leftDiceNumber = Random().nextInt(6) + 1;  // Số ngẫu nhiên 1-6
      rightDiceNumber = Random().nextInt(6) + 1;
      print('Xúc xắc: $leftDiceNumber - $rightDiceNumber'); // Debug
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          // Xúc xắc bên trái
          Expanded(
            child: TextButton(
              onPressed: changeDiceFace, // Gọi hàm khi nhấn
              child: Text(
                getDiceEmoji(leftDiceNumber),
                style: const TextStyle(
                  fontSize: 100,
                  color: Colors.black, // Xúc xắc màu đen
                ),
              ),
            ),
          ),
          // Xúc xắc bên phải
          Expanded(
            child: TextButton(
              onPressed: changeDiceFace,
              child: Text(
                getDiceEmoji(rightDiceNumber),
                style: const TextStyle(
                  fontSize: 100,
                  color: Colors.black, // Xúc xắc màu đen
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
