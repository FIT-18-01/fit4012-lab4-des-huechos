# Logs directory

Thư mục này dùng để nộp minh chứng thực tế cho Lab 4 DES / TripleDES.

### Các file minh chứng cần có

- `run-output.txt` — output của một lần chạy chương trình `./des` hoặc `make && ./des`
- `roundtrip-output.txt` — ví dụ mã hóa DES rồi giải mã lại để chứng minh tái tạo plaintext
- `multiblock-output.txt` — minh chứng xử lý plaintext dài hơn 64 bit và zero padding
- `tamper-case.txt` — minh chứng negative test khi ciphertext bị thay đổi
- `wrong-key-case.txt` — minh chứng negative test khi dùng sai key

### Hướng dẫn nội dung

Mỗi file log nên chứa:
- lệnh đã chạy
- input đã nhập (khi phù hợp)
- output chương trình
- chú thích ngắn gọn về kết quả

> Lưu ý: file `logs/README.md` chỉ là tài liệu hướng dẫn. Các file `.txt` thực sự mới là minh chứng nộp bài.
