const Conexao = require('../models/ConexaoModel.js');
const Usuario = require('../models/UsuarioModel');
const CheckList = require('../models/CheckListModel');
const Lembrete = require('../models/LembreteModel');

const ConexaoController = {
  //#region Criar uma nova solicitação de conexão
  async solicitarConexao(req, res) {
    const { usuario1, usuario2 } = req.body;

    if (usuario1 === usuario2) {
      return res.status(400).json({ erro: 'Usuários não podem se conectar a si mesmos.' });
    }

    const conexaoExistente = await Conexao.findOne({
      $and: [
        { status: 'aceita' },
        {
          $or: [
            { usuario1 },
            { usuario2 }
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

      await Conexao.deleteMany({
        _id: { $ne: novaConexao._id },
        status: { $in: ['pendente', 'rejeitada'] },
        $or:  [
                {
                  usuario1: novaConexao.usuario1,
                  usuario2: novaConexao.usuario2
                },
                {
                  usuario1: novaConexao.usuario2,
                  usuario2: novaConexao.usuario1
                }
              ]
      });

      res.status(201).json(novaConexao);
    } catch (err) {
      console.error('Erro ao criar conexão:', err);
      if (err.code === 11000) {
        return res.status(409).json({ erro: 'Conexão já existe entre esses usuários.' });
      }
      res.status(500).json({ erro: 'Erro ao criar conexão.' });
    }
  },
  //#endregion

  //#region Aceitar uma conexão
  async aceitarConexao(req, res) {
    const { id } = req.params;

    try {
      const conexao = await Conexao.findById(id);
      if (!conexao) return res.status(404).json({ erro: 'Conexão não encontrada.' });

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
        Usuario.findByIdAndUpdate(conexao.usuario1, { conexao: conexao._id }),
        Usuario.findByIdAndUpdate(conexao.usuario2, { conexao: conexao._id })
      ]);

      await Conexao.deleteMany({
        _id: { $ne: id },
        status: { $in: ['pendente', 'rejeitada'] },
        $or:  [
                {
                  usuario1: conexao.usuario1,
                  usuario2: conexao.usuario2
                },
                {
                  usuario1: conexao.usuario2,
                  usuario2: conexao.usuario1
                }
              ]
      });

      res.json({ mensagem: 'Conexão aceita com sucesso.', conexao });
    } catch (err) {
      res.status(500).json({ erro: 'Erro ao aceitar conexão.' });
    }
  },
  //#endregion

  //#region Rejeitar uma conexão
  async rejeitarConexao(req, res) {
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
  },
  //#endregion

  //#region Buscar conexões pendentes para um usuário
  async getPendentes(req, res) {
    const { usuarioId } = req.params;

    try {
      const user = await Usuario.findOne({ _id : usuarioId});
      if (!user) {
        return res.status(404).json({ msg: 'Usuário não encontrado' });
      }

      const pendentes = await Conexao.find({
        status: 'pendente',
        usuario2: usuarioId
      }).populate('usuario1', 'nome usuario');

      if (pendentes.length === 0) {
        return res.status(404).json({ erro: 'Nenhuma conexão pendente encontrada.' });
      }

      res.json(pendentes);
    } catch (err) {
      res.status(500).json({ erro: 'Erro ao buscar conexões pendentes.' });
    }
  },
  //#endregion

  //#region Desfazer conexão
  async desfazerConexao(req, res) {
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

      await Promise.all([
        Lembrete.deleteMany({ conexao: conexaoId }),
        CheckList.deleteMany({ conexao: conexaoId }),
        Conexao.findByIdAndDelete(conexaoId)
      ]);

      res.status(200).json({ msg: 'Conexão desfeita com sucesso.' });
    } catch (err) {
      console.error('Erro ao desfazer conexão:', err);
      res.status(500).json({ erro: 'Erro ao desfazer conexão.' });
    }
  },
  //#endregion

  //#region Obter conexão por usuário
  async buscarConexaoPorUsuario(req, res) {
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
  }
  //#endregion
};
module.exports = ConexaoController;