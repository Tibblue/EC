var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

// var passport = require('passport')
// var mongoose = require('mongoose')
// var uuid = require('uuid/v4')
// var session = require('express-session')
// var FileStore = require('session-file-store')(session)

// require('./autentic/aut')


var app = express();

// // Base de dados - exemplo de mongo (foi o que usei em PRI)
// mongoose.connect('mongodb://127.0.0.1:27017/aula13', {useNewUrlParser: true})
//   .then(()=>{console.log('Mongo ready: ' + mongoose.connection.readyState)})
//   .catch(erro => console.log('Erro de conexão: ' + erro))

// view engine setup
// aka pug (don't touch my rookies XD)
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');


// MIDDLEWARE AREA - HYPE
app.use(logger('dev')); //isto dá output bonitos dos pedidos no terminal
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public'))); //é aqui que a pasta public fica pública.


// ROUTERS
// app.use('/api/users', require('./routes/api/users'))
app.use('/', require('./routes/index'));
app.use('/users', require('./routes/users'));


/////  IGNORE THIS  /////
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
