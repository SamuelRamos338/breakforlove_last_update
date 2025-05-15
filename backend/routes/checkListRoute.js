const express = require('express');
const router = express.Router();
const CheckListController = require('../controllers/CheckListController');

// Criar CheckList
router.post('/criar/:conexaoId', CheckListController.criarCheckList);

// Listar CheckList
router.get('/listar/:conexaoId', CheckListController.listarCheckList);

// Atualizar CheckList
router.put('/atualizar/:conexaoId/:id', CheckListController.atualizarCheckList);

// Deletar CheckList
router.delete('/deletar/:conexaoId/:id', CheckListController.deletarCheckList);

module.exports = router;