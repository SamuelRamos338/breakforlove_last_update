const mongoose = require('mongoose');

const conexaoSchema = new mongoose.Schema({
  usuario1: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }, // Solicitante
  nome1: { type: String, required: true }, //nome pessoa
  usuario2: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }, // Solicitado
  nome2: { type: String, required: true }, //nome pessoa
  status: {
    type: String,
    enum: ['pendente', 'aceita', 'rejeitada'],
    default: 'pendente'
  },
}, {
  timestamps: { createdAt: 'criadaEm', updatedAt: 'atualizadaEm' }
});

module.exports = mongoose.model('Conexao', conexaoSchema);
