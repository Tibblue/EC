
const jwt = require('jsonwebtoken');
const {prestadoresByID, prestadoresByNif} = require('../data/prestadores');

module.exports = function (req, res, next) {
  const header = req.headers.authorization;
  let token;
  
  if(header) 
    token = header.split(' ')[1];

  if(token) {
    jwt.verify(token, process.env.secret_key, (err, decoded) => {
      if(err) return res.status(200).json({error:'Token inválido'});
      const {id, numLocal} = decoded;
      const prestador = prestadoresByID[id] && prestadoresByNif[prestadoresByID[id]];
      if(!prestador || (numLocal !== 0 && !prestador.locaisByID[numLocal]))
        return res.status(200).json({error:'Token inválido'});
      next();
    });
  }
  else res.status(200).json({ error: 'Token inválido' });
};
