var mongoose = require('mongoose')
var Schema = mongoose.Schema

var DocSchema = new Schema(
    {
        tipo:{type:String },
        data:{type:Date },
        nif:{type:String },
        num_local:{type:Number },
        nub:{type:Number },
        valor_total:{type:Decimal128 },
        num_doc:{type:String },
        num_ordem:{type:String },
        num_devolucao:{type:Number },
        num_pedido:{type:Number },
        linhas:{type:Array },
        pdf:{type:Array },
        password:{type:String}
    }

)

module.exports = mongoose.model('Document', DocSchema, 'document')