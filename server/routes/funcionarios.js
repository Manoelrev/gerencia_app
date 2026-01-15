var express = require('express');
var router = express.Router();
var {getFuncionarios, getFuncionariosbyID} = require( '../database/config');

router.get('/', async function (req, res, next) {
  try {
    res.json(await getFuncionarios());
  } catch (error) {
    res.status(500).json(error);
  }
});

router.get('/:id', async function(req,res, next) {
  try {
    const userId = req.params.id;
    res.json(await getFuncionariosbyID(userId));
  } catch (error) {
    res.status(500).json(error);
  }
})
module.exports = router;
