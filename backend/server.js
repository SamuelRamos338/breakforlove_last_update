const mongoose = require('mongoose');
const express = require('express');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

mongoose.connect('mongodb+srv://usermavit:breakdb@breakforlove.wgmfu4b.mongodb.net/?retryWrites=true&w=majority&appName=breakforlove')
  .then(() => console.log('mongoDB Atlas conectado com sucesso'))
  .catch(err => console.error('Erro ao conectar ao mongoDB Atlas', err));

const usuarioRoutes = require('./routes/usuarioRoute');
app.use('/api/usuario', usuarioRoutes);
 
const lembreteRoutes = require('./routes/lembreteRoute');
app.use('/api/lembrete', lembreteRoutes);

const checkListRoutes = require('./routes/checkListRoute');
app.use('/api/checkList', checkListRoutes);

const designRoutes = require('./routes/designRoute');
app.use('/api/design', designRoutes);

const conexaoRoutes = require('./routes/conexaoRoute');
app.use('/api/conexao', conexaoRoutes);

app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});

app.get('/', (req, res) => {
    res.send('API BreakForLove está no ar!');
});