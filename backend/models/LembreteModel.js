const mongoose = require('mongoose');

const lembretesSchema = new mongoose.Schema({
  descricao: { type: String, required: true },
  data: {type : Date, required: true}
}, { timestamps: true });

module.exports = mongoose.model('Lembretes', lembretesSchema);