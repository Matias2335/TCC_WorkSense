# WorkSense — Integração Telegram, n8n, PostgreSQL, Trello e Ollama

Este repositório reúne a documentação técnica e os artefatos iniciais do **WorkSense**, uma ferramenta experimental desenvolvida como parte de um Trabalho de Conclusão de Curso em Ciência da Computação.

O WorkSense integra **Telegram**, **n8n**, **PostgreSQL**, **Trello** e **Ollama com o modelo qwen2.5:3b**, com o objetivo de simular interações de perfis profissionais, registrar mensagens, comandos e ações operacionais, e gerar uma base de dados para posterior análise em Python.

A solução está sendo desenvolvida em ambiente controlado, com dados simulados e interações produzidas pelos autores. O sistema não possui finalidade diagnóstica, clínica ou punitiva.

---

## 1. Objetivo do Repositório

Este repositório tem como objetivo documentar e versionar a implementação técnica inicial do WorkSense, incluindo:

* workflow do n8n;
* estrutura do banco PostgreSQL;
* exportações JSON do banco;
* logs de interações gerados pelo bot;
* comandos disponíveis no Telegram;
* instruções de exportação dos dados;
* documentação do ambiente na VPS;
* espaço reservado para os futuros scripts de análise em Python;
* espaço reservado para testes automatizados.

A etapa de análise dos dados ainda será adicionada posteriormente por outro integrante do grupo, incluindo scripts para processamento de mensagens, processamento de logs do Trello, cálculo dos scores e geração de gráficos.

---

## 2. Status Atual do Projeto

### Implementado até o momento

* Bot no Telegram funcionando.
* Workflow no n8n para orquestração do fluxo.
* Integração com PostgreSQL.
* Integração com Trello.
* Integração com Ollama.
* Uso do modelo `qwen2.5:3b`.
* Cadastro e vínculo entre usuário do Telegram e membro do Trello.
* Consulta de tarefas atribuídas pelo gestor.
* Criação de cards na lista `A FAZER`.
* Movimentação de cards entre `A FAZER`, `EM ANDAMENTO` e `CONCLUÍDO`.
* Listagem de cards por status.
* Registro de interações na tabela `bot_interactions`.
* Exportação do schema SQL do banco.
* Exportação dos dados em JSON.

### Em desenvolvimento

* Scripts de análise em Python.
* Processamento de mensagens para extração de indicadores comunicacionais.
* Processamento dos logs do Trello para extração de indicadores profissionais.
* Cálculo dos scores comunicacional e profissional.
* Testes automatizados.
* Geração de gráficos e visualizações finais.
* Anonimização automática dos dados exportados.

---

## 3. Ambiente de Execução

Os principais serviços do projeto estão hospedados em uma **VPS da Hostinger**.

Na VPS estão configurados:

* PostgreSQL;
* n8n;
* Ollama;
* modelo `qwen2.5:3b`;
* integrações com Telegram e Trello.

O PostgreSQL é utilizado como banco operacional do workflow. O n8n recebe as mensagens do Telegram, consulta o banco, identifica a intenção do usuário e direciona o fluxo para Trello ou Ollama.

---

## 4. Tecnologias Utilizadas

| Tecnologia   | Função no Projeto                                    |
| ------------ | ---------------------------------------------------- |
| Telegram Bot | Interface de interação com os usuários simulados     |
| n8n          | Orquestração do workflow                             |
| PostgreSQL   | Banco de dados operacional                           |
| Trello API   | Manipulação de cards e listas Kanban                 |
| Ollama       | Execução local do modelo de IA                       |
| qwen2.5:3b   | Modelo de linguagem usado pelo agente conversacional |
| Docker       | Execução dos serviços na VPS                         |
| JSON         | Formato de exportação dos dados                      |
| Python       | Análise futura dos dados exportados                  |

---

## 5. Estrutura Atual Recomendada do Repositório

A estrutura abaixo representa o estado atual do projeto, considerando os arquivos já disponíveis e deixando espaço para a etapa de análise que será adicionada depois.

```text
worksense/
│
├── README.md
│
├── database/
│   ├── tcc_ai_schema.sql
│   ├── tcc_ai_database_export.json
│   └── bot_interactions_utf8.json
│
├── n8n/
│   └── TCC_Telegram_IA_Trello.json
│
├── docs/
│   └── comandos_bot.txt
│
├── analysis/
│   └── README.md
│
├── tests/
│   └── README.md
│
├── examples/
│   └── README.md
│
├── .gitignore
└── .env.example
```

---

## 6. Descrição dos Arquivos Atuais

### `database/tcc_ai_schema.sql`

Arquivo com a estrutura do banco PostgreSQL. Ele contém a definição das tabelas utilizadas pelo sistema.

Principais tabelas:

```text
telegram_users
bot_interactions
chat_memory
```

---

### `database/tcc_ai_database_export.json`

Exportação completa do banco PostgreSQL até o momento.

Esse arquivo pode conter dados sensíveis, como nomes, identificadores técnicos e mensagens de teste. Portanto, deve ser mantido apenas em repositório privado ou substituído por uma versão anonimizada caso o repositório seja público.

---

### `database/bot_interactions_utf8.json`

Arquivo JSON contendo os registros da tabela `bot_interactions`, com acentuação preservada em UTF-8.

Essa tabela é a principal base para a análise futura, pois contém registros como:

* mensagens enviadas pelos usuários;
* comandos executados;
* ações no Trello;
* respostas da IA;
* cards criados;
* cards movidos;
* datas e horários das interações;
* payload bruto da execução.

---

### `n8n/TCC_Telegram_IA_Trello.json`

Arquivo exportado do workflow do n8n.

Esse workflow contém a lógica de integração entre:

* Telegram;
* PostgreSQL;
* Trello;
* Ollama;
* modelo `qwen2.5:3b`.

---

### `docs/comandos_bot.txt`

Arquivo com o guia de comandos do bot.

Ele documenta comandos como:

```text
minhas tarefas
listar geral
listar a fazer
listar em andamento
listar concluído
titulo: ...
descricao: ...
mover Nome do card para em andamento
```

---

## 7. Funcionamento Geral do Sistema

O funcionamento geral do WorkSense segue o fluxo abaixo:

```text
Usuário no Telegram
        ↓
Telegram Bot
        ↓
n8n Workflow
        ↓
PostgreSQL
        ↓
Classificação da intenção
        ↓
Trello ou Ollama
        ↓
Resposta ao usuário
        ↓
Registro da interação no banco
```

### Etapas do fluxo

1. O usuário envia uma mensagem ao bot pelo Telegram.
2. O `Telegram Trigger` do n8n recebe a mensagem.
3. O workflow consulta o PostgreSQL para verificar se o usuário já está vinculado.
4. Se o usuário não estiver vinculado, o bot solicita o nome no Trello.
5. Se o usuário estiver vinculado, o workflow identifica a intenção da mensagem.
6. A mensagem pode ser direcionada para:

   * consulta de tarefas;
   * criação de cards;
   * movimentação de cards;
   * listagem por status;
   * agente de IA.
7. A ação é executada no Trello ou no Ollama.
8. O resultado é enviado ao usuário no Telegram.
9. A interação é registrada no PostgreSQL.

---

## 8. Comandos do Bot

### 8.1 Cadastro inicial

Quando o bot perguntar:

```text
Olá! Antes de começar, qual é seu nome no Trello?
```

O usuário deve responder com seu nome de usuário do Trello.

Exemplos:

```text
joao151
maria452
spiify
tainacunhabueno
caioarnoni1
```

---

### 8.2 Listar tarefa principal atribuída pelo gestor

```text
minhas tarefas
```

Esse comando lista os cards da coluna `TAREFAS` que foram atribuídos ao usuário no Trello.

---

### 8.3 Criar um passo na coluna A FAZER

Formato:

```text
titulo: Nome do passo
descricao: Descrição detalhada do que deve ser feito
```

Exemplo:

```text
titulo: Adicionar botão de adicionar e remover itens
descricao: O botão terá cor azul para adicionar ao carrinho e vermelho para remover do carrinho. Todos devem ficar bem centralizados nas imagens dos produtos.
```

Esse comando cria um novo card na lista `A FAZER` e atribui automaticamente ao usuário autenticado.

---

### 8.4 Listar passos por status

```text
listar a fazer
listar em andamento
listar concluído
listar geral
```

O comando `listar geral` exibe os cards do usuário separados por:

```text
A FAZER
EM ANDAMENTO
CONCLUÍDO
```

---

### 8.5 Mover card entre listas

```text
mover Nome do card para a fazer
mover Nome do card para em andamento
mover Nome do card para concluído
```

Exemplo:

```text
mover Adicionar botão de adicionar e remover itens para em andamento
```

O sistema move apenas cards atribuídos ao próprio usuário.

---

### 8.6 Enviar dúvidas para a IA

Qualquer mensagem que não seja reconhecida como comando operacional é enviada para o agente de IA.

Exemplos:

```text
Como faço para colocar uma cor azul em JavaScript?
Me explique como conectar no banco de dados.
Como criar uma tela de login?
```

---

## 9. Banco de Dados PostgreSQL

O PostgreSQL está hospedado na VPS da Hostinger e funciona como banco operacional do WorkSense.

Ele possui três tabelas principais:

```text
telegram_users
bot_interactions
chat_memory
```

---

### 9.1 Tabela `telegram_users`

Tabela responsável por armazenar o vínculo entre usuários do Telegram e membros do Trello.

| Campo              | Descrição                      |
| ------------------ | ------------------------------ |
| `id`               | Identificador interno          |
| `telegram_id`      | ID do usuário no Telegram      |
| `telegram_name`    | Nome do usuário no Telegram    |
| `trello_member_id` | ID técnico do membro no Trello |
| `trello_name`      | Nome de usuário no Trello      |
| `created_at`       | Data de criação do registro    |

O campo `telegram_id` pode iniciar como `NULL`. Ele é preenchido quando o usuário realiza o primeiro vínculo pelo bot.

---

### 9.2 Tabela `bot_interactions`

Tabela principal para análise futura.

Ela registra as mensagens dos usuários, comandos executados, ações do Trello, respostas da IA e payloads brutos.

| Campo              | Descrição                                     |
| ------------------ | --------------------------------------------- |
| `id`               | Identificador do log                          |
| `telegram_id`      | ID do usuário no Telegram                     |
| `telegram_name`    | Nome do usuário no Telegram                   |
| `trello_name`      | Usuário vinculado no Trello                   |
| `trello_member_id` | ID técnico do membro Trello                   |
| `direction`        | Origem da interação: `user`, `ai` ou `trello` |
| `action`           | Tipo da ação executada                        |
| `user_message`     | Mensagem enviada pelo usuário                 |
| `bot_response`     | Resposta enviada pelo bot ou IA               |
| `trello_card_id`   | ID do card no Trello                          |
| `trello_card_name` | Nome do card                                  |
| `trello_list_from` | Lista de origem                               |
| `trello_list_to`   | Lista de destino                              |
| `raw_payload`      | Payload bruto em JSON                         |
| `created_at`       | Data e hora da interação                      |

Exemplos de ações registradas:

```text
listar_tarefas
listar_execucao
criar_passos
criar_passo
mover_card
ai
ai_response
```

---

### 9.3 Tabela `chat_memory`

Tabela utilizada pelo node de memória conversacional do n8n.

| Campo        | Descrição                     |
| ------------ | ----------------------------- |
| `id`         | Identificador da mensagem     |
| `session_id` | ID da sessão do usuário       |
| `message`    | Conteúdo da mensagem em JSONB |

Essa tabela permite que o agente de IA mantenha contexto curto da conversa.

---

## 10. Ollama e Modelo qwen2.5:3b

O agente de IA é executado localmente na VPS da Hostinger utilizando Ollama.

Modelo utilizado:

```text
qwen2.5:3b
```

O papel desse modelo é **apenas conversacional**. Ele responde dúvidas técnicas e mensagens gerais dos usuários, mas não calcula scores, não avalia desempenho e não gera diagnóstico.

A análise dos dados será feita posteriormente por scripts Python separados, que serão adicionados na pasta `analysis/`.

---

## 11. Separação entre IA Conversacional e Análise

Um ponto importante do projeto é separar o papel do agente conversacional e o papel dos módulos analíticos.

### Ollama / qwen2.5:3b

Função:

* responder dúvidas;
* apoiar o usuário;
* simular interação com IA;
* gerar respostas em português brasileiro.

### Scripts Python de análise

Função futura:

* processar mensagens;
* extrair indicadores linguísticos;
* aplicar análise de sentimentos;
* calcular embeddings;
* processar logs do Trello;
* calcular scores;
* gerar gráficos e sinalizações.

Portanto, o modelo qwen2.5:3b não é responsável por classificar usuários, calcular scores ou tomar decisões.

---

## 12. Exportação dos Dados

Os dados podem ser exportados da VPS para arquivos JSON.

### 12.1 Exportar banco completo

```bash
docker exec -i tcc-postgres psql -U admin -d tcc_ai -At -c "
SELECT jsonb_pretty(
  jsonb_build_object(
    'telegram_users',
      COALESCE(
        (SELECT jsonb_agg(to_jsonb(t))
         FROM (SELECT * FROM telegram_users ORDER BY id) t),
        '[]'::jsonb
      ),
    'bot_interactions',
      COALESCE(
        (SELECT jsonb_agg(to_jsonb(b))
         FROM (SELECT * FROM bot_interactions ORDER BY id) b),
        '[]'::jsonb
      ),
    'chat_memory',
      COALESCE(
        (SELECT jsonb_agg(to_jsonb(c))
         FROM (SELECT * FROM chat_memory ORDER BY id) c),
        '[]'::jsonb
      )
  )
);
" > /root/tcc-system/tcc_ai_database_export.json
```

---

### 12.2 Exportar apenas interações do bot

```bash
docker exec -i tcc-postgres psql -U admin -d tcc_ai -c "\copy (
  SELECT COALESCE(jsonb_agg(to_jsonb(bot_interactions) ORDER BY created_at), '[]'::jsonb)
  FROM bot_interactions
) TO STDOUT" > /root/tcc-system/bot_interactions_export.json
```

---

### 12.3 Converter JSON para UTF-8 legível

```bash
python3 - <<'PY'
import json

entrada = "/root/tcc-system/bot_interactions_export.json"
saida = "/root/tcc-system/bot_interactions_utf8.json"

with open(entrada, "r", encoding="utf-8") as f:
    data = json.load(f)

with open(saida, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print("Arquivo gerado:", saida)
PY
```

---

### 12.4 Baixar arquivo da VPS para o computador

No PowerShell:

```powershell
scp root@IP_DA_VPS:/root/tcc-system/bot_interactions_utf8.json "$env:USERPROFILE\Downloads\"
```

## 21. Relação com a Documentação do TCC

Este repositório documenta a implementação técnica inicial do WorkSense, principalmente:

* workflow n8n;
* banco PostgreSQL;
* integração com Telegram;
* integração com Trello;
* integração com Ollama;
* exportação de dados;
* documentação dos comandos do bot;
* previsão de testes de software;
* separação entre avaliação experimental e testes técnicos;
* espaço para scripts de análise.

A etapa de análise em Python será adicionada posteriormente e deverá complementar:

* processamento de mensagens;
* processamento de logs do Trello;
* cálculo dos scores;
* avaliação experimental;
* testes automatizados;
* visualizações finais.

---

## 22. Observação Acadêmica

O WorkSense é uma ferramenta experimental para fins acadêmicos.

As respostas da IA, os registros do Trello e os futuros scores devem ser interpretados apenas como apoio à análise humana em ambiente simulado.

O sistema não deve ser utilizado para diagnóstico, avaliação clínica, punição, ranqueamento automático ou tomada de decisão automatizada sobre pessoas.
