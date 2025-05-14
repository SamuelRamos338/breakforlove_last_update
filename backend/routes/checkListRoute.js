const express = require('express');
const router = express.Router();
const CheckListController = require('../controllers/CheckListController');

//Criar CheckList
router.post('/criar', CheckListController.criarCheckList);

//Listar CheckList
router.get('/listar', CheckListController.listarCheckList);

//Atualizar CheckList
router.put('/atualizar/:id', CheckListController.atualizarCheckList);

//Deletar CheckList
router.delete('/deletar/:id', CheckListController.deletarCheckList);

module.exports = router;