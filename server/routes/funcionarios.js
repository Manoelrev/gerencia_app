var express = require('express');
var router = express.Router();
var pool = require( '../sql/funcionarios_views.js');

router.get('/', async function (req, res, next) {
  let connection;
  try {
    connection = await pool.getConnection();
    const [rows, fields] = await connection.query('select * from funcionarios');
    res.json(rows)
  } catch (err) {
    res.status(500).json({error: 'internal server error'})
  } finally {
  if (connection) connection.release();
  }
    
  
});

router.get('/:id', async function(req,res, next) {
  let connection;
  try {
    const userId = req.params.id;
    connection = await pool.getConnection();
    const [rows, fields] = await connection.query(`select * from funcionarios where funcionario_id = ${userId}`)
    res.json(rows)
  } catch (err) {
    res.status(500).json({error: 'internal server error'})
  } finally {
  if (connection) connection.release();
  }
  
})
module.exports = router;
