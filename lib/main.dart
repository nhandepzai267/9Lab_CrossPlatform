import 'package:flutter/material.dart';

void main() {
  runApp(const DestiniApp());
}

class DestiniApp extends StatelessWidget {
  const DestiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      home: const StoryPage(),
    );
  }
}

// ── Data model ──────────────────────────────────────────────────────────────

class Story {
  final String storyText;
  final String? choice1;
  final String? choice2;
  final String? choice3;
  // index of the next story for each choice; -1 = no more choices (ending)
  final int? next1;
  final int? next2;
  final int? next3;

  const Story({
    required this.storyText,
    this.choice1,
    this.choice2,
    this.choice3,
    this.next1,
    this.next2,
    this.next3,
  });
}

// ── Story data ───────────────────────────────────────────────────────────────
//
//  Index 0 – Opening
//  Index 1 – Branch A  → Ending A (index 4)
//  Index 2 – Branch B  → Ending B (index 5)
//  Index 3 – Branch C  → Ending C (index 6)
//  Index 4, 5, 6 – Endings (no choices)

const List<Story> stories = [
  // 0 – Opening: 3 choices
  Story(
    storyText:
        'Bạn đang đi bộ trong rừng tối thì bắt gặp một ngã ba đường. '
        'Trước mặt là ba con đường mòn khác nhau dẫn vào bóng tối.\n\n'
        'Bạn chọn đường nào?',
    choice1: '🌲 Con đường bên trái – nghe có tiếng suối chảy',
    choice2: '🏚️ Con đường giữa – có ánh lửa le lói từ xa',
    choice3: '⬆️ Con đường bên phải – ngửi thấy mùi hoa dại',
    next1: 1,
    next2: 2,
    next3: 3,
  ),

  // 1 – Branch A
  Story(
    storyText:
        'Bạn theo tiếng suối và tìm thấy một dòng suối trong vắt. '
        'Bên bờ suối có một chiếc thuyền nhỏ buộc vào gốc cây. '
        'Lên thuyền, bạn xuôi dòng và thoát ra khỏi khu rừng khi bình minh ló dạng.',
    next1: 4,
    choice1: '✅ Tiếp tục →',
  ),

  // 2 – Branch B
  Story(
    storyText:
        'Bạn tiến đến ánh lửa và phát hiện ra đó là một căn lều bỏ hoang. '
        'Bên trong, một chiếc bẫy cũ sập xuống chân bạn. '
        'May mắn thay, một người thợ săn địa phương đi qua và giải cứu bạn, '
        'nhưng bạn phải mất cả đêm để trở về làng.',
    next1: 5,
    choice1: '✅ Tiếp tục →',
  ),

  // 3 – Branch C
  Story(
    storyText:
        'Mùi hoa dại dẫn bạn đến một bãi cỏ rộng ngập tràn hoa lục bình tím. '
        'Giữa bãi cỏ, bạn tìm thấy một chiếc ba lô cũ với tấm bản đồ bên trong. '
        'Theo bản đồ, bạn khám phá ra một ngôi làng cổ ẩn giấu giữa rừng '
        'và sống cùng cư dân ở đó mãi mãi.',
    next1: 6,
    choice1: '✅ Tiếp tục →',
  ),

  // 4 – Ending A 🏆
  Story(
    storyText:
        '🌅 KẾT THÚC A – Tự do!\n\n'
        'Bạn thoát ra khỏi khu rừng an toàn trên dòng suối hiền hòa. '
        'Ánh nắng buổi sáng chào đón bạn cùng tiếng chim hót líu lo. '
        'Bạn trở về nhà với một câu chuyện phiêu lưu tuyệt vời để kể lại!',
  ),

  // 5 – Ending B 😬
  Story(
    storyText:
        '🌑 KẾT THÚC B – Thoát hiểm!\n\n'
        'Bạn thoát khỏi bẫy nhờ may mắn, nhưng phải trải qua một đêm dài đáng sợ. '
        'Bài học rút ra: không nên mạo hiểm tiến vào những nơi tối tăm lạ lẫm '
        'mà không có sự chuẩn bị kỹ càng.',
  ),

  // 6 – Ending C ✨
  Story(
    storyText:
        '🌸 KẾT THÚC C – Khám phá!\n\n'
        'Bạn tìm thấy một thế giới hoàn toàn mới ẩn sau cánh rừng. '
        'Ngôi làng cổ chào đón bạn như người thân lâu ngày trở về. '
        'Cuộc phiêu lưu không chỉ kết thúc – nó mới thực sự bắt đầu!',
  ),
];

// ── UI ───────────────────────────────────────────────────────────────────────

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int _storyIndex = 0;

  Story get _current => stories[_storyIndex];

  bool get _isEnding =>
      _current.choice1 == null &&
      _current.choice2 == null &&
      _current.choice3 == null;

  void _goTo(int? index) {
    if (index == null) return;
    setState(() => _storyIndex = index);
  }

  void _restart() => setState(() => _storyIndex = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // Title bar
              const Text(
                'DESTINI',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                  color: Color(0xFFE94560),
                ),
              ),
              const SizedBox(height: 32),

              // Story text card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE94560).withValues(alpha: 0.3),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _current.storyText,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.7,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Choices or Restart button
              if (_isEnding)
                _buildButton(
                  label: '🔄 Chơi lại từ đầu',
                  onTap: _restart,
                  color: const Color(0xFFE94560),
                )
              else ...[
                if (_current.choice1 != null)
                  _buildButton(
                    label: _current.choice1!,
                    onTap: () => _goTo(_current.next1),
                  ),
                if (_current.choice2 != null) ...[
                  const SizedBox(height: 12),
                  _buildButton(
                    label: _current.choice2!,
                    onTap: () => _goTo(_current.next2),
                  ),
                ],
                if (_current.choice3 != null) ...[
                  const SizedBox(height: 12),
                  _buildButton(
                    label: _current.choice3!,
                    onTap: () => _goTo(_current.next3),
                  ),
                ],
              ],

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onTap,
    Color color = const Color(0xFF0F3460),
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
