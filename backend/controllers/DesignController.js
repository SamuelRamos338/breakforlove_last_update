const Design = require('../models/DesignModel');

const DesignController = {
    //#region Obter o design do usuário
    async obterDesign(req, res) {
        const { usuarioId } = req.params;

        try {
            const design = await Design.findOne({ usuario: usuarioId }).populate('usuario', 'nome usuario');
            if (!design) {
                return res.status(404).json({ msg: 'Design não encontrado' });
            }
            res.status(200).json(design);
        } catch (error) {
            console.error('Erro ao obter design:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },
    //#endregion

    //#region Atualizar o tema do design
    async atualizarTema(req, res) {
        const { tema } = req.body;
        const { usuarioId } = req.params;

        if (tema === undefined) {
            return res.status(400).json({ msg: 'Tema é obrigatório' });
        }

        try {
            const design = await Design.findOneAndUpdate(
                { usuario: usuarioId },
                { tema },
                { new: true }
            );

            if (!design) {
                return res.status(404).json({ msg: 'Design não encontrado' });
            }

            res.status(200).json(design);
        } catch (error) {
            console.error('Erro ao atualizar tema:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    },
    //#endregion

    //#region Atualizar a foto de perfil do design
    async atualizarFotoPerfil(req, res) {
        const { fotoPerfil } = req.body;
        const { usuarioId } = req.params;

        if (fotoPerfil === undefined) {
            return res.status(400).json({ msg: 'Foto de perfil é obrigatória' });
        }

        try {
            const design = await Design.findOneAndUpdate(
                { usuario: usuarioId },
                { fotoPerfil },
                { new: true }
            );

            if (!design) {
                return res.status(404).json({ msg: 'Design não encontrado' });
            }

            res.status(200).json(design);
        } catch (error) {
            console.error('Erro ao atualizar foto de perfil:', error);
            res.status(500).json({ msg: 'Erro interno no servidor' });
        }
    }
    //#endregion
};
module.exports = DesignController;