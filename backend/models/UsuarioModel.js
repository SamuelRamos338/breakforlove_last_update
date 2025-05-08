const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  usuario: { type: String, required: true, unique: true },
  senha: { type: String, required: true },
  nome: { type: String, required: true },
}, { timestamps: true });

module.exports = mongoose.model('User', userSchema);

