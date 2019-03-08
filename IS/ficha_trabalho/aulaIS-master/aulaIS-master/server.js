const dotenv = require('dotenv');
const express = require('express');
const bodyParser = require('body-parser');
const authMiddleware = require('./middleware/auth');
const privateRoutes = require('./routes/private');
const publicRoutes = require('./routes/public');

dotenv.config();
const app = express();

app.use(bodyParser.json());

app.use('/api/protected', authMiddleware, privateRoutes);
app.use('/api', publicRoutes);

app.listen(8081);

