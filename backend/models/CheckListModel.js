const mongoose = require('mongoose');

const checkListSchema = new mongoose.Schema({
  descricao: { type: String, required: true },
  marcado: {type: Boolean, required: true, default: false},
  conexao: {type: mongoose.Schema.Types.ObjectId, ref: 'Conexao', required: true
  }
}, { timestamps: true });

module.exports = mongoose.model('CheckList', checkListSchema);