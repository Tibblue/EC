const express = require('express');
const jwt = require('jsonwebtoken');
const {prestadoresByNif} = require('../data/prestadores');

const router = express.Router();

router.post('/getToken', (req, res) => {
  const { numLocal, nif, password} = req.body;

  console.log(req.body);

  if(!nif || !password || !numLocal)
    return res.status(200).json({error:'Campos em falta'});

  const prestador = prestadoresByNif[nif];
  const authVerification = prestador && (+numLocal === 0 
    ? password === prestador.password 
    : (prestador.locaisByID[numLocal] && prestador.locaisByID[numLocal].password === password));
  
  if(!authVerification)
    return res.status(200).json({error:'Autenticação Falhada'});
  
  const token = jwt.sign({id:prestador.id, numLocal:+numLocal, }, process.env.secret_key, {expiresIn:'1h'});
  
  return res.status(200).json({token});
});


module.exports = router;