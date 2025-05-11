const Usuario = require('../models/UsuarioModel');
const bcrypt = require('bcryptjs');

const UsuarioController = {
  // Cadastro de novo usuário
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

      res.status(201).json({ msg: 'Usuário cadastrado com sucesso' });
    } catch (error) {
      console.error('Erro no cadastro:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  },

  // Login de usuário
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
        usuario: { id: user._id, nome: user.nome, usuario: user.usuario }
      });
    } catch (error) {
      console.error('Erro no login:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  }
};

module.exports = UsuarioController;