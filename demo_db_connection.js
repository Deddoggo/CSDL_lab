var sql = require('mssql');
var consoleTable = require('console.table');

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

sql.connect(config, function(err) {
    if (err) {
        console.log("Failed to connect to database: " + err);
    } else {
        console.log("Connected to database");
        var request = new sql.Request();
        request.query('SELECT * FROM NhanVien', function(err, recordset) {
    if (err) {
        console.log("Error executing query: " + err);
    } else {
        console.log("Query result:");
        console.table(recordset.recordset);
    }
});

        // Your query execution or other database operations here
    }
});
