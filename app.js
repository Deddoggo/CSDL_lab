// Định nghĩa các thư mục sẽ sử dụng
const express = require('express');
const app = express();
const path = require('path');
var sql = require('mssql');
var consoleTable = require('console.table');
const fs = require('fs');
const { connect } = require('http2');
app.use( express.static('public'));
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

      // Your query execution or other database operations here
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
app.get('/data', (req, res) => {
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

// Khởi động máy chủ
app.listen(3000, () => {
  console.log('Server is running on port 3000');
});