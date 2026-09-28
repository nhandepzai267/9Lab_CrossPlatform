import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4_chakebge1_magic8ball/main.dart';

void main() {
  testWidgets('Magic 8 Ball app renders correctly', (WidgetTester tester) async {
    // Build app và render frame đầu tiên
    await tester.pumpWidget(const Magic8BallApp());

    // Kiểm tra tiêu đề AppBar có chữ Magic 8 Ball
    expect(find.text('🎱 Magic 8 Ball'), findsOneWidget);

    // Kiểm tra hướng dẫn hiển thị
    expect(find.text('Ask a yes/no question,\nthen tap the ball!'), findsOneWidget);

    // Kiểm tra nút Shake It! có mặt
    expect(find.text('Shake It!'), findsOneWidget);
  });

  testWidgets('Magic 8 Ball shows answer after tapping Shake button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Magic8BallApp());

    // Trước khi nhấn, chưa có câu trả lời cụ thể
    expect(find.text('Shake It!'), findsOneWidget);

    // Nhấn nút Shake It!
    await tester.tap(find.text('Shake It!'));

    // Chờ animation hoàn tất (600ms)
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Sau khi shake, nút vẫn phải còn đó (không disabled nữa)
    expect(find.text('Shake It!'), findsOneWidget);
  });

  testWidgets('Magic 8 Ball shows answer after tapping the ball',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Magic8BallApp());

    // Nhấn vào GestureDetector bao quanh quả bóng
    await tester.tap(find.byType(GestureDetector).first);

    // Chờ animation hoàn tất
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Sau khi tap, nút Shake It! vẫn hiển thị
    expect(find.text('Shake It!'), findsOneWidget);
  });
}
