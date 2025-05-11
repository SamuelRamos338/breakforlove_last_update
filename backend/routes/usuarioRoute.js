const express = require('express');
const router = express.Router();
const UsuarioController = require('../controllers/UsuarioController');

// Rota de cadastro
router.post('/cadastrar', UsuarioController.cadastrar);

// Rota de login
router.post('/login', UsuarioController.login);

module.exports = router;