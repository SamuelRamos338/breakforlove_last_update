const express = require('express');
const router = express.Router();
const UsuarioController = require('../controllers/UsuarioController');

//Cadastro Usuario
router.post('/cadastrar', UsuarioController.cadastrar);

//Login Usuario
router.post('/login', UsuarioController.login);

// Atualizar usuário
router.put('/usuarios/:id', UsuarioController.atualizar);

module.exports = router;