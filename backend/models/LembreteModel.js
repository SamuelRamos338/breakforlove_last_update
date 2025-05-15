const mongoose = require('mongoose');

const lembreteSchema = new mongoose.Schema({
  descricao: { type: String, required: true },
  data: {type : Date, required: true}, 
  conexao: { type: mongoose.Schema.Types.ObjectId, ref: 'Conexao', required: true }
}, { timestamps: true });

module.exports = mongoose.model('Lembrete', lembreteSchema);