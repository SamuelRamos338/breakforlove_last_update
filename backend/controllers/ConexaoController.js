// controllers/conexao.controller.js
const Conexao = require('../models/ConexaoModel.js');
const Usuario = require('../models/UsuarioModel');
const mongoose = require('mongoose');

// Criar uma nova solicitação de conexão
exports.solicitarConexao = async (req, res) => {
    const { usuario1, usuario2 } = req.body;
  
    if (usuario1 === usuario2) {
      return res.status(400).json({ erro: 'Usuários não podem se conectar a si mesmos.' });
    }
  
    // Verifica se algum dos usuários já está em uma conexão aceita
    const conexaoExistente = await Conexao.findOne({
      $and: [
        { status: 'aceita' },
        {
          $or: [
            { usuario1 },
            { usuario2 },
          ]
        }
      ]
    });
  
    if (conexaoExistente) {
      return res.status(409).json({ erro: 'Um dos usuários já está em uma conexão ativa.' });
    }
  
    try {
      const [user1, user2] = await Promise.all([
        Usuario.findById(usuario1),
        Usuario.findById(usuario2)
      ]);
  
      if (!user1 || !user2) {
        return res.status(404).json({ erro: 'Um dos usuários não foi encontrado.' });
      }
  
      const novaConexao = new Conexao({
        usuario1,
        nome1: user1.nome,
        usuario2,
        nome2: user2.nome
      });
  
      await novaConexao.save();
      res.status(201).json(novaConexao);
    } catch (err) {
      console.error('Erro ao criar conexão:', err);
      if (err.code === 11000) {
        return res.status(409).json({ erro: 'Conexão já existe entre esses usuários.' });
      }
      res.status(500).json({ erro: 'Erro ao criar conexão.' });
    }
  };

// Aceitar uma conexão
exports.aceitarConexao = async (req, res) => {
  const { id } = req.params;

  try {
    const conexao = await Conexao.findById(id);
    if (!conexao) return res.status(404).json({ erro: 'Conexão não encontrada.' });

    // Verifica se algum dos dois já tem conexão aceita
    const conexaoAtiva = await Conexao.findOne({
      status: 'aceita',
      $or: [
        { usuario1: conexao.usuario1 },
        { usuario2: conexao.usuario1 },
        { usuario1: conexao.usuario2 },
        { usuario2: conexao.usuario2 }
      ]
    });

    if (conexaoAtiva) {
      return res.status(409).json({ erro: 'Um dos usuários já está em uma conexão ativa.' });
    }

    conexao.status = 'aceita';
    await conexao.save();

    await Promise.all([
        Usuario.findByIdAndUpdate(usuario1, { conexao: novaConexao._id }),
        Usuario.findByIdAndUpdate(usuario2, { conexao: novaConexao._id })
      ]);

    res.json({ mensagem: 'Conexão aceita com sucesso.', conexao });
  } catch (err) {
    res.status(500).json({ erro: 'Erro ao aceitar conexão.' });
  }
};

// Rejeitar uma conexão
exports.rejeitarConexao = async (req, res) => {
  const { id } = req.params;

  try {
    const conexao = await Conexao.findById(id);
    if (!conexao) return res.status(404).json({ erro: 'Conexão não encontrada.' });

    conexao.status = 'rejeitada';
    await conexao.save();

    res.json({ mensagem: 'Conexão rejeitada com sucesso.', conexao });
  } catch (err) {
    res.status(500).json({ erro: 'Erro ao rejeitar conexão.' });
  }
};

// Buscar conexões pendentes de um usuário
exports.getPendentes = async (req, res) => {
  const { usuarioId } = req.params;

  try {
    const pendentes = await Conexao.find({
      status: 'pendente',
      usuario2: usuarioId
    }).populate('usuario1');

    res.json(pendentes);
  } catch (err) {
    res.status(500).json({ erro: 'Erro ao buscar conexões pendentes.' });
  }
};

//Desfazer Conexão
exports.desfazerConexao = async (req, res) => {
    const { conexaoId } = req.params;
  
    try {
      const conexao = await Conexao.findById(conexaoId);
      if (!conexao) {
        return res.status(404).json({ erro: 'Conexão não encontrada.' });
      }
  
      const { usuario1, usuario2 } = conexao;
  
      await Promise.all([
        Usuario.findByIdAndUpdate(usuario1, { conexao: null }),
        Usuario.findByIdAndUpdate(usuario2, { conexao: null })
      ]);
  
      await Conexao.findByIdAndDelete(conexaoId);
  
      res.status(200).json({ msg: 'Conexão desfeita com sucesso.' });
    } catch (err) {
      console.error('Erro ao desfazer conexão:', err);
      res.status(500).json({ erro: 'Erro ao desfazer conexão.' });
    }
  };

  //Obter Conexão
  exports.buscarConexaoPorUsuario = async (req, res) => {
    const { usuarioId } = req.params;
  
    try {
      const conexao = await Conexao.findOne({
        $or: [
          { usuario1: usuarioId },
          { usuario2: usuarioId }
        ]
      })
      .populate('usuario1', 'nome usuario')
      .populate('usuario2', 'nome usuario');
  
      if (!conexao) {
        return res.status(404).json({ msg: 'Nenhuma conexão encontrada para este usuário.' });
      }
  
      res.status(200).json(conexao);
    } catch (err) {
      console.error('Erro ao buscar conexão:', err);
      res.status(500).json({ erro: 'Erro ao buscar conexão.' });
    }
  };