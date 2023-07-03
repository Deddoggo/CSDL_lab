-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    STT INT IDENTITY(1, 1),
    MaNhanVien AS CONVERT(NVARCHAR(10), 'MNV' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
    Ho NVARCHAR(50),
    Ten NVARCHAR(50),
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(100),
    SoCCCD_CMND NVARCHAR(20),
    ChucVu NVARCHAR(50)
);
INSERT INTO NhanVien (Ho, Ten, SoDienThoai, Email, DiaChi, SoCCCD_CMND, ChucVu)
VALUES
   (N'Nguyễn', N'An', '0912345678', N'nguyenan@example.com', N'Hà Nội', '123456789', N'Quản lý'),
   (N'Trần', N'Bình', '0987654321', N'tranbinh@example.com', N'Hồ Chí Minh', '987654321', N'Nhân viên'),
   (N'Lê', N'Cường', '0911111111', N'lecuong@example.com', N'Đà Nẵng', '111111111', N'Nhân viên'),
   (N'Phạm', N'Đức', '0977777777', N'phamduc@example.com', N'Hải Phòng', '777777777', N'Nhân viên'),
   (N'Nguyễn', N'Hải', '0966666666', N'nguyenhai@example.com', N'Huế', '666666666', N'Nhân viên'),
   (N'Trần', N'Khanh', '0933333333', N'trankhanh@example.com', N'Cần Thơ', '333333333', N'Nhân viên'),
   (N'Lê', N'Linh', '0922222222', N'lelinh@example.com', N'Vũng Tàu', '222222222', N'Nhân viên'),
   (N'Nguyễn', N'Mai', '0944444444', N'nguyenmai@example.com', N'Đà Lạt', '444444444', N'Nhân viên'),
   (N'Trần', N'Nam', '0955555555', N'trannam@example.com', N'Nha Trang', '555555555', N'Nhân viên'),
   (N'Phạm', N'Yến', '0999999999', N'phamyen@example.com', N'Hải Phòng', '999999999', N'Nhân viên');

-- Tạo bảng Khách hàng
CREATE TABLE KhachHang (
    STT INT IDENTITY(1, 1),
    MaKhachHang AS CONVERT(NVARCHAR(10), 'MKH' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
    Ho NVARCHAR(50),
    Ten NVARCHAR(50),
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(100),
    SoCCCD_CMND NVARCHAR(20),
    ThanhVien NVARCHAR(50)
);

INSERT INTO KhachHang (Ho, Ten, SoDienThoai, Email, DiaChi, SoCCCD_CMND, ThanhVien)
VALUES (N'Nguyễn', N'Văn A', N'0901234567', N'vana@gmail.com', N'123 Đường ABC, Quận XYZ', N'1234567890', N'Vàng'),
       (N'Trần', N'Thị B', N'0912345678', N'thib@gmail.com', N'456 Đường DEF, Quận UVW', N'9876543210', N'Bạc'),
       (N'Lê', N'Quang C', N'0987654321', N'quangc@gmail.com', N'789 Đường GHI, Quận RST', N'5432109876', N'Kim Cương'),
       (N'Phạm', N'Thư D', N'0911111111', N'thud@gmail.com', N'111 Đường JKL, Quận MNO', N'1111111111', N'Vàng'),
       (N'Hoàng', N'Văn E', N'0922222222', N'vane@gmail.com', N'222 Đường PQR, Quận STU', N'2222222222', N'Bạc'),
       (N'Nguyễn', N'Thị F', N'0933333333', N'thif@gmail.com', N'333 Đường VWX, Quận YZ', N'3333333333', N'Kim Cương'),
       (N'Trần', N'Văn G', N'0944444444', N'vang@gmail.com', N'444 Đường YZB, Quận XWV', N'4444444444', N'Vàng'),
       (N'Lê', N'Quang H', N'0955555555', N'quangh@gmail.com', N'555 Đường XWV, Quận ZYX', N'5555555555', N'Bạc'),
       (N'Phạm', N'Thư I', N'0966666666', N'thui@gmail.com', N'666 Đường WVX, Quận YZB', N'6666666666', N'Kim Cương'),
       (N'Hoàng', N'Văn J', N'0977777777', N'vanj@gmail.com', N'777 Đường ZYX, Quận VWX', N'7777777777', N'Vàng');

-- Tạo bảng Xe
CREATE TABLE Xe (
    STT INT IDENTITY(1, 1),
    MaXe AS CONVERT (NVARCHAR(10), 'MX' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
    HangXe NVARCHAR(50),
    LoaiXe NVARCHAR(50),
    SoChoNgoi INT,
    NamSanXuat INT,
    BienSo NVARCHAR(20),
    TinhTrang NVARCHAR(20),
    ViTriHienTai NVARCHAR(100),
    NguyenLieu NVARCHAR(50),
    SoKmDaDi INT
);

INSERT INTO Xe (HangXe, LoaiXe, SoChoNgoi, NamSanXuat, BienSo, TinhTrang, ViTriHienTai, NguyenLieu, SoKmDaDi)
VALUES 
    (N'Toyota', N'Sedan', 4, 2020, N'29A-12345', N'Đã thuê', N'Garage A', N'Xăng', 10000),
    (N'Honda', N'SUV', 7, 2019, N'35B-56789', N'Chưa thuê', N'Garage B', N'Dầu', 8000),
    (N'Ford', N'Hatchback', 16, 2021, N'42C-98765', N'Chưa thuê', N'Garage C', N'Xăng', 5000),
    (N'Chevrolet', N'Pickup', 4, 2018, N'53D-24680', N'Chưa thuê', N'Garage D', N'Dầu', 12000),
    (N'Mercedes-Benz', N'Sedan', 4, 2022, N'62E-13579', N'Chưa thuê', N'Garage E', N'Xăng', 6000),
    (N'BMW', N'SUV', 7, 2021, N'77F-24681', N'Chưa thuê', N'Garage F', N'Xăng', 15000),
    (N'Audi', N'Coupe', 4, 2020, N'88G-13579', N'Chưa thuê', N'Garage G', N'Dầu', 9000),
    (N'Hyundai', N'Sedan', 16, 2023, N'99H-98765', N'Chưa thuê', N'Garage H', N'Xăng', 3000),
    (N'Kia', N'Hatchback', 4, 2022, N'29I-24680', N'Chưa thuê', N'Garage I', N'Xăng', 7000),
    (N'Mazda', N'SUV', 7, 2021, N'19J-13579', N'Đã thuê', N'Garage J', N'Dầu', 11000);

-- Tạo bảng Quản lý thuê xe
CREATE TABLE QuanLyThueXe (
    STT INT IDENTITY(1, 1),
    MaThue AS CONVERT(NVARCHAR(20), 'MT' + RIGHT('0000000' + CAST(STT AS VARCHAR(7)), 7)) PERSISTED PRIMARY KEY,
    MaKhachHang NVARCHAR(10),
    MaXe NVARCHAR(10),
    DiaDiemNhanXe NVARCHAR(100),
    DiaDiemTraXe NVARCHAR(100),
    NgayBatDau DATETIME,
    NgayKetThuc DATETIME,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaXe) REFERENCES Xe(MaXe)
);

INSERT INTO QuanLyThueXe (MaKhachHang, MaXe, DiaDiemNhanXe, DiaDiemTraXe, NgayBatDau, NgayKetThuc)
VALUES
('MKH00001', 'MX00001', N'Hà Nội', N'Hồ Chí Minh', '2023-06-01', '2023-06-05'),
('MKH00002', 'MX00002', N'Đà Nẵng', N'Hội An', '2023-06-02', '2023-06-04'),
('MKH00003', 'MX00003', N'Hồ Chí Minh', N'Vũng Tàu', '2023-06-03', '2023-06-06'),
('MKH00004', 'MX00004', N'Hải Phòng', N'Quảng Ninh', '2023-06-04', '2023-06-08'),
('MKH00005', 'MX00005', N'Đà Lạt', N'Nha Trang', '2023-06-05', '2023-06-07'),
('MKH00006', 'MX00006', N'An Giang', N'Vĩnh Long', '2023-06-06', '2023-06-09'),
('MKH00007', 'MX00007', N'Hồ Chí Minh', N'Cần Thơ', '2023-06-07', '2023-06-10'),
('MKH00008', 'MX00001', N'Bình Dương', N'Đồng Nai', '2023-06-08', '2023-06-11'),
('MKH00009', 'MX00006', N'Quảng Bình', N'Đà Nẵng', '2023-06-09', '2023-06-13'),
('MKH00010', 'MX00001', N'Hà Giang', N'Cao Bằng', '2023-06-10', '2023-06-12');

-- Tạo bảng Quản lý hóa đơn
CREATE TABLE QuanLyHoaDon (
    STT INT IDENTITY(1, 1),
    MaHoaDon AS CONVERT(NVARCHAR(20), 'MHD' + RIGHT('000000000' + CAST(STT AS VARCHAR(9)), 9)) PERSISTED PRIMARY KEY,
    MaThue NVARCHAR(20),
    TienThanhToan DECIMAL(18, 2),
    PhuongThucThanhToan NVARCHAR(50),
    NgayThanhToan DATETIME,
    FOREIGN KEY (MaThue) REFERENCES QuanLyThueXe(MaThue)
);
INSERT INTO QuanLyHoaDon (MaThue, TienThanhToan, PhuongThucThanhToan, NgayThanhToan)
VALUES
    ('MT0000001', 1500000, N'Thẻ', '2023-06-01'),
    ('MT0000002', 2500000, N'Tiền mặt', '2023-06-02'),
    ('MT0000003', 1800000, N'Thẻ', '2023-06-03'),
    ('MT0000004', 2100000, N'Tiền mặt', '2023-06-04'),
    ('MT0000005', 1900000, N'Tiền mặt', '2023-06-05'),
    ('MT0000006', 2200000, N'Tiền mặt', '2023-06-06'),
    ('MT0000007', 2000000, N'Thẻ', '2023-06-07'),
    ('MT0000008', 2300000, N'Tiền mặt', '2023-06-08'),
    ('MT0000009', 2400000, N'Tiền mặt', '2023-06-09'),
    ('MT0000010', 2600000, N'Tiền mặt', '2023-06-10');

-- Tạo bảng Bảo dưỡng xe
CREATE TABLE BaoDuongXe (
    MaXe NVARCHAR(10) PRIMARY KEY,
    NgayBaoDuongTruocDo DATETIME,
    NgayBaoDuongTiepTheo DATETIME,
    BaoDuongGi NVARCHAR(100),
    VanDeBaoCao NVARCHAR(100),
    FOREIGN KEY (MaXe) REFERENCES Xe(MaXe)
);

INSERT INTO BaoDuongXe (MaXe, NgayBaoDuongTruocDo, NgayBaoDuongTiepTheo, BaoDuongGi, VanDeBaoCao)
VALUES
    ('MX00001', '2022-12-01', '2023-06-01', N'Bảo dưỡng định kỳ', N'Lốp xe'),
    ('MX00002', '2022-11-25', '2023-05-25', N'Bảo dưỡng định kỳ', N'Phanh xe'),
    ('MX00003', '2022-10-15', '2023-04-15', N'Bảo dưỡng định kỳ', N'Đèn xe'),
    ('MX00004', '2022-09-20', '2023-03-20', N'Bảo dưỡng định kỳ', N'Hệ thống nhiên liệu'),
    ('MX00005', '2022-08-05', '2023-02-05', N'Bảo dưỡng định kỳ', N'Máy lạnh'),
    ('MX00006', '2022-07-12', '2023-01-12', N'Bảo dưỡng định kỳ', N'Hệ thống treo'),
    ('MX00007', '2022-06-22', '2022-12-22', N'Bảo dưỡng định kỳ', N'Hệ thống điều khiển'),
    ('MX00008', '2022-05-18', '2022-11-18', N'Bảo dưỡng định kỳ', N'Hệ thống làm mát'),
    ('MX00009', '2022-04-30', '2022-10-30', N'Bảo dưỡng định kỳ', N'Hệ thống phanh'),
    ('MX00010', '2022-03-15', '2022-09-15', N'Bảo dưỡng định kỳ', N'Hệ thống điện');

-- Tạo bảng Báo cáo
CREATE TABLE BaoCao (
    STT INT IDENTITY(1, 1),
    MaBaoCao AS CONVERT(NVARCHAR(10), 'MBC' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
    NgayBaoCao DATETIME,
    DoanhThuTheoThang DECIMAL(18, 2)
);
INSERT INTO BaoCao (NgayBaoCao, DoanhThuTheoThang)
VALUES
    ('2022-12-31', 1500000),
    ('2023-01-31', 2000000),
    ('2023-02-28', 1800000),
    ('2023-03-31', 2200000),
    ('2023-04-30', 1900000),
    ('2023-05-31', 2300000),
    ('2023-06-30', 2100000),
    ('2023-07-31', 2400000),
    ('2023-08-31', 2200000),
    ('2023-09-30', 2600000);

-- Tạo bảng User
CREATE TABLE Users (
	STT INT IDENTITY(1, 1),
    MaUser AS CONVERT(NVARCHAR(10), 'CRU' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
    Username NVARCHAR(50),
    Password NVARCHAR(50),
    ChucVu NVARCHAR(50),
    LichSuDangNhap NVARCHAR(MAX),
    LichSuThayDoiMatKhau NVARCHAR(MAX)
);

INSERT INTO Users (Username, Password, ChucVu, LichSuDangNhap, LichSuThayDoiMatKhau)
VALUES
    ('user1', 'password1', N'Nhân viên', '2023-06-01 09:30:00', '2023-06-01 09:30:00'),
    ('user2', 'password2', N'Quản lý', '2023-06-01 08:45:00', '2023-06-01 08:45:00'),
    ('user3', 'password3', N'Nhân viên', '2023-06-02 10:15:00', '2023-06-02 10:15:00'),
    ('user4', 'password4', N'Quản lý', '2023-06-03 11:20:00', '2023-06-03 11:20:00'),
    ('user5', 'password5', N'Nhân viên', '2023-06-04 14:30:00', '2023-06-04 14:30:00'),
    ('user6', 'password6', N'Quản lý', '2023-06-05 13:15:00', '2023-06-05 13:15:00'),
    ('user7', 'password7', N'Nhân viên', '2023-06-06 10:45:00', '2023-06-06 10:45:00'),
    ('user8', 'password8', N'Quản lý', '2023-06-07 12:30:00', '2023-06-07 12:30:00'),
    ('user9', 'password9', N'Nhân viên', '2023-06-08 09:10:00', '2023-06-08 09:10:00'),
    ('user10', 'password10', N'Quản lý', '2023-06-09 11:45:00', '2023-06-09 11:45:00');