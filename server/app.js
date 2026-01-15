var express = require('express');

var funcionariosRouter = require('./routes/funcionarios');

var app = express();

app.use('/funcionarios', funcionariosRouter);

module.exports = app;
