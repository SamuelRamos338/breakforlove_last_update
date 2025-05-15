const mongoose = require('mongoose');

const designSchema = new mongoose.Schema({
  tema: { type: Number, required: true, default: 0 },
  fotoPerfil: {type : Number, required: true, default: 0}, 
  usuario: { type: mongoose.Schema.Types.ObjectId, ref: 'Usuario', required: true }
}, { timestamps: true });

module.exports = mongoose.model('Design', designSchema);