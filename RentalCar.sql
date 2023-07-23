-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    STT INT IDENTITY(1, 1),
    MaNhanVien AS CONVERT(NVARCHAR(10), 'MNV' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
    HoTen NVARCHAR(50),
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(100),
    SoCCCD_CMND NVARCHAR(20),
    ChucVu NVARCHAR(50),
	TienLuong DECIMAL(18,2)
);
INSERT INTO NhanVien (HoTen, SoDienThoai, Email, DiaChi, SoCCCD_CMND, ChucVu, TienLuong)
VALUES
   (N'Nguyễn An', '0912345678', N'nguyenan@example.com', N'Hà Nội', '123456789', N'Giám đốc', 10000000),
   (N'Trần Bình', '0987654321', N'tranbinh@example.com', N'Hồ Chí Minh', '987654321', N'Quản lý nhân viên ', 5000000),
   (N'Lê Cường', '0912463598', N'lecuong@example.com', N'Đà Nẵng', '9837747774', N'Quản lý khách hàng', 5000000);

INSERT INTO NhanVien (HoTen, SoDienThoai, Email, DiaChi, SoCCCD_CMND, ChucVu, TienLuong)
VALUES
   (N'Lê Bảo', '03938474774', N'lebao@example.com', N'Đà Nẵng', '3748747743', N'Quản lý xe', 5000000),
   (N'Lê Hưng', '0338383832', N'lehung@example.com', N'Đà Nẵng', '12435655', N'Nhân viên', 4500000),
   (N'Lê Mạnh', '09393', N'lemanh@example.com', N'Đà Nẵng', '93874373', N'Nhân viên', 4500000),
   (N'Lê Thanh', '0933939393', N'lethanh@example.com', N'Đà Nẵng', '0848473', N'Nhân viên', 4500000),
   (N'Lê Thảo', '047483332', N'lethao@example.com', N'Đà Nẵng', '7366738383', N'Nhân viên', 4500000),
   (N'Lê Bống', '063473892', N'lebong@example.com', N'Đà Nẵng', '84848484', N'Nhân viên', 4500000),
   (N'Lê Lợi', '0938835', N'leloi@example.com', N'Đà Nẵng', '838383737', N'Nhân viên', 4500000);

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
VALUES (N'Nguyễn', N'Văn Anh', N'0901234567', N'vana@gmail.com', N'123 Đường ABC, Quận XYZ', N'1234567890', N'Vàng'),
       (N'Trần', N'Thị Bưởi', N'0912345678', N'thib@gmail.com', N'456 Đường DEF, Quận UVW', N'9876543210', N'Bạc'),
       (N'Lê', N'Quang Chanh', N'0987654321', N'quangc@gmail.com', N'789 Đường GHI, Quận RST', N'5432109876', N'Kim Cương'),
       (N'Phạm', N'Thư Danh', N'0911111111', N'thud@gmail.com', N'111 Đường JKL, Quận MNO', N'1111111111', N'Vàng'),
       (N'Hoàng', N'Văn Em', N'0922222222', N'vane@gmail.com', N'222 Đường PQR, Quận STU', N'2222222222', N'Bạc'),
       (N'Nguyễn', N'Thị Hải', N'0933333333', N'thif@gmail.com', N'333 Đường VWX, Quận YZ', N'3333333333', N'Kim Cương'),
       (N'Trần', N'Văn Giang', N'0944444444', N'vang@gmail.com', N'444 Đường YZB, Quận XWV', N'4444444444', N'Vàng'),
       (N'Lê', N'Quang Hồng', N'0955555555', N'quangh@gmail.com', N'555 Đường XWV, Quận ZYX', N'5555555555', N'Bạc'),
       (N'Phạm', N'Thư Lam', N'0966666666', N'thui@gmail.com', N'666 Đường WVX, Quận YZB', N'6666666666', N'Kim Cương'),
       (N'Hoàng', N'Văn Chính', N'0977777777', N'vanj@gmail.com', N'777 Đường ZYX, Quận VWX', N'7777777777', N'Vàng');
INSERT INTO KhachHang (Ho, Ten, SoDienThoai, Email, DiaChi, SoCCCD_CMND, ThanhVien)
VALUES
(N'Nguyễn', N'Thị Hạnh', N'0988888888', N'thihanh@gmail.com', N'888 Đường QWE, Quận RTY', N'8888888888', N'Bạc'),
(N'Trần', N'Quốc Hiệp', N'0999999999', N'quochiep@gmail.com', N'999 Đường RTY, Quận QWE', N'9999999999', N'Kim Cương'),
(N'Lê', N'Thị Linh', N'0900000000', N'thilinh@gmail.com', N'000 Đường YUI, Quận OPA', N'0000000000', N'Vàng'),
(N'Phạm', N'Quang Dũng', N'0911111111', N'quangdung@gmail.com', N'111 Đường OPA, Quận YUI', N'1111111111', N'Bạc'),
(N'Hoàng', N'Thị Phượng', N'0922222222', N'thiphuong@gmail.com', N'222 Đường IOP, Quận UYT', N'2222222222', N'Kim Cương'),
(N'Nguyễn', N'Quang Tùng', N'0933333333', N'quangtung@gmail.com', N'333 Đường TYU, Quận POI', N'3333333333', N'Vàng'),
(N'Trần', N'Thị Hương', N'0944444444', N'thihuong@gmail.com', N'444 Đường POI, Quận TYU', N'4444444444', N'Bạc'),
(N'Lê', N'Quang Thanh', N'0955555555', N'quangthanh@gmail.com', N'555 Đường UIO, Quận IOP', N'5555555555', N'Kim Cương'),
(N'Phạm', N'Thị Nga', N'0966666666', N'thinga@gmail.com', N'666 Đường IOP, Quận UYT', N'6666666666', N'Vàng'),
(N'Hoàng', N'Quang Cường', N'0977777777', N'quangcuong@gmail.com', N'777 Đường YUI, Quận OPA', N'7777777777', N'Bạc');

CREATE TABLE GiaThue(
    LoaiXe NVARCHAR(50) PRIMARY KEY,
	GiaThue DECIMAL(18,2),
);
INSERT INTO GiaThue(LoaiXe, GiaThue)
VALUES
	(N'Sedan', 500000),
	( N'SUV', 200000),
	(N'Hatchback', 1000000),
	(N'Pickup',600000),
	(N'Coupe',400000);
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
    SoKmDaDi INT,
	FOREIGN KEY (LoaiXe) REFERENCES GiaThue(LoaiXe)
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

INSERT INTO Xe (HangXe, LoaiXe, SoChoNgoi, NamSanXuat, BienSo, TinhTrang, ViTriHienTai, NguyenLieu, SoKmDaDi)
VALUES
(N'Nissan', N'SUV', 5, 2020, N'24K-97531', N'Chưa thuê', N'Garage K', N'Xăng', 9000),
(N'Toyota', N'Hatchback', 5, 2022, N'43L-86420', N'Chưa thuê', N'Garage L', N'Xăng', 6000),
(N'Ford', N'Sedan', 4, 2021, N'55M-75310', N'Chưa thuê', N'Garage M', N'Dầu', 8000),
(N'Hyundai', N'SUV', 7, 2023, N'66N-64208', N'Chưa thuê', N'Garage N', N'Xăng', 4000),
(N'Honda', N'Sedan', 5, 2022, N'77O-53109', N'Chưa thuê', N'Garage O', N'Xăng', 3000),
(N'Mercedes-Benz', N'Hatchback', 5, 2021, N'88P-42087', N'Chưa thuê', N'Garage P', N'Xăng', 2000),
(N'Kia', N'Sedan', 5, 2023, N'99Q-31976', N'Chưa thuê', N'Garage Q', N'Dầu', 5000),
(N'Mazda', N'SUV', 7, 2021, N'10R-20865', N'Đã thuê', N'Garage R', N'Xăng', 15000),
(N'Audi', N'Hatchback', 5, 2022, N'11S-09754', N'Chưa thuê', N'Garage S', N'Dầu', 9000),
(N'Chevrolet', N'Sedan', 4, 2020, N'12T-98643', N'Chưa thuê', N'Garage T', N'Xăng', 7000);

-- Tạo bảng Quản lý thuê xe
CREATE TABLE QuanLyThueXe (
    STT INT IDENTITY(1, 1),
    MaThue AS CONVERT(NVARCHAR(20), 'MT' + RIGHT('0000000' + CAST(STT AS VARCHAR(7)), 7)) PERSISTED PRIMARY KEY,
    MaKhachHang NVARCHAR(10),
    MaXe NVARCHAR(10),
    DiaDiemNhanXe NVARCHAR(100),
    DiaDiemTraXe NVARCHAR(100),
    NgayBatDau DATE,
    NgayKetThuc DATE,
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

INSERT INTO QuanLyThueXe (MaKhachHang, MaXe, DiaDiemNhanXe, DiaDiemTraXe, NgayBatDau, NgayKetThuc)
VALUES
('MKH00011', 'MX00002', N'Hải Dương', N'Hà Nội', '2023-06-11', '2023-06-13'),
('MKH00012', 'MX00003', N'Hồ Chí Minh', N'Da Lat', '2023-06-12', '2023-06-15'),
('MKH00013', 'MX00024', N'Hà Nội', N'Hải Phòng', '2023-06-13', '2023-06-16'),
('MKH00014', 'MX00005', N'Đà Nẵng', N'Quảng Nam', '2023-06-14', '2023-06-17'),
('MKH00015', 'MX00006', N'Hồ Chí Minh', N'Cà Mau', '2023-06-15', '2023-06-19'),
('MKH00016', 'MX00007', N'Bà Rịa - Vũng Tàu', N'Đồng Nai', '2023-06-16', '2023-06-18'),
('MKH00017', 'MX00001', N'Phú Quốc', N'Rạch Giá', '2023-06-17', '2023-06-20'),
('MKH00018', 'MX00008', N'Đồng Tháp', N'Cần Thơ', '2023-06-18', '2023-06-21'),
('MKH00019', 'MX00009', N'Quảng Ninh', N'Hạ Long', '2023-06-19', '2023-06-22'),
('MKH00001', 'MX00015', N'Yên Bái', N'Sơn La', '2023-06-20', '2023-06-24'),
('MKH00003', 'MX00016', N'Hồ Chí Minh', N'Bình Dương', '2023-06-21', '2023-06-23'),
('MKH00004', 'MX00017', N'Đà Nẵng', N'Hội An', '2023-06-22', '2023-06-25'),
('MKH00005', 'MX00018', N'Hải Phòng', N'Hạ Long', '2023-06-23', '2023-06-26'),
('MKH00020', 'MX00019', N'Nha Trang', N'Đà Lạt', '2023-06-24', '2023-06-27'),
('MKH00007', 'MX00020', N'Bà Rịa - Vũng Tàu', N'Phan Thiết', '2023-06-25', '2023-06-29');

-- Tạo bảng Quản lý hóa đơn
CREATE TABLE QuanLyHoaDon (
    STT INT IDENTITY(1, 1),
    MaHoaDon AS CONVERT(NVARCHAR(20), 'MHD' + RIGHT('000000000' + CAST(STT AS VARCHAR(9)), 9)) PERSISTED PRIMARY KEY,
    MaThue NVARCHAR(20),
    TienThanhToan DECIMAL(18, 2),
    PhuongThucThanhToan NVARCHAR(50),
    NgayThanhToan DATE,
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
    NgayBaoDuongTruocDo DATE,
    NgayBaoDuongTiepTheo DATE,
    BaoDuongGi NVARCHAR(100),
    VanDeBaoCao NVARCHAR(100),
	TienBaoDuong DECIMAL(18,2),
    FOREIGN KEY (MaXe) REFERENCES Xe(MaXe)
);


INSERT INTO BaoDuongXe (MaXe, NgayBaoDuongTruocDo, NgayBaoDuongTiepTheo, BaoDuongGi, VanDeBaoCao, TienBaoDuong)
VALUES
    ('MX00001', '2022-12-01', '2023-06-01', N'Bảo dưỡng định kỳ', N'Lốp xe', 500000),
    ('MX00002', '2022-11-25', '2023-05-25', N'Bảo dưỡng định kỳ', N'Phanh xe', 200000),
    ('MX00003', '2022-10-15', '2023-04-15', N'Bảo dưỡng định kỳ', N'Đèn xe', 100000),
    ('MX00004', '2022-09-20', '2023-03-20', N'Bảo dưỡng định kỳ', N'Hệ thống nhiên liệu', 300000),
    ('MX00005', '2022-08-05', '2023-02-05', N'Bảo dưỡng định kỳ', N'Máy lạnh', 600000),
    ('MX00006', '2022-07-12', '2023-06-12', N'Bảo dưỡng định kỳ', N'Hệ thống treo', 500000),
    ('MX00007', '2022-06-22', '2022-12-22', N'Bảo dưỡng định kỳ', N'Hệ thống điều khiển', 100000),
    ('MX00008', '2022-05-18', '2022-11-18', N'Bảo dưỡng định kỳ', N'Hệ thống làm mát', 200000),
    ('MX00009', '2022-04-30', '2022-10-30', N'Bảo dưỡng định kỳ', N'Hệ thống phanh', 400000),
    ('MX00010', '2022-03-15', '2022-09-15', N'Bảo dưỡng định kỳ', N'Hệ thống điện', 200000);
INSERT INTO BaoDuongXe (MaXe, NgayBaoDuongTruocDo, NgayBaoDuongTiepTheo, BaoDuongGi, VanDeBaoCao, TienBaoDuong)
VALUES
('MX00015', '2022-11-01', '2023-05-01', N'Bảo dưỡng định kỳ', N'Lốp xe', 500000),
('MX00016', '2022-10-25', '2023-04-25', N'Bảo dưỡng định kỳ', N'Phanh xe', 200000),
('MX00017', '2022-09-15', '2023-03-15', N'Bảo dưỡng định kỳ', N'Đèn xe', 100000),
('MX00018', '2022-08-20', '2023-02-20', N'Bảo dưỡng định kỳ', N'Hệ thống nhiên liệu', 300000),
('MX00019', '2022-07-05', '2023-01-05', N'Bảo dưỡng định kỳ', N'Máy lạnh', 600000),
('MX00020', '2022-06-12', '2023-06-12', N'Bảo dưỡng định kỳ', N'Hệ thống treo', 500000),
('MX00021', '2022-05-22', '2022-11-22', N'Bảo dưỡng định kỳ', N'Hệ thống điều khiển', 100000),
('MX00022', '2022-04-18', '2022-10-18', N'Bảo dưỡng định kỳ', N'Hệ thống làm mát', 200000),
('MX00023', '2022-03-30', '2022-09-30', N'Bảo dưỡng định kỳ', N'Hệ thống phanh', 400000),
('MX00024', '2022-02-15', '2022-08-15', N'Bảo dưỡng định kỳ', N'Hệ thống điện', 200000);

-- Tạo bảng User
CREATE TABLE Users (
	STT INT IDENTITY(1, 1),
    MaUser AS CONVERT(NVARCHAR(10), 'CRU' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
	MaNhanVien NVARCHAR(10),
    Username NVARCHAR(50),
    Password NVARCHAR(50),
	FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
);


INSERT INTO Users (MaNhanVien, Username, Password)
VALUES
    ('MNV00001', 'user1', 'password1'),
    ('MNV00002', 'user2', 'password2'),
	('MNV00003', 'user3', 'password3');
INSERT INTO Users (MaNhanVien, Username, Password)
VALUES
	('MNV00004', 'user4', 'password4'),
	('MNV00005', 'user5', 'password5'),
	('MNV00006', 'user6', 'password6'),
	('MNV00007', 'user7', 'password7'),
	('MNV00008', 'user8', 'password8'),
	('MNV00009', 'user9', 'password9'),
	('MNV00010', 'user10', 'password10');


CREATE TABLE DeletedBill (
    MaHoaDon NVARCHAR(20),
    MaThue NVARCHAR(20),
    TienThanhToan DECIMAL(18, 2),
    PhuongThucThanhToan NVARCHAR(50),
    NgayThanhToan DATE,
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

CREATE TABLE DeletedRentCar (
    MaThue NVARCHAR(20),
    MaKhachHang NVARCHAR(10),
    MaXe NVARCHAR(10),
    DiaDiemNhanXe NVARCHAR(100),
    DiaDiemTraXe NVARCHAR(100),
    NgayBatDau DATE,
    NgayKetThuc DATE,
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

CREATE TABLE DeletedCustomer (
    MaKhachHang NVARCHAR(10),
    Ho NVARCHAR(50),
    Ten NVARCHAR(50),
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(100),
    SoCCCD_CMND NVARCHAR(20),
    ThanhVien NVARCHAR(50),
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

CREATE TABLE DeletedCar (
    MaXe NVARCHAR(10),
    HangXe NVARCHAR(50),
    LoaiXe NVARCHAR(50),
    SoChoNgoi INT,
    NamSanXuat INT,
    BienSo NVARCHAR(20),
    TinhTrang NVARCHAR(20),
    ViTriHienTai NVARCHAR(100),
    NguyenLieu NVARCHAR(50),
    SoKmDaDi INT,
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

CREATE TABLE DeletedMaintenance (
	MaXe NVARCHAR(10) ,
    NgayBaoDuongTruocDo DATE,
    NgayBaoDuongTiepTheo DATE,
    BaoDuongGi NVARCHAR(100),
    VanDeBaoCao NVARCHAR(100),
	TienBaoDuong DECIMAL(18,2),
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

CREATE TABLE DeletedPrice (
	LoaiXe NVARCHAR(50),
	Gia DECIMAL(18,2),
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

CREATE TABLE DeletedUser (
	MaUser NVARCHAR(10),
	MaNhanVien NVARCHAR(10),
    Username NVARCHAR(50),
    Password NVARCHAR(50),
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

CREATE TABLE DeletedEmployee (
	MaNhanVien NVARCHAR(10),
    HoTen NVARCHAR(50),
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(100),
    SoCCCD_CMND NVARCHAR(20),
    ChucVu NVARCHAR(50),
	TienLuong DECIMAL(18,2),
	DeletedBy NVARCHAR(50),
    DeletedDate DATETIME
);

--Set Role
---role----
--Phân quyền trong sql server 
CREATE ROLE [Giám đốc]
GRANT CONTROL TO [Giám đốc]
CREATE ROLE [Quản lý xe]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Xe TO [Quản lý xe]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Baoduongxe TO [Quản lý xe]
GRANT SELECT ON SCHEMA::dbo TO [Quản lý xe]
CREATE ROLE [Quản lý khách hàng]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.KhachHang TO [Quản lý khách hàng]
GRANT SELECT ON SCHEMA::dbo TO [Quản lý khách hàng]
CREATE ROLE [Quản lý nhân viên]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.NhanVien TO [Quản lý nhân viên]
GRANT SELECT ON SCHEMA::dbo TO [Quản lý nhân viên]
CREATE ROLE [Nhân viên]
GRANT SELECT ON SCHEMA::dbo TO [Nhân viên]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.quanlythuexe TO [Nhân Viên]
USE master;
CREATE LOGIN user1 WITH PASSWORD = 'password1';
CREATE LOGIN user2 WITH PASSWORD = 'password2';
CREATE LOGIN user3 WITH PASSWORD = 'password3';
CREATE LOGIN user4 WITH PASSWORD = 'password4';
CREATE LOGIN user5 WITH PASSWORD = 'password5';
CREATE LOGIN user6 WITH PASSWORD = 'password6';
CREATE LOGIN user7 WITH PASSWORD = 'password7';
CREATE LOGIN user8 WITH PASSWORD = 'password8';
CREATE LOGIN user9 WITH PASSWORD = 'password9';
CREATE LOGIN user10 WITH PASSWORD = 'password10';
USE CarRental;
CREATE USER user1 FOR LOGIN user1;
ALTER ROLE [Giám đốc] ADD MEMBER user1;
CREATE USER user2 FOR LOGIN user2;
ALTER ROLE [Quản lý nhân viên] ADD MEMBER user2;
CREATE USER user3 FOR LOGIN user3;
ALTER ROLE [Quản lý khách hàng] ADD MEMBER user3;
CREATE USER user4 FOR LOGIN user4;
ALTER ROLE [Quản lý Xe] ADD MEMBER user4;
CREATE USER user5 FOR LOGIN user5;
ALTER ROLE [Nhân viên] ADD MEMBER user5;
CREATE USER user6 FOR LOGIN user6;
ALTER ROLE [Nhân viên] ADD MEMBER user6;
CREATE USER user7 FOR LOGIN user7;
ALTER ROLE [Nhân viên] ADD MEMBER user7;
CREATE USER user8 FOR LOGIN user8;
ALTER ROLE [Nhân viên] ADD MEMBER user8;
CREATE USER user9 FOR LOGIN user9;
ALTER ROLE [Nhân viên] ADD MEMBER user9;
CREATE USER user10 FOR LOGIN user10;
ALTER ROLE [Nhân viên] ADD MEMBER user10;
EXEC sp_helplogins 'user1';