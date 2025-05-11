const Lembrete = require('../models/LembreteModel');
const Usuario = require('../models/UsuarioModel');

const LembreteController = {
    // Criar um novo lembrete
    async criarLembrete(req, res) {
        const { descricao, data } = req.body;
        const usuarioId = req.usuarioId;

        if (!descricao) {
            return res.status(400).json({ msg: 'Descrição é obrigatória' });
        }

        try {
            const novoLembrete = new Lembrete({ descricao, data, usuario: usuarioId });
            await novoLembrete.save();
            res.status(201).json(novoLembrete);
        } catch (error) {
            console.error('Erro ao criar lembrete:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },

    // Listar lembretes do usuário autenticado
    async listarLembretes(req, res) {
        const usuarioId = req.usuarioId;

        try {
            const lembretes = await Lembrete.find({ usuario: usuarioId }).populate('usuario', 'nome usuario');
            res.status(200).json(lembretes);
        } catch (error) {
            console.error('Erro ao listar lembretes:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },
    
    // Atualizar um lembrete
    async atualizarLembrete(req, res) {
        const { id } = req.params;
        const { descricao, data } = req.body;
        const usuarioId = req.usuarioId;

        if (!descricao) {
            return res.status(400).json({ msg: 'Descrição é obrigatória' });
        }

        try {
            const lembrete = await Lembrete.findOneAndUpdate(
                { _id: id, usuario: usuarioId },
                { descricao, data },
                { new: true }
            );

            if (!lembrete) {
                return res.status(404).json({ msg: 'Lembrete não encontrado ou não autorizado' });
            }

            res.status(200).json(lembrete);
        } catch (error) {
            console.error('Erro ao atualizar lembrete:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },

    // Deletar um lembrete
    async deletarLembrete(req, res) {
        const { id } = req.params;
        const usuarioId = req.usuarioId;

        try {
            const lembrete = await Lembrete.findOneAndDelete({ _id: id, usuario: usuarioId });

            if (!lembrete) {
                return res.status(404).json({ msg: 'Lembrete não encontrado ou não autorizado' });
            }

            res.status(200).json({ msg: 'Lembrete deletado com sucesso' });
        } catch (error) {
            console.error('Erro ao deletar lembrete:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    }
};

module.exports = LembreteController;