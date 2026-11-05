# Sistema de vendas

Este projeto foi feito para praticar PHP e consultas SQL. A página inicial mostra os produtos cadastrados no banco, junto com sua categoria, preço e quantidade em estoque.

## Como o banco está organizado

O banco se chama `db_sistema_vendas` e tem tabelas para clientes, vendedores, produtos, categorias e pedidos. O arquivo [`fisico.sql`](fisico.sql) cria as tabelas e insere dados de exemplo: 30 clientes, 10 vendedores, 150 produtos e 50 pedidos.

As tabelas se relacionam por chaves estrangeiras. Por exemplo, cada pedido aponta para um cliente e um vendedor, e cada produto fica associado a uma categoria. Há também algumas regras no banco, como e-mail único para clientes e preço positivo para produtos.

## Migração das categorias

No início, a categoria era guardada como texto diretamente em cada produto — por exemplo, “Informática” ou “Games”. Isso repetia o mesmo nome em muitos registros. O script demonstra a migração desse modelo para uma tabela própria de categorias:

1. Cria `tbl_categorias` e copia para ela os nomes distintos encontrados em `tbl_produtos.categoria`.
2. Adiciona a coluna `id_categoria` aos produtos.
3. Preenche essa coluna relacionando o texto antigo ao ID correspondente na tabela de categorias.
4. Cria uma chave estrangeira entre `tbl_produtos.id_categoria` e `tbl_categorias.id`.
5. Depois de conferir os dados migrados, remove a antiga coluna de texto `categoria` da tabela de produtos.

Assim, cada categoria fica cadastrada uma única vez, e os produtos passam a apontar para ela pelo ID. O `SELECT` com `JOIN` no fim da migração permite conferir o vínculo antes da remoção da coluna antiga. Como o arquivo contém a criação e a carga inicial do banco, execute-o em uma base nova, não em uma base que já tenha essas tabelas ou dados.

## A página PHP

O arquivo [`index.php`](index.php) busca os produtos e suas categorias com um `INNER JOIN` e exibe o resultado em uma tabela HTML. A conexão é feita por [`conexao.php`](conexao.php), usando MySQLi.

## Para executar

Você precisa de PHP com a extensão MySQLi e MySQL 8. O script usa a collation `utf8mb4_0900_ai_ci`.

1. Inicie o MySQL e importe o banco:

   ```bash
   mysql -u root -p < fisico.sql
   ```

2. Confira as configurações de host, usuário, senha e nome do banco em `conexao.php`. O arquivo vem configurado para `localhost`, usuário `root`, senha vazia e banco `db_sistema_vendas` — ajuste esses valores ao seu ambiente.
3. Inicie o servidor PHP na pasta do projeto:

   ```bash
   php -S localhost:8000
   ```

4. Abra <http://localhost:8000> no navegador.

## Arquivos

- `index.php` — consulta e exibição dos produtos.
- `conexao.php` — conexão com o MySQL.
- `fisico.sql` — criação, migração, população e consultas de exemplo do banco.

> As credenciais de `conexao.php` são para uso local. Não coloque senhas reais no repositório; em um ambiente publicado, use configurações seguras e um usuário de banco com permissões limitadas.
