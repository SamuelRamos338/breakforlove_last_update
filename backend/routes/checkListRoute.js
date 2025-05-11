const express = require('express');
const router = express.Router();
const CheckListController = require('../controllers/CheckListController');

// Criar checkList
router.post('/criar', CheckListController.criarCheckList);

// Listar checkList
router.get('/listar', CheckListController.listarCheckList);

// Atualizar checkList
router.put('/atualizar/:id', CheckListController.atualizarCheckList);

// Deletar checkList
router.delete('/deletar/:id', CheckListController.deletarCheckList);

module.exports = router;