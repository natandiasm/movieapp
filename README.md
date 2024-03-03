### MovieApp
O MovieApp é um app simples em ruby on rails para adicionar filmes e notas.

#### Requisitos:

- ruby-3.1.4
- sqlite3
- redis-7.0

Clone o projeto e execute:
```ruby
bundle install
rails db:migrate
rails db:seed
```

Depois execute (para subir redis o sidekiq e o app do rails):
``` shell
redis-server && bundle exec sidekiq && rails server
```

#### O que você terá:
Será configurado uma aplicação rails contando com as seguintes funcionalidades:
- Usuário padrão admin@rotten e senha admin
- Página de login (/)
- Rota para criação de novos usuários (/users/new)
- Rota para cadastrar novo filme (/movies/new)
- Rota para cadastrar varios filmes (/movies/import)
- Rota para dar nota nos filmes (/movies)
- Rota para dar varias notas nos filmes (/movies/)
- Exibir a média das notas de cada filme (/movies/scores_import)


# Pontos de melhoria:
- Adicionar testes para todos os casos de uso;
- Melhorar sistema de importação adicionando os filmes em lotes;
- Adicionar notificações em tempo real mostrando o status das importações;
- Melhorar HTML e CSS da aplicação.
