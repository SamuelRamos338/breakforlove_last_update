const express = require('express');
const router = express.Router();
const DesignController = require('../controllers/DesignController');

//Obter Design
router.get('/design/:usuarioId', DesignController.obterDesign);

//Atualizar Tema
router.put('/design/tema/:usuarioId', DesignController.atualizarTema);

//Atualizar Foto de Perfil
router.put('/design/foto-perfil/:usuarioId', DesignController.atualizarFotoPerfil);

module.exports = router;
