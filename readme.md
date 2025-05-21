# Zada E-Commerce Platform - Nền tảng Thương mại Điện tử

## Giới thiệu

Đây là một nền tảng thương mại điện tử toàn diện được thiết kế để hỗ trợ các hoạt động mua bán trực tuyến. Nền tảng này cung cấp đầy đủ các tính năng cần thiết cho cả người mua, người bán và quản trị viên, tạo ra một hệ sinh thái mua sắm trực tuyến hoàn chỉnh.

## Tổng quan

Nền tảng được xây dựng theo cách hiện đại, chia thành nhiều dịch vụ nhỏ độc lập (gọi là microservices), giúp hệ thống dễ dàng mở rộng, bảo trì và nâng cấp. Mỗi dịch vụ đảm nhận một chức năng cụ thể trong hệ thống, tương tự như cách một công ty lớn phân chia thành nhiều phòng ban chuyên trách.

## Các tính năng chính

### Dành cho người mua:

- **Đăng ký và đăng nhập**: Tạo tài khoản và đăng nhập an toàn
- **Tìm kiếm và duyệt sản phẩm**: Tìm kiếm sản phẩm theo nhiều tiêu chí
- **Giỏ hàng**: Thêm, sửa, xóa sản phẩm trong giỏ hàng
- **Đặt hàng**: Quy trình đặt hàng đơn giản và linh hoạt
- **Thanh toán**: Nhiều phương thức thanh toán an toàn
- **Theo dõi đơn hàng**: Cập nhật trạng thái đơn hàng theo thời gian thực
- **Đánh giá sản phẩm**: Chia sẻ trải nghiệm về sản phẩm đã mua
- **Danh sách yêu thích**: Lưu sản phẩm yêu thích để mua sau
- **Trả hàng và hoàn tiền**: Quy trình trả hàng và hoàn tiền rõ ràng
- **Hỗ trợ khách hàng**: Kênh liên lạc trực tiếp với người bán và hỗ trợ

### Dành cho người bán:

- **Quản lý cửa hàng**: Thiết lập và quản lý cửa hàng trực tuyến
- **Quản lý sản phẩm**: Thêm, sửa, xóa thông tin sản phẩm và tồn kho
- **Quản lý đơn hàng**: Xử lý đơn hàng và cập nhật trạng thái
- **Báo cáo và phân tích**: Thống kê doanh số, đơn hàng và hiệu suất
- **Khuyến mãi và giảm giá**: Tạo và quản lý các chương trình khuyến mãi
- **Giao tiếp với khách hàng**: Trả lời thắc mắc và hỗ trợ khách hàng

## Các dịch vụ trong hệ thống

Nền tảng bao gồm 20 dịch vụ chính, mỗi dịch vụ đảm nhận một chức năng cụ thể:

1. **Dịch vụ Xác thực**: Quản lý đăng nhập, đăng ký và bảo mật tài khoản
2. **Dịch vụ Người dùng**: Quản lý thông tin cá nhân và địa chỉ người dùng
3. **Dịch vụ Người bán**: Quản lý thông tin người bán và hiệu suất bán hàng
4. **Dịch vụ Sản phẩm**: Quản lý thông tin sản phẩm và danh mục
5. **Dịch vụ Kho hàng**: Quản lý tồn kho và thông tin kho hàng
6. **Dịch vụ Giỏ hàng**: Quản lý giỏ hàng của người dùng
7. **Dịch vụ Đơn hàng**: Xử lý và theo dõi đơn hàng
8. **Dịch vụ Thanh toán**: Xử lý các giao dịch thanh toán
9. **Dịch vụ Vận chuyển**: Quản lý thông tin vận chuyển và giao hàng
10. **Dịch vụ Đánh giá**: Quản lý đánh giá và nhận xét sản phẩm
11. **Dịch vụ Khuyến mãi**: Quản lý chương trình khuyến mãi và mã giảm giá
12. **Dịch vụ Thông báo**: Gửi thông báo đến người dùng
13. **Dịch vụ Danh sách yêu thích**: Quản lý danh sách sản phẩm yêu thích
14. **Dịch vụ Tin nhắn**: Hỗ trợ giao tiếp giữa người mua và người bán
15. **Dịch vụ Gợi ý nội dung**: Gợi ý nội dung cho người dùng
16. **Dịch vụ Kiểm duyệt nội dung**: Hỗ trợ kiểm duyệt nội dung tự động
17. **Dịch vụ Lịch trình**: Lên lịch trình huỷ tài khoản, ...
18. **Dịch vụ Đa ngôn ngữ**: Hỗ trợ nhiều ngôn ngữ khác nhau
19. **Dịch vụ Giới thiệu**: Quản lý chương trình giới thiệu bạn bè
20. **Dịch vụ Media**: Quản lý các tài nguyên ảnh, video, ... 

## Kiến trúc hệ thống

![Kiến trúc hệ thống](screenshots/system-architect.png)
