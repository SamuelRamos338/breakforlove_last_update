const mongoose = require('mongoose');

const checkListSchema = new mongoose.Schema({
  descricao: { type: String, required: true },
  marcado : {type: Boolean, required: true},
  usuario: {type: mongoose.Schema.Types.ObjectId, ref: 'Usuario', required: true
  }
}, { timestamps: true });

module.exports = mongoose.model('CheckList', checkListSchema);