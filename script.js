document.getElementById('btnShowCars').addEventListener('click', () => {
    // Gửi yêu cầu GET đến đường dẫn '/danhsach'
    fetch('/danhsach')
      .then(response => response.text())
      .then(html => {
        // Hiển thị kết quả truy vấn trong một cửa sổ mới
        const newWindow = window.open();
        newWindow.document.write(html);
      })
      .catch(error => {
        console.log('Error fetching car list:', error);
      });
  });
  