var express = require('express');
var router = express.Router();

router.get('/ping', (req,res)=>{
    return res.send('pong')
})

module.exports = router