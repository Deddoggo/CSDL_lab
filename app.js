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
// Thiết lập Db
var config = {
  server: 'DESKTOP-2MP8OGB',
  database: 'RentalCar',
  port:1433 ,
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

// Kết nối với Db
sql.connect(config, function(err) {
  if (err) {
      console.log("Failed to connect to database: " + err);
  } else {
      console.log("Connected to database");

  }
});
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
      res.send('Thêm thành công');
    })
    .catch(error => {
      res.send('Thêm thất bại');
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
      // Trả về mã trạng thái 200 để chỉ rằng xóa xe thành công
      res.send('Xóa thành công');
    })
    .catch(error => {
      res.send('Xóa thất bại');
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
      res.send('Sửa thành công');
    })
    .catch(error => {
      res.send('Sửa thất bại');
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
      // Trả về mã trạng thái 200 để chỉ rằng thêm thông tin đặt xe thành công
      res.send('Đặt xe thành công');
    })
    .catch(error => {
      res.send('Đặt xe thất bại');
      console.log(error);
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
    // Trả về mã trạng thái 200 để chỉ rằng xóa xe thành công
    res.send('Xóa thành công');
  })
  .catch(error => {
    res.send('Xóa thất bại');
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
      // Trả về mã trạng thái 200 để chỉ rằng sửa xe thành công
      res.send('Sửa thành công');
    })
    .catch(error => {
      res.send('Sửa thất bại');
    });
});
app.post('/login', async (req, res) => {
  const username = req.body.username;
  const password = req.body.password;

  try {
    const pool = await sql.connect(config);

    const query = `SELECT * FROM Users WHERE Username = @username AND Password = @password`;
    const result = await pool.request()
      .input('username', sql.NVarChar, username)
      .input('password', sql.NVarChar, password)
      .query(query);

    if (result.recordset.length > 0) {
      res.send({ success: true });
    } else {
      res.send({ success: false });
    }
  } catch (error) {
    console.error('Error checking login:', error);
    res.send({ success: false });
  }
});
// Khởi động máy chủ
app.listen(3000, () => {
  console.log('Server is running on port 3000');
});