const CheckList = require('../models/CheckListModel');

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
        const { conexaoId } = req.params;
        const lista = req.body;

        if (!Array.isArray(lista) || lista.length === 0) {
            return res.status(400).json({ msg: 'Lista de itens obrigatória' });
        }
        try {
            const resultados = [];

            for (const item of lista) {
                const { id, descricao, marcado } = item;

                if (!descricao || typeof marcado !== 'boolean') {
                    return res.status(400).json({ msg: 'Cada item deve conter id, descricao e marcado' });
                }

                const atualizado = await CheckList.findOneAndUpdate(
                    { _id: id, conexao: conexaoId },
                    { descricao, marcado },
                    { new: true }
                );

                if (atualizado) {
                    resultados.push(atualizado);
                }
            }

            res.status(200).json({ msg: 'Itens atualizados com sucesso', atualizados: resultados });
        } catch (error) {
            console.error('Erro ao atualizar vários itens:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },
    //#endregion

    //#region Deletar um item de checklist
    async deletarCheckList(req, res) {
        const { id } = req.query;
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