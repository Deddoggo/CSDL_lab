const express = require('express');
const router = express.Router();
const sql = require('mssql');

// Xử lý yêu cầu POST khi người dùng gửi biểu mẫu
router.post('/themxe', (req, res) => {
  const hangXe = req.body.hangXe;
  const loaiXe = req.body.loaiXe;
  const namSanXuat = req.body.namSanXuat;
  const bienSo = req.body.bienSo;
  const nguyenLieu = req.body.nguyenLieu;
  const soKmDaDi = req.body.soKmDaDi;
  const soChoNgoi = req.body.soChoNgoi;
  const viTriHienTai = req.body.viTriHienTai;

  // Kết nối đến cơ sở dữ liệu
  sql.connect(config)
    .then(() => {
      // Tạo truy vấn SQL để thêm thông tin xe vào cơ sở dữ liệu
      const query = `INSERT INTO Xe (HangXe, LoaiXe, NamSanXuat, BienSo, NguyenLieu, SoKmDaDi, SoChoNgoi, ViTriHienTai) VALUES ('${hangXe}', '${loaiXe}', '${namSanXuat}', '${bienSo}', '${nguyenLieu}', '${soKmDaDi}', '${soChoNgoi}', '${viTriHienTai}')`;
      
      // Thực hiện truy vấn SQL
      return sql.query(query);
    })
    .then(() => {
      // Gửi phản hồi thành công về cho người dùng
      res.sendStatus(200);
    })
    .catch(error => {
      console.log('Error adding car:', error);
      // Gửi phản hồi lỗi về cho người dùng
      res.sendStatus(500);
    });
});

module.exports = router;
