const mysql = require('mysql2/promise');

const path = require('path');
require("dotenv").config({ path: path.join(__dirname, '/config/.env') });

const pool = mysql.createPool({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0  
  
})
let connection;

async function getFuncionarios() {
    connection = await pool.getConnection();
    const [rows, fields] = await connection.query('select * from funcionarios');
    connection.release();
    return rows;
      
    
}
async function getFuncionariosbyID(id) {

    connection = await pool.getConnection();
    const [rows, fields] = await connection.query(`select * from funcionarios where funcionario_id = ?`, [id])
    connection.release();
    return rows
  
}
module.exports = {getFuncionarios, getFuncionariosbyID};