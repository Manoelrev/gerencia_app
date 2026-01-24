const express = require('express');
const cors = require('cors');
const funcionariosRouter = require('./routes/funcionarios');

const app = express();

app.use(cors());
app.use('/funcionarios', funcionariosRouter);

module.exports = app;
