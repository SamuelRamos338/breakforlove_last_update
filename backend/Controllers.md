
# Usuário Controller

## - Cadastro de Usuário  
**Endpoint:** `POST /cadastrar`  
**Body:**  
```json
{
  "usuario": "string",
  "senha": "string",
  "nome": "string"
}
```  
**Retornos:**  
- `201` - Usuário cadastrado com sucesso  
- `400` - Campos obrigatórios ausentes ou usuário já existe  
- `500` - Erro interno no servidor  

---

## - Login de Usuário  
**Endpoint:** `POST /login`  
**Body:**  
```json
{
  "usuario": "string",
  "senha": "string"
}
```  
**Retornos:**  
- `200` - Login realizado com sucesso + dados do usuário  
- `400` - Usuário ou senha ausentes ou usuário não encontrado  
- `401` - Senha incorreta  
- `500` - Erro interno no servidor  

---

## - Atualizar Usuário  
**Endpoint:** `PUT /usuarios/:id`  
**Parâmetro:** `id`: id do usuário a ser atualizado  
**Body:**  
```json
{
  "usuario": "string (opcional)",
  "nome": "string (opcional)",
  "senha": "string (opcional)"
}
```  
**Retornos:**  
- `200` - Usuário atualizado com sucesso + dados atualizados  
- `400` - Usuário já está em uso (quando tenta alterar para um já existente)  
- `404` - Usuário não encontrado  
- `500` - Erro interno no servidor  
---
<br>

# CONEXAO CONTROLLER

## -  Criar nova conexão
**Endpoint:** `POST /api/conexao/criar`  
**Body:**
```json
{
  "usuario1": "id_do_solicitante",
  "usuario2": "id_do_solicitado"
}
```
**Retornos:**
- 201: Conexão criada com sucesso.
- 400: Usuários iguais ou campos ausentes.
- 404: Usuário não encontrado.
- 409: Conexão ativa já existe.
- 500: Erro no servidor.

---

## - Aceitar conexão
**Endpoint:** `PUT /api/conexao/aceitar/:id`  
**Parâmetro:** `id:` id da conexão a ser aceita  
**Retornos:**
- 200: Conexão aceita com sucesso.
- 404: Conexão não encontrada.
- 409: Um dos usuários já está em uma conexão ativa.
- 500: Erro no servidor.

---

## - Rejeitar conexão
**Endpoint:** `PUT /api/conexao/rejeitar/:id`  
**Parâmetro:** `id` da conexão a ser rejeitada  
**Retornos:**
- 200: Conexão rejeitada com sucesso.
- 404: Conexão não encontrada.
- 500: Erro no servidor.

---

## - Buscar conexões pendentes para um usuário
**Endpoint:** `GET /api/conexao/pendentes/:usuarioId`  
**Parâmetro:** `usuarioId:` id do usuário que deseja buscar a conexão pendente
**Retornos:**
- 200: Lista de conexões pendentes.
- 500: Erro ao buscar conexões.

---

## - Buscar conexão do usuário
**Endpoint:** `GET /api/conexao/usuario/:usuarioId`  
**Parâmetro:** `usuarioId:` id do usuário que deseja buscar a conexão  
**Retornos:**
- 200: Conexão encontrada.
- 404: Nenhuma conexão encontrada.
- 500: Erro no servidor.

---

## - Desfazer conexão
**Endpoint:** `DELETE /api/conexao/excluir/:conexaoId`  
**Parâmetro:** `conexaoId:` id da conexão que deseja desfazer
**Retornos:**
- 200: Conexão desfeita com sucesso.
- 404: Conexão não encontrada.
- 500: Erro ao desfazer conexão.

---
<br>

# CONTROLLER CHECKLIST

##  -Criar CheckList
**Rota:** `POST /criar/:conexaoId`
**Parâmetro:** `conexaoId:` id da conexão que deseja criar o item
**Body:**
```json
{
  "descricao": "string"
}
```
**Retornos:**
- `201`: Item de checklist criado com sucesso.
- `400`: Descrição é obrigatória.
- `500`: Erro interno no servidor.

---

## - Listar CheckList
**Rota:** `GET /listar/:conexaoId`  
**Parâmetro:** `conexaoId:` id da conexão que deseja listar os itens
**Retornos:**
- `200`: Lista de itens de checklist.
- `500`: Erro interno no servidor.

---

## - Atualizar CheckList
**Rota:** `PUT /atualizar/:conexaoId`
**Parâmetro:** `conexaoId:` id da conexão que deseja atuializar os itens
**Body:**
```json
[
  {
    "id": "string",
    "descricao": "string",
    "marcado": true
  }
]
```
**Retornos:**
- `200`: Itens atualizados com sucesso.
- `400`: Lista inválida ou item incompleto.
- `500`: Erro interno no servidor.

---

## - Deletar CheckList
**Rota:** `DELETE /deletar/:conexaoId?id=ITEM_ID`  
**Parâmetros:** 
-`conexaoId:` id da conexão ligada ao item
-`ITEM_ID:` id do item que deseja deletar
**Retornos:**
- `200`: Item deletado com sucesso.
- `404`: Item não encontrado.
- `500`: Erro interno no servidor.

---
<br>

# CONTROLLER LEMBRETE

## - Criar Lembrete  
**Rota:** `POST /criar/:conexaoId`  
**Parâmetro:** `conexaoId:` id da conexão que deseja criar o lembrete  
**Body:**
```json
{
  "descricao": "string",
  "data": "2025-05-18T14:30:00.000Z"
}
```
**Retornos:**
- `201`: Lembrete criado com sucesso.
- `400`: Descrição é obrigatória.
- `500`: Erro interno no servidor.

---

## - Listar Lembretes  
**Rota:** `GET /listar/:conexaoId`  
**Parâmetros:**  
-`conexaoId:` id da conexão que deseja listar os lembretes  
**Retornos:**
- `200`: Lista de lembretes.
- `500`: Erro interno no servidor.

---

## - Atualizar Lembrete  
**Rota:** `PUT /atualizar/:conexaoId?id=LEMBRETE_ID`  
**Parâmetros:**  
-`conexaoId:` id da conexão ligada ao lembrete  
-`LEMBRETE_ID:` id do lembrete que deseja atualizar (via query string)  
**Body:**
```json
{
  "descricao": "string",
  "data": "2025-05-18T15:00:00.000Z"
}
```
**Retornos:**
- `200`: Lembrete atualizado com sucesso.
- `400`: Descrição é obrigatória.
- `404`: Lembrete não encontrado ou não autorizado.
- `500`: Erro interno no servidor.

---

## - Deletar Lembrete  
**Rota:** `DELETE /deletar/:conexaoId?id=LEMBRETE_ID`  
**Parâmetros:**  
-`conexaoId:` id da conexão ligada ao lembrete  
-`LEMBRETE_ID:` id do lembrete que deseja deletar (via query string)  
**Retornos:**
- `200`: Lembrete deletado com sucesso.
- `404`: Lembrete não encontrado ou não autorizado.
- `500`: Erro interno no servidor.

---
<br>

# CONTROLLER DESIGN

## - Obter Design
**Rota:** `GET /design/:usuarioId`  
**Parâmetro:** `usuarioId:` id do usuário que deseja obter o design  
**Retornos:**
- `200`: Retorna o design do usuário.
- `404`: Design não encontrado.
- `500`: Erro interno no servidor.

---

## - Atualizar Tema
**Rota:** `PUT /design/tema/:usuarioId`  
**Parâmetro:** `usuarioId:` id do usuário que deseja atualizar o tema  
**Body:**
```json
{
  "tema": 1
}
```
**Retornos:**
- `200`: Tema atualizado com sucesso.
- `400`: Tema é obrigatório.
- `404`: Design não encontrado.
- `500`: Erro interno no servidor.

---

## - Atualizar Foto de Perfil
**Rota:** `PUT /design/foto-perfil/:usuarioId`  
**Parâmetro:** `usuarioId:` id do usuário que deseja atualizar a foto de perfil  
**Body:**
```json
{
  "fotoPerfil": 2
}
```
**Retornos:**
- `200`: Foto de perfil atualizada com sucesso.
- `400`: Foto de perfil é obrigatória.
- `404`: Design não encontrado.
- `500`: Erro interno no servidor.