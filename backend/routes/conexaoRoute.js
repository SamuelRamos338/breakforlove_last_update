const express = require('express');
const router = express.Router();
const ConexaoController = require('../controllers/ConexaoController.js');

// Criar uma nova solicitação de conexão
router.post('/criar', ConexaoController.solicitarConexao);

// Aceitar uma solicitação de conexão
router.put('/aceitar/:id', ConexaoController.aceitarConexao);

// Rejeitar uma solicitação de conexão
router.put('/rejeitar/:id', ConexaoController.rejeitarConexao);

// Obter conexões pendentes para um usuário
router.get('/pendentes/:usuarioId', ConexaoController.getPendentes);

// Obter a conexão (aceita, pendente ou rejeitada) de um usuário
router.get('/usuario/:usuarioId', ConexaoController.buscarConexaoPorUsuario);

// Desfazer (excluir) uma conexão existente
router.delete('/excluir/:conexaoId', ConexaoController.desfazerConexao);

module.exports = router;