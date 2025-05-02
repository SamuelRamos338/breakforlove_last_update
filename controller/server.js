const mongoose = require('mongoose');
const express = require('express');
const cors = require('cors');


const app = express();
const port = 3000;
app.use(cors());
app.use(express.json());

mongoose.connect('mongodb+srv://breakforlove:breakforlove123@breakforlove.0paxopn.mongodb.net/?retryWrites=true&w=majority&appName=BreakForLove')
.then(() => console.log('mongoDB Atlas conectado com sucesso'))
.catch(err => console.error('Erro ao conectar ao mongoDB Atlas', err));
    
