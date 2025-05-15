const mongoose = require('mongoose');
const CheckList = require('../models/CheckListModel');

const CheckListController = {
  async criarCheckList(req, res) {
    const { descricao } = req.body;
    const { conexaoId } = req.params;

    if (!descricao) {
      return res.status(400).json({ msg: 'Descrição é obrigatória' });
    }

    if (!mongoose.Types.ObjectId.isValid(conexaoId)) {
      return res.status(400).json({ msg: 'ID de conexão inválido' });
    }

    try {
      const novoCheckList = new CheckList({
        descricao,
        marcado: false,
        conexao: new mongoose.Types.ObjectId(conexaoId), // Correção aplicada
      });
      await novoCheckList.save();
      res.status(201).json(novoCheckList);
    } catch (error) {
      console.error('Erro ao criar checklist:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  },

  async listarCheckList(req, res) {
    const { conexaoId } = req.params;

    if (!mongoose.Types.ObjectId.isValid(conexaoId)) {
      return res.status(400).json({ msg: 'ID de conexão inválido' });
    }

    try {
      const checklists = await CheckList.find({ conexao: new mongoose.Types.ObjectId(conexaoId) });
      res.status(200).json(checklists);
    } catch (error) {
      console.error('Erro ao listar checklist:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  },

  async atualizarCheckList(req, res) {
    const { conexaoId, id } = req.params;
    const { descricao, marcado } = req.body;

    if (!mongoose.Types.ObjectId.isValid(conexaoId) || !mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ msg: 'ID inválido' });
    }

    try {
      const checklistAtualizado = await CheckList.findOneAndUpdate(
        { _id: id, conexao: new mongoose.Types.ObjectId(conexaoId) },
        { descricao, marcado },
        { new: true }
      );

      if (!checklistAtualizado) {
        return res.status(404).json({ msg: 'Checklist não encontrado' });
      }

      res.status(200).json(checklistAtualizado);
    } catch (error) {
      console.error('Erro ao atualizar checklist:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  },

  async deletarCheckList(req, res) {
    const { conexaoId, id } = req.params;

    if (!mongoose.Types.ObjectId.isValid(conexaoId) || !mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ msg: 'ID inválido' });
    }

    try {
      const checklistDeletado = await CheckList.findOneAndDelete({
        _id: id,
        conexao: new mongoose.Types.ObjectId(conexaoId),
      });

      if (!checklistDeletado) {
        return res.status(404).json({ msg: 'Checklist não encontrado' });
      }

      res.status(200).json({ msg: 'Checklist deletado com sucesso' });
    } catch (error) {
      console.error('Erro ao deletar checklist:', error);
      res.status(500).json({ msg: 'Erro interno no servidor' });
    }
  },
};

module.exports = CheckListController;