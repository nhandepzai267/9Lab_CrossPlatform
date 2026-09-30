# Lab 3: Dicee - Building Apps with State

Ứng dụng tung xúc xắc để học về **Stateful Widgets** trong Flutter.

## 🎯 Mục tiêu học tập

- Hiểu về **StatefulWidget** và **State**
- Sử dụng **setState()** để cập nhật UI
- Làm việc với **Random** để tạo số ngẫu nhiên
- Xử lý sự kiện tap/click
- Quản lý assets (hình ảnh)

## 🎲 Các phiên bản

Project này có 3 phiên bản:

### 1. **main.dart** - Phiên bản dùng hình ảnh (Chuẩn)
- Sử dụng file PNG cho xúc xắc
- Cần thêm hình vào thư mục `images/`
- Xem hướng dẫn trong `images/INSTRUCTIONS.md`

### 2. **main_emoji.dart** - Phiên bản emoji (Nhanh nhất)
- Dùng emoji xúc xắc ⚀ ⚁ ⚂ ⚃ ⚄ ⚅
- Không cần hình ảnh
- Chạy ngay được

### 3. **main_custom.dart** - Phiên bản vẽ custom
- Vẽ xúc xắc bằng CustomPainter
- Không cần hình ảnh
- UI đẹp và chuyên nghiệp

## 🚀 Cách chạy

### Chạy phiên bản emoji (khuyến nghị để test):
```bash
# Đổi tên file
Remove-Item lib/main.dart
Rename-Item lib/main_emoji.dart lib/main.dart

# Hoặc copy nội dung từ main_emoji.dart sang main.dart
```

### Chạy phiên bản custom:
```bash
Remove-Item lib/main.dart
Rename-Item lib/main_custom.dart lib/main.dart
```

### Sau đó chạy:
```bash
flutter pub get
flutter run
```

## 📚 Kiến thức đã học

1. **StatefulWidget vs StatelessWidget**
   - StatelessWidget: không thay đổi (immutable)
   - StatefulWidget: có thể thay đổi state

2. **setState()**
   - Báo cho Flutter biết cần rebuild widget
   - Cập nhật UI khi dữ liệu thay đổi

3. **Random**
   - `Random().nextInt(6)` → số từ 0-5
   - `Random().nextInt(6) + 1` → số từ 1-6

4. **Event Handling**
   - `onPressed` cho button
   - `onTap` cho GestureDetector

## 🎨 Mở rộng (Nâng cao)

- Thêm animation khi xúc xắc thay đổi
- Thêm âm thanh khi tung xúc xắc
- Tính tổng điểm hai xúc xắc
- Lưu lịch sử các lần tung
