const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  usuario: { type: String, required: true, unique: true },
  senha: { type: String, required: true },
  nome: { type: String, required: true },
  conexao: { type: mongoose.Schema.Types.ObjectId, ref: 'Conexao' }
}, { timestamps: true });

module.exports = mongoose.model('User', userSchema);