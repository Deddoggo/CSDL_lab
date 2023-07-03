app.get('/danhsach', (req, res) => {
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