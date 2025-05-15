const express = require('express');
const router = express.Router();
const conexaoController = require('../controllers/ConexaoController.js');

// Criar uma nova solicitação de conexão
router.post('/conexoes', conexaoController.solicitarConexao);

// Aceitar uma solicitação de conexão
router.put('/conexoes/aceitar/:id', conexaoController.aceitarConexao);

// Rejeitar uma solicitação de conexão
router.put('/conexoes/rejeitar/:id', conexaoController.rejeitarConexao);

// Obter conexões pendentes para um usuário
router.get('/conexoes/pendentes/:usuarioId', conexaoController.getPendentes);

// Desfazer (excluir) uma conexão existente
router.delete('/conexoes/:conexaoId', conexaoController.desfazerConexao);

// Obter a conexão (aceita, pendente ou rejeitada) de um usuário
router.get('/conexoes/usuario/:usuarioId', conexaoController.buscarConexaoPorUsuario);

module.exports = router;