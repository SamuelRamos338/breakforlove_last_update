const express = require('express');
const router = express.Router();
const DesignController = require('../controllers/DesignController');

//Obter Design
router.get('/design', DesignController.obterDesign);

//Atualizar Tema
router.put('/design/tema', DesignController.atualizarTema);

//Atualizar Foto de Perfil
router.put('/design/foto-perfil', DesignController.atualizarFotoPerfil);

module.exports = router;
