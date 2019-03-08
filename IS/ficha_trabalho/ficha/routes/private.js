const express = require('express');
const {benefByNif, benefByADSE} = require('../data/beneficiarios');

const router = express.Router();


router.get('/beneficiarios', (req, res) =>{
  const {nif} = req.query;

  if(!nif)
    return res.status(200).json({error:'Campos em Falta'});  
  return res.status(200).json({nub:(benefByNif[nif] && benefByNif[nif].adse) || 0});
});


router.get('/ativo', (req,res) => {
  const {nif,data} = req.query;

  if(!nif || !data)
    return res.status(200).json({error:'Campos em Falta'}); 
  
  var nub = benefByNif[nif];

  if (!nub) return res.status(404).send("");

  var data2 = nub.ativo.data;

  if(data == data2 && nub.ativo.direito == true)
    return res.status(200).send("OK");
  else
    return res.status(200).send("Espirra");
});

module.exports = router;