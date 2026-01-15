const mysql = require('mysql2/promise');
const pool = mysql.createPool({
  host: 'localhost',
  user: 'test',
  password: '2612',
  database: 'sistema_rh',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
})

module.exports = pool