const mongoose = require('mongoose');

const designSchema = new mongoose.Schema({
  tema: { type: Int, required: true, default: 0 },
  fotoPerfil: {type : Int, required: true, default: 0}, 
  usuario: { type: mongoose.Schema.Types.ObjectId, ref: 'Usuario', required: true }
}, { timestamps: true });

module.exports = mongoose.model('Design', designSchema);