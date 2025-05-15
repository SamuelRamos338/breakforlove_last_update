const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  usuario: { type: String, required: true, unique: true },//usario de login
  senha: { type: String, required: true },//senha de login
  nome: { type: String, required: true }, //nome pessoa
  conexao: { type: mongoose.Schema.Types.ObjectId, ref: 'Conexao', default: null }//conexão com outro usuario
}, { timestamps: true });

module.exports = mongoose.model('User', userSchema);

