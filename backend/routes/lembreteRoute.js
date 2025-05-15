const express = require('express');
const router = express.Router();
const LembreteController = require('../controllers/LembreteController');

//Criar lembrete
router.post('/criar/:conexaoId', LembreteController.criarLembrete);

//Listar lembretes
router.get('/listar/:conexaoId', LembreteController.listarLembretes);

//Atualizar lembrete
router.put('/atualizar/:conexaoId', LembreteController.atualizarLembrete);

//Deletar lembrete
router.delete('/deletar/:conexaoId', LembreteController.deletarLembrete);

module.exports = router;