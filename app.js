// Định nghĩa các thư mục sẽ sử dụng
const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const addCarHandler = require('./themxe.js');
const path = require('path');
var sql = require('mssql');
var consoleTable = require('console.table');
const fs = require('fs');
const { connect } = require('http2');
app.use( express.static('public'));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
// Cấu hình đường dẫn cho các tệp HTML
const htmlDir = path.join(__dirname, 'views');
// Thiet lap Db de dang nhap
const configForLogIn = {
  server: 'DESKTOP-2MP8OGB',
  database: 'RentalCar',
  port: 1433,
  authentication: {
    type: 'default',
    options: {
      userName: 'sa',
      password: '2308'
    }
  },
  options: {
    encrypt: false,
    enableArithAbort: true
  }
};

// Kết nối với Db để lấy thông tin bảng Users
sql.connect(configForLogIn, function(err) {
  if (err) {
    console.log("Failed to connect to database: " + err);
  } else {
    console.log("Connected to database to get Users table info");
  }
});
app.post('/logout', function(req, res) {
  // Ngắt kết nối config
  sql.close(function(err) {
    if (err) {
      console.log("Failed to close database connection: " + err);
    } else {
      console.log("Closed database connection");
    }
  });

  // Kết nối lại với configForLogIn
  sql.connect(configForLogIn, function(err) {
    if (err) {
      console.log("Failed to connect to database: " + err);
    } else {
      console.log("Connected to database to get Users table info");
    }
  });

  // Chuyển hướng người dùng về trang đăng nhập
  res.redirect('/signin.html');
});

app.post('/login', function(req, res) {
  const username = req.body.username;
  const password = req.body.password;

  // Tạo truy vấn SQL để kiểm tra thông tin đăng nhập
  const query = `SELECT * FROM Users WHERE username LIKE '%${username}%' AND password LIKE '%${password}%'`;

  // Thực hiện truy vấn SQL
  const request = new sql.Request();
  request.query(query, function(err, result) {
    if (err) {
      console.log("Error executing SQL query: " + err);
      res.json({ success: false, message: "Error executing SQL query" });
    } else {
      // Kiểm tra kết quả truy vấn
      if (result.recordset.length > 0) {
        // Đóng kết nối configForLogIn sau khi đăng nhập thành công
        sql.close(function(err) {
          if (err) {
            console.log("Failed to close database connection: " + err);
          } else {
            console.log("Closed database connection");
          }
        });

        // Thiết lập Db để thực hiện các chức năng khác
        const config = {
          server: 'DESKTOP-2MP8OGB',
          database: 'RentalCar',
          port: 1433,
          authentication: {
            type: 'default',
            options: {
              userName: username,
              password: password
            }
          },
          options: {
            encrypt: false,
            enableArithAbort: true
          }
        };

        // Kết nối với Db để thực hiện các chức năng khác
        sql.connect(config, function(err) {
          if (err) {
            console.log("Failed to connect to database: " + err);
          } else {
            console.log("Connected to database for other functions");
          }
        });

        res.json({ success: true, message: "Login successful" });
      } else {
        res.json({ success: false, message: "Invalid username or password" });
      }
    }
  });
});
// Reset lai cac ket noi khi dang xuat

module.exports = connect ;
// Định vị thư mục chứa các tệp tĩnh
app.use('/assets', express.static(path.join(__dirname, 'views', 'assets')));

// Định vị thư mục chứa các tệp HTML
app.set('views', path.join(__dirname, 'views'));

app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');

// Xử lý các yêu cầu truy cập các tệp HTML
app.use((req, res, next) => {
  const filePath = path.join(htmlDir, req.path);
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (!err) {
      res.sendFile(filePath);
    } else {
      next();
    }
  });
});

// ... Định nghĩa các route khác
//Truy van danh sach xe
app.get('/danhsachxe', (req, res) => {
  // Thực hiện truy vấn SQL để lấy thông tin về các loại xe
  const query = 'SELECT * FROM Xe';
  sql.query(query)
    .then((result) => {
      // Gửi kết quả về cho máy khách
      res.json(result.recordset);
    })
    .catch((error) => {
      console.log('Error executing SQL query:', error);
      res.status(500).send('Internal Server Error');
    });
});

// Truy van cac xe can phai bao duong
app.get('/baoduong', (req, res) => {
  // Thực hiện truy vấn SQL để lấy thông tin về các loại xe
  const query = ' SELECT Xe.* FROM Xe JOIN BaoDuongXe ON Xe.MaXe = BaoDuongXe.MaXe WHERE BaoDuongXe.NgayBaoDuongTiepTheo < GETDATE();';
  sql.query(query)
    .then((result) => {
      // Gửi kết quả về cho máy khách
      res.json(result.recordset);
    })
    .catch((error) => {
      console.log('Error executing SQL query:', error);
      res.status(500).send('Internal Server Error');
    });
});

// Truy van cac xe can tim theo bien so
app.get('/timxe', (req, res) => {
  // Lấy biển số xe từ yêu cầu của người dùng
  const licensePlate = req.query.licensePlate;

  // Thực hiện truy vấn SQL để lấy thông tin về các loại xe dựa trên biển số
  const query = `SELECT * FROM Xe WHERE BienSo LIKE '%${licensePlate}%'`;

  sql.query(query)
    .then((result) => {
      // Gửi kết quả về cho máy khách
      res.json(result.recordset);
    })
    .catch((error) => {
      console.log('Error executing SQL query:', error);
      res.status(500).send('Internal Server Error');
    });
});
// Them thong tin xe
app.post('/themxe', (req, res) => {
  // Lấy thông tin xe từ yêu cầu POST
  const hangXe = req.body.hangXe;
  const loaiXe = req.body.loaiXe;
  const namSanXuat = req.body.namSanXuat;
  const bienSo = req.body.bienSo;
  const nguyenLieu = req.body.nguyenLieu;
  const soKmDaDi = req.body.soKmDaDi;
  const soChoNgoi = req.body.soChoNgoi;
  const viTriHienTai = req.body.viTriHienTai;
  // Thực hiện truy vấn SQL để thêm thông tin xe vào cơ sở dữ liệu
  const query = `INSERT INTO Xe (TinhTrang ,HangXe, LoaiXe, NamSanXuat, BienSo, NguyenLieu, SoKmDaDi, SoChoNgoi, ViTriHienTai) VALUES (N'Chưa thuê',N'${hangXe}', N'${loaiXe}', N'${namSanXuat}', N'${bienSo}', N'${nguyenLieu}', N'${soKmDaDi}', N'${soChoNgoi}', N'${viTriHienTai}')`;
  sql.query(query)
    .then(() => {
      // Trả về mã trạng thái 200 để chỉ rằng thêm xe thành công
      res.json({ success: true, message: 'Thêm thành công' });
    })
    .catch(error => {
      console.log('Error adding car:', error);
      // Trả về kết quả lỗi dưới dạng JSON
      res.status(500).json({ success: false, message: 'Có lỗi xảy ra khi thêm xe' });
    });
});
// xoa xe khoi bang
  //tim xe de xoa
  app.get('/timxedexoa', (req, res) => {
    // Lấy biển số xe từ yêu cầu của người dùng
    const carCode = req.query.carCode;
  
    // Thực hiện truy vấn SQL để lấy thông tin về các loại xe dựa trên biển số
    const query = `SELECT * FROM Xe WHERE MaXe LIKE '%${carCode}%'`;
  
    sql.query(query)
      .then((result) => {
        // Gửi kết quả về cho máy khách
        res.json(result.recordset);
      })
      .catch((error) => {
        console.log('Error executing SQL query:', error);
        res.status(500).send('Internal Server Error');
      });
  });
  // Xoa thong tin xe
  app.post('/xoaxe', (req, res) => {
    const carCode = req.body.carCode;
  
    // Thực hiện truy vấn SQL để xóa thông tin xe từ cơ sở dữ liệu dựa trên mã xe
    const query = `DELETE FROM Xe WHERE MaXe='${carCode}'`;
    sql.query(query)
    .then(() => {
      // Trả về mã trạng thái 200 để chỉ rằng thêm xe thành công
      res.json({ success: true, message: 'Xóa thành công' });
    })
    .catch(error => {
      console.log('Error deleting car:', error);
      // Trả về kết quả lỗi dưới dạng JSON
      res.status(500).json({ success: false, message: 'Có lỗi xảy ra khi xóa xe' });
    });
  });
//Thay doi thong tin cua xe
  //Tim xe de sua
  app.get('/timxedesua', (req, res) => {
    // Lấy biển số xe từ yêu cầu của người dùng
    const carCode = req.query.carCode;
  
    // Thực hiện truy vấn SQL để lấy thông tin về các loại xe dựa trên biển số
    const query = `SELECT * FROM Xe WHERE MaXe LIKE '%${carCode}%'`;
  
    sql.query(query)
      .then((result) => {
        // Gửi kết quả về cho máy khách
        res.json(result.recordset);
      })
      .catch((error) => {
        console.log('Error executing SQL query:', error);
        res.status(500).send('Internal Server Error');
      });
  });
  //Sua thong tin xe
  // Sua thong tin xe
app.post('/suaxe', (req, res) => {
  // Lấy thông tin xe từ yêu cầu POST
  const carCode = req.body.carCode;
  const bienSo = req.body.bienSo;
  const tinhTrang = req.body.tinhTrang;
  const viTriHienTai = req.body.viTriHienTai;
  
  // Thực hiện truy vấn SQL để sửa thông tin xe trong cơ sở dữ liệu
  const query = `UPDATE Xe SET BienSo=N'${bienSo}', TinhTrang=N'${tinhTrang}', ViTriHienTai=N'${viTriHienTai}' WHERE MaXe=N'${carCode}'`;
  sql.query(query)
    .then(() => {
      // Trả về mã trạng thái 200 để chỉ rằng sửa xe thành công
      res.json({ success: true, message: 'sửa thành công' });
    })
    .catch(error => {
      console.log('Error adding car:', error);
      // Trả về kết quả lỗi dưới dạng JSON
      res.status(500).json({ success: false, message: 'Có lỗi xảy ra khi sửa xe' });
    });
});
// Quan ly thue xe
// Tim kiem hoa don
app.get('/timhoadon', (req, res) => {
  const MaHoaDon = req.query.BillID;

  const query = `SELECT * FROM QuanLyHoaDon WHERE MaHoaDon LIKE '%${MaHoaDon}%'`;

  sql.query(query)
    .then((result) => {
      res.json(result.recordset);
    })
    .catch((error) => {
      console.log('Error executing SQL query:', error);
      res.status(500).send('Internal Server Error');
    });
});
//Tim thong tin thue xe
app.get('/timthongtinthuexe', (req, res) => {
  // Lấy tên khách hàng từ yêu cầu của người dùng
  const customerName = req.query.customerName;

  // Thực hiện truy vấn SQL để tìm thông tin thuê xe dựa trên tên khách hàng
  const query = `SELECT CONCAT(KhachHang.Ho, ' ', KhachHang.Ten) AS HoTen,
                        KhachHang.SoDienThoai,
                        KhachHang.Email,
                        KhachHang.MaKhachHang,
                        QuanLyThueXe.MaXe,
                        QuanLyThueXe.MaThue,
                        QuanLyThueXe.DiaDiemNhanXe,
                        QuanLyThueXe.DiaDiemTraXe,
                        QuanLyThueXe.NgayBatDau,
                        QuanLyThueXe.NgayKetThuc
                FROM KhachHang
                INNER JOIN QuanLyThueXe ON KhachHang.MaKhachHang = QuanLyThueXe.MaKhachHang
                WHERE CONCAT(KhachHang.Ho, ' ', KhachHang.Ten) LIKE N'%${customerName}%'`;

  sql.query(query)
    .then(result => {
      // Gửi kết quả về cho máy khách
      res.json(result.recordset);
    })
    .catch(error => {
      console.log('Error executing SQL query:', error);
      res.status(500).send('Internal Server Error');
    });
});
// Them thong tin thue xe
app.post('/themthongtindatxe', (req, res) => {
  // Lấy thông tin đặt xe từ yêu cầu POST
  const maKH = req.body.maKH;
  const maXe = req.body.maXe;
  const diemNhanXe = req.body.diemNhanXe;
  const diemTraXe = req.body.diemTraXe;
  const ngayBatDau = convertDateFormat(req.body.ngayBatDau);
  const ngayKetThuc = convertDateFormat(req.body.ngayKetThuc);
  function convertDateFormat(inputDate) {
    // Tách ngày, tháng và năm từ input
    const parts = inputDate.split('/');
    const day = parts[0];
    const month = parts[1];
    const year = parts[2];

    // Tạo định dạng mới "yyyy-mm-dd"
    const convertedDate = `${year}-${month}-${day}`;

    return convertedDate;
    }
  // Thực hiện truy vấn SQL để thêm thông tin đặt xe vào cơ sở dữ liệu
  const query = `INSERT INTO QuanLyThueXe (MaKhachHang, MaXe, DiaDiemNhanXe, DiaDiemTraXe, NgayBatDau, NgayKetThuc) 
                 VALUES (N'${maKH}', N'${maXe}', N'${diemNhanXe}', N'${diemTraXe}', '${ngayBatDau}', '${ngayKetThuc}')`;
  sql.query(query)
  .then(() => {
    // Trả về mã trạng thái 200 để chỉ rằng thêm xe thành công
    res.json({ success: true, message: 'Thêm thông tin thuê thành công' });
  })
  .catch(error => {
    console.log('Error adding rental:', error);
    // Trả về kết quả lỗi dưới dạng JSON
    res.status(500).json({ success: false, message: 'Có lỗi xảy ra khi thêm thông tin thuê xe' });
  });
});
//Tim thong tin thue xe de xoa
app.get('/timmathue', (req, res) => {
  // Lấy tên khách hàng từ yêu cầu của người dùng
  const rentalCode = req.query.rentalCode;

  // Thực hiện truy vấn SQL để tìm thông tin thuê xe dựa trên tên khách hàng
  const query = `SELECT CONCAT(KhachHang.Ho, ' ', KhachHang.Ten) AS HoTen,
                        KhachHang.SoDienThoai,
                        KhachHang.Email,
                        KhachHang.MaKhachHang,
                        QuanLyThueXe.MaXe,
                        QuanLyThueXe.DiaDiemNhanXe,
                        QuanLyThueXe.DiaDiemTraXe,
                        QuanLyThueXe.NgayBatDau,
                        QuanLyThueXe.NgayKetThuc
                FROM KhachHang
                INNER JOIN QuanLyThueXe ON KhachHang.MaKhachHang = QuanLyThueXe.MaKhachHang
                WHERE MaThue LIKE N'%${rentalCode}%'`;

  sql.query(query)
    .then(result => {
      // Gửi kết quả về cho máy khách
      res.json(result.recordset);
    })
    .catch(error => {
      console.log('Error executing SQL query:', error);
      res.status(500).send('Internal Server Error');
    });
});
// Xoa thong tin xe
app.post('/xoathongtinthuexe', (req, res) => {
  const rentalCode = req.body.rentalCode;

  // Thực hiện truy vấn SQL để xóa thông tin xe từ cơ sở dữ liệu dựa trên mã xe
  const query = `DELETE FROM QuanLyThueXe WHERE MaThue='${rentalCode}'`;
  sql.query(query)
  .then(() => {
    // Trả về mã trạng thái 200 để chỉ rằng thêm xe thành công
    res.json({ success: true, message: 'Xóa thông tin thuê thành công' });
  })
  .catch(error => {
    console.log('Error deleting rental:', error);
    // Trả về kết quả lỗi dưới dạng JSON
    res.status(500).json({ success: false, message: 'Có lỗi xảy ra khi xóa thông tin thuê xe' });
  });
});
//Tim thong tin thue xe de sua
app.get('/timmathue', (req, res) => {
  // Lấy tên khách hàng từ yêu cầu của người dùng
  const rentalCode = req.query.rentalCode;

  // Thực hiện truy vấn SQL để tìm thông tin thuê xe dựa trên tên khách hàng
  const query = `SELECT CONCAT(KhachHang.Ho, ' ', KhachHang.Ten) AS HoTen,
                        KhachHang.SoDienThoai,
                        KhachHang.Email,
                        KhachHang.MaKhachHang,
                        QuanLyThueXe.MaXe,
                        QuanLyThueXe.DiaDiemNhanXe,
                        QuanLyThueXe.DiaDiemTraXe,
                        QuanLyThueXe.NgayBatDau,
                        QuanLyThueXe.NgayKetThuc
                FROM KhachHang
                INNER JOIN QuanLyThueXe ON KhachHang.MaKhachHang = QuanLyThueXe.MaKhachHang
                WHERE MaThue LIKE N'%${rentalCode}%'`;

  sql.query(query)
    .then(result => {
      // Gửi kết quả về cho máy khách
      res.json(result.recordset);
    })
    .catch(error => {
      console.log('Error executing SQL query:', error);
      res.status(500).send('Internal Server Error');
    });
});
//Sua thong tin thue xe
app.post('/suathongtinthuexe', (req, res) => {
  // Lấy thông tin xe từ yêu cầu POST
  const rentalCode = req.body.rentalCode;
  const maKH = req.body.maKH;
  const maXe = req.body.maXe;
  const diemNhanXe = req.body.diemNhanXe;
  const diemTraXe = req.body.diemTraXe;
  const ngayBatDau = convertDateFormat(req.body.ngayBatDau);
  const ngayKetThuc = convertDateFormat(req.body.ngayKetThuc);
  function convertDateFormat(inputDate) {
    // Tách ngày, tháng và năm từ input
    const parts = inputDate.split('/');
    const day = parts[0];
    const month = parts[1];
    const year = parts[2];
    // Tạo định dạng mới "yyyy-mm-dd"
    const convertedDate = `${year}-${month}-${day}`;

    return convertedDate;
    }
  // Thực hiện truy vấn SQL để sửa thông tin xe trong cơ sở dữ liệu
  const query = `UPDATE QuanLyThueXe SET MaKhachHang=N'${maKH}', MaXe=N'${maXe}', DiaDiemNhanXe=N'${diemNhanXe}',DiaDiemTraXe=N'${diemTraXe}',NgayBatDau=N'${ngayBatDau}',NgayKetThuc=N'${ngayKetThuc}' 
  WHERE MaThue=N'${rentalCode}'`;
  sql.query(query)
  .then(() => {
    // Trả về mã trạng thái 200 để chỉ rằng thêm xe thành công
    res.json({ success: true, message: 'Sửa thông tin thuê thành công' });
  })
  .catch(error => {
    console.log('Error updating rental:', error);
    // Trả về kết quả lỗi dưới dạng JSON
    res.status(500).json({ success: false, message: 'Có lỗi xảy ra khi sửa thông tin thuê xe' });
  });
});

// Khởi động máy chủ
app.listen(3000, () => {
  console.log('Server is running on port 3000');
});