const mongoose = require('mongoose');

const lembreteSchema = new mongoose.Schema({
  descricao: { type: String, required: true },
  data: {type : Date, required: true}, 
  usuario: { type: mongoose.Schema.Types.ObjectId, ref: 'Usuario', required: true }
}, { timestamps: true });

module.exports = mongoose.model('Lembrete', lembreteSchema);