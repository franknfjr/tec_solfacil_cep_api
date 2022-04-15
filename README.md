# TecSolfacilCepApi

[![CI](https://github.com/franknfjr/tec_facil_cep_api/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/franknfjr/tec_facil_cep_api/actions/workflows/ci.yml)

A aplicação consiste em um usuário que vai chamar um endpoint passando um cep para buscar um endereço,
caso o cep já exista na nossa base de dados retornar o endereço para o usuário,
caso contrário buscar o endereço no ws https://viacep.com.br/ws/CEP/json/ 

Também foi criado um endpoint para gerar o arquivo CSV passando a lista dos endereços.

## Informacoes Tecnicas

O projeto foi criado todo na linguagem [Elixir](https://elixir-lang.org/) na versão 1.12.3 utilizando o framwork [Phoenix](https://www.phoenixframework.org/) versão 1.6

Para fazer as taxas de conversão foi utilizado a API do  [ViaCEP](https://viacep.com.br/)

Para a persistência dos dados foi utilizado o PostgreSQL.

Outras bibliotecas que foram utilizadas:

* [Credo](https://github.com/rrrene/credo) para garantir o estilo de código
* [CSV](https://github.com/beatrichartz/csv) Parser de CSV
* [Finch](https://github.com/sneako/finch) cliente HTTP para fazer requisições
* [Guardian](https://github.com/ueberauth/guardian) Guardian é uma biblioteca de autenticação baseada em token para uso com aplicativos Elixir.
* [Oban](https://github.com/sorentwo/oban) responsável por enfileirar e rodar jobs em background


## Instalação

Execute os seguintes comandos:

```sh
git clone https://github.com/franknfjr/tec_solfacil_cep_api.git
cd tec_solfacil_cep_api
```

Após entrar no diretório, feito isso podemos fazer a compilação e excução da aplicação, executando os seguintes comandos:

```sh
mix deps.get
mix ecto.create && mix ecto.migrate
```

## Funcionamento

Para início, vamos observar todas nossas rotas executando o comando:

```sh
mix phx.routes
```

Metodo | endpoint   | descrição | valores que podem ser passados para os parametros
-------|--------- | ----------------------- | --------------
GET | /api/v1/register | registra um usuário | 
GET | /api/v1/login | cria sessão de usuario |
GET | /api/v1/addresses/:cep | retorna um endereço pelo cep |  `cep`
GET | /api/v1/addresses/send_csv | exporta o arquivo csv | 
`*` | /dev/mailbox | interface de email | 

Agora execute o comando para iniciar a aplicação.
```bash
mix phx.server
```

## Requisições

Abaixo, alguns exemplos de chamadas que serão feitas nessa API:

POST `/api/v1/register`

O código HTTP de retorno deve ser 200 e o corpo esperado na resposta é:

```json
{
	"message": "email@example.com",
	"status": "ok"
}
```

POST `/api/v1/login`

O código HTTP de retorno deve ser 200 e o corpo esperado na resposta é:

```json
{
	"data": {
		"email": "email@example.com",
		"token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0ZWNfc29sZmFjaWxfY2VwX2FwaSIsImV4cCI6MTY1MjQwNTExOCwiaWF0IjoxNjQ5OTg1OTE4LCJpc3MiOiJ0ZWNfc29sZmFjaWxfY2VwX2FwaSIsImp0aSI6IjNjZTYyNDQyLWYwOTMtNDdkZi04NGZjLTJiZjYyZjJhZTc2YiIsIm5iZiI6MTY0OTk4NTkxNywic3ViIjoiMiIsInR5cCI6ImFjY2VzcyJ9.7HOdYi7NAYF036uYRNLCnlZkJLp_laiyLZZ_dlnwYOHiuXXQIiC0OjcKa2UD-8APdaEFsm5UVd_L2nsCjV3OWQ"
	},
	"message": "You are successfully logged in! Add this token to authorization header to make authorized requests.",
	"status": "ok"
}
```

GET `/api/v1/addresses/:cep`

O código HTTP de retorno deve ser 200 e o corpo esperado na resposta é:

```json
{
	"data": {
		"bairro": "Maguari",
		"cep": "67145037",
		"complemento": "(Cj PAAR)",
		"ddd": "91",
		"ibge": "1500800",
		"localidade": "Ananindeua",
		"logradouro": "Quadra Cem",
		"siafi": "0415",
		"uf": "PA"
	}
}
```

GET `/api/v1/addresses/send_csv`

O código HTTP de retorno deve ser 202 e o corpo esperado na resposta é:

```json
{
	"message": "Accepted",
	"status": 202
}
```