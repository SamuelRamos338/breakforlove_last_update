const CheckList = require('../models/CheckListModel');
const Usuario = require('../models/UsuarioModel');

const CheckListController = {
    //#region Criar um novo item de checklist
    async criarCheckList(req, res) {
        const { descricao } = req.body;
        const { conexaoId } = req.params;

        if (!descricao) {
            return res.status(400).json({ msg: 'Descrição é obrigatória' });
        }

        try {
            const novoCheckList = new CheckList({ descricao, marcado : false, conexao: conexaoId });
            await novoCheckList.save();
            res.status(201).json(novoCheckList);
        } catch (error) {
            console.error('Erro ao criar checklist:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },
    //#endregion

    //#region Listar itens de checklist
    async listarCheckList(req, res) {
        const { conexaoId } = req.params;

        try {
            const checkList = await CheckList.find({ conexao: conexaoId });
            res.status(200).json(checkList);
        } catch (error) {
            console.error('Erro ao listar checklist:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },
    //#endregion

    //#region Atualizar um item de checklist
    async atualizarCheckList(req, res) {
        const { id } = req.params;
        const { descricao, marcado } = req.body;
        const { conexaoId } = req.params;

        if (!descricao) {
            return res.status(400).json({ msg: 'Descrição é obrigatória' });
        }

        try {
            const checkList = await CheckList.findOneAndUpdate(
                { _id: id, conexao: conexaoId },
                { descricao, marcado },
                { new: true }
            );

            if (!checkList) {
                return res.status(404).json({ msg: 'Item de checklist não encontrado' });
            }

            res.status(200).json(checkList);
        } catch (error) {
            console.error('Erro ao atualizar checklist:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },
    //#endregion

    //#region Deletar um item de checklist
    async deletarCheckList(req, res) {
        const { id } = req.params;
        const { conexaoId } = req.params;

        try {
            const checkList = await CheckList.findOneAndDelete({ _id: id, conexao: conexaoId });

            if (!checkList) {
                return res.status(404).json({ msg: 'Item de checklist não encontrado' });
            }

            res.status(200).json({ msg: 'Item de checklist deletado com sucesso' });
        } catch (error) {
            console.error('Erro ao deletar checklist:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    }
    //#endregion
};

module.exports = CheckListController;