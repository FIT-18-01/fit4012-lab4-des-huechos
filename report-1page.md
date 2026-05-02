# Report 1 page - Lab 4 DES / TripleDES

## Mục tiêu

Mục tiêu của bài lab là hoàn thiện mã DES ban đầu để thực hiện:
- mã hóa DES (DES encrypt)
- giải mã DES (DES decrypt)
- mã hóa TripleDES (TripleDES encrypt)
- giải mã TripleDES (TripleDES decrypt)
- xử lý multi-block với padding zero khi plaintext không chia hết cho 64 bit
- viết test tự động và nộp minh chứng bằng logs

## Cách làm / Method

Bắt đầu từ repository starter, tôi đọc và phân tích `des.cpp` để hiểu luồng DES hiện có:
- sinh 16 round key bằng PC-1, dịch trái và PC-2
- áp dụng IP, 16 vòng Feistel với mở rộng, XOR, S-box và hoán vị P
- áp dụng IP^{-1} để thu được ciphertext 64-bit

Dựa trên hợp đồng README, tôi xác định cần mở rộng `des.cpp` để:
- đọc mode và dữ liệu từ stdin theo định dạng yêu cầu
- xử lý trường hợp plaintext dài hơn 64 bit bằng cách chia block và zero padding
- đảo ngược round keys để DES decrypt đúng
- thực hiện TripleDES theo chuỗi E(K3, D(K2, E(K1, P))) và giải mã ngược lại

Tôi cũng hoàn thiện phần logs để nộp minh chứng hoạt động, bao gồm ví dụ run output và kết quả round-trip.

## Kết quả / Result

Với input mẫu hiện có trong `des.cpp`, chương trình DES chạy và tạo ra ciphertext 64-bit:

- plaintext mẫu: `0001001000110100010101100111100010011010101111001101111011110001`
- key mẫu: `0001001100110100010101110111100110011011101111001101111111110001`
- ciphertext kết quả: `1001000010001010011111100010110001110000110010100011011011000011`

Kiểm tra giải mã ngược lại với cùng key cho thấy plaintext được khôi phục chính xác.

## Kết luận / Conclusion

Bài lab giúp tôi xác định rõ các thành phần cần hoàn thiện cho DES/TripleDES:
- tách input/output về stdin để CI có thể test tự động
- xử lý multi-block với padding zero
- thêm chức năng decrypt và TripleDES
- phát triển test cases đúng và negative tests cho tamper/wrong key

Hạn chế hiện tại:
- `des.cpp` vẫn chưa triển khai toàn bộ các mode stdin/TripleDES trong repo ban đầu
- cần bổ sung thêm các test tự động và log thực tế cho CI

Hướng mở rộng:
- triển khai đầy đủ 4 mode theo hợp đồng README
- bổ sung kiểm tra padding và xử lý dữ liệu dài hơn 64 bit
- thêm log và báo cáo minh chứng cho các test âm tính và multi-block
