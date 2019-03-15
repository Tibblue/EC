const dotenv = require('dotenv');
const express = require('express');
const bodyParser = require('body-parser');
// Routing files
const authMiddleware = require('./middleware/auth');
const privateRoutes = require('./routes/private');
const publicRoutes = require('./routes/public');


// Carrega as variaveis para o 'process.env'
dotenv.config();
// Cria o servidor
const app = express();

// Mongo connect
var mongoose = require('mongoose')
mongoose
    .connect('mongodb://127.0.0.1:27017/adse', {useNewUrlParser: true})
    .then(() => console.log('Mongo status: ' + mongoose.connection.readyState))
    .catch(() => console.log('Mongo: erro na conexao!!!'))


///// Middleware
app.use(bodyParser.json());


///// Routes
app.use('/api/protected', authMiddleware, privateRoutes);
app.use('/api', publicRoutes);
app.use('/testing',require('./routes/testing'))

///// Abre a PORT para escutar pedidos
console.log('Running on PORT '+process.env.PORT)
app.listen(process.env.PORT);
