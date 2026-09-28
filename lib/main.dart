import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Xylophone',
      debugShowCheckedModeBanner: false,
      home: XylophonePage(),
    );
  }
}

class XylophonePage extends StatelessWidget {
  const XylophonePage({super.key});

  // Các note âm thanh từ Angela Yu Xylophone course
  static const List<String> _notes = [
    'https://github.com/londonappbrewery/xylophone-flutter/raw/master/assets/note1.wav',
    'https://github.com/londonappbrewery/xylophone-flutter/raw/master/assets/note2.wav',
    'https://github.com/londonappbrewery/xylophone-flutter/raw/master/assets/note3.wav',
    'https://github.com/londonappbrewery/xylophone-flutter/raw/master/assets/note4.wav',
    'https://github.com/londonappbrewery/xylophone-flutter/raw/master/assets/note5.wav',
    'https://github.com/londonappbrewery/xylophone-flutter/raw/master/assets/note6.wav',
    'https://github.com/londonappbrewery/xylophone-flutter/raw/master/assets/note7.wav',
  ];

  static const List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple,
  ];

  void _playNote(int noteIndex) async {
    final player = AudioPlayer();
    await player.play(UrlSource(_notes[noteIndex]));
  }

  Widget _buildKey({required int noteIndex, required Color color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: GestureDetector(
          onTap: () => _playNote(noteIndex),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            _notes.length,
            (index) => _buildKey(
              noteIndex: index,
              color: _colors[index],
            ),
          ),
        ),
      ),
    );
  }
}
