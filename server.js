const express = require('express');
const app = express();
const sql = require('mssql');

// Kết nối tới cơ sở dữ liệu SQL Server
const config = {
  user: 'your_username',
  password: 'your_password',
  server: 'your_server',
  database: 'your_database',
};

sql.connect(config, (err) => {
  if (err) {
    console.log(err);
  } else {
    console.log('Connected to SQL Server');
  }
});

// Định nghĩa các tuyến đường (routes)
app.get('/', (req, res) => {
  res.send('Hello, world!');
});

// Khởi chạy server
app.listen(3000, () => {
  console.log('Server started on port 3000');
});
