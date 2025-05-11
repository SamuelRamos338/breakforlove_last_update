const express = require('express');
const router = express.Router();
const LembreteController = require('../controllers/LembreteController');

//Criar lembrete
router.post('/criar', LembreteController.criarLembrete);

//Listar lembretes
router.get('/listar', LembreteController.listarLembretes);

//Atualizar lembrete
router.put('/atualizar/:id', LembreteController.atualizarLembrete);

//Deletar lembrete
router.delete('/deletar/:id', LembreteController.deletarLembrete);

module.exports = router;