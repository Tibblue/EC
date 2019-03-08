const express = require('express');
const {benefByNif, benefByADSE} = require('../data/beneficiarios');

const router = express.Router();


router.get('/beneficiarios', (req, res) =>{
  const {nif} = req.query;

  if(!nif)
    return res.status(200).json({error:'Campos em Falta'});  
  return res.status(200).json({nub:(benefByNif[nif] && benefByNif[nif].adse) || 0});
});


module.exports = router;