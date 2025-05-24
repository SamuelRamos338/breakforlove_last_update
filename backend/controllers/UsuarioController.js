const Usuario = require('../models/UsuarioModel');
const Design = require('../models/DesignModel');
const bcrypt = require('bcryptjs');

const UsuarioController = {
  // #region Cadastro de novo usuário
  async cadastrar(req, res) {
    const { usuario, senha, nome } = req.body;

    if (!usuario || !senha || !nome) {
      return res.status(400).json({ msg: 'Todos os campos são obrigatórios' });
    }

    try {
      const existe = await Usuario.findOne({ usuario });
      if (existe) {
        return res.status(400).json({ msg: 'Usuário já existe' });
      }

      const senhaHash = await bcrypt.hash(senha, 10);
      const novoUsuario = new Usuario({ usuario, senha: senhaHash, nome });
      await novoUsuario.save();

      //#region Adicionar Design
      const designPadrao = new Design({
        usuario: novoUsuario._id,
        tema: 0,
        fotoPerfil: 0
      });
      
      await designPadrao.save();
      //#endregion

      res.status(201).json({ msg: 'Usuário cadastrado com sucesso' });
    } catch (error) {
      console.error('Erro no cadastro:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  },
  //#endregion

  //#region Login de usuário
  async login(req, res) {
    const { usuario, senha } = req.body;

    if (!usuario || !senha) {
      return res.status(400).json({ msg: 'Usuário e senha são obrigatórios' });
    }

    try {
      const user = await Usuario.findOne({ usuario });
      if (!user) {
        return res.status(400).json({ msg: 'Usuário não encontrado' });
      }

      const senhaValida = await bcrypt.compare(senha, user.senha);
      if (!senhaValida) {
        return res.status(401).json({ msg: 'Senha incorreta' });
      }

      res.status(200).json({
        msg: 'Login realizado com sucesso',
        usuario: { id: user._id, nome: user.nome, usuario: user.usuario, conexao: user.conexao }
      });
    } catch (error) {
      console.error('Erro no login:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  },
  //#endregion

  //#region Alterar dados do usuário
  async atualizar(req, res) {
    const { id } = req.params; // id do usuário a ser alterado
    const { usuario, nome, senha } = req.body;

    try {
      const user = await Usuario.findById(id);
      if (!user) {
        return res.status(404).json({ msg: 'Usuário não encontrado' });
      }

      if (usuario && usuario !== user.usuario) {
        const usuarioExistente = await Usuario.findOne({ usuario });
        if (usuarioExistente) {
          return res.status(400).json({ msg: 'Usuário já está em uso' });
        }
        user.usuario = usuario;
      }

      if (nome) user.nome = nome;

      if (senha) {
        const senhaHash = await bcrypt.hash(senha, 10);
        user.senha = senhaHash;
      }

      await user.save();
      res.status(200).json({ msg: 'Usuário atualizado com sucesso', usuario: { id: user._id, usuario: user.usuario, nome: user.nome } });
    } catch (error) {
      console.error('Erro ao atualizar usuário:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  }
  //#endregion
};

module.exports = UsuarioController;