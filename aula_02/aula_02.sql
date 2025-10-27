-- AULA 02

/*
Mais operadores
Os operadores de comparação no SQL são essenciais para filtrar 
registros em consultas com base em condições específicas. 
Vamos examinar cada um dos operadores que você mencionou (<, >, <=, >=, <>) com exemplos práticos. 
Suponhamos que temos uma tabela chamada products com 
uma coluna unit_price para o preço dos produtos e uma coluna units_in_stock para o número de itens em estoque.
*/

-- Operador < (Menor que)
-- Seleciona todos os produtos com preço menor que 20
SELECT * FROM products
WHERE unit_price < 20;

-- Operador > (Maior que)
-- Seleciona todos os produtos com preço maior que 100
SELECT * FROM products
WHERE unit_price > 100;

-- Operador <= (Menor ou igual a)
-- Seleciona todos os produtos com preço menor ou igual a 50
SELECT * FROM products
WHERE unit_price <= 50;

-- Operador >= (Maior ou igual a)
-- Seleciona todos os produtos com quantidade em estoque maior ou igual a 10
SELECT * FROM products
WHERE units_in_stock >= 10;

-- Operador <> (Diferente de)
-- Seleciona todos os produtos cujo preço não é 30
SELECT * FROM products
WHERE unit_price <> 30;

/*
Combinação de Operadores
Você também pode combinar vários operadores em uma única consulta para criar condições mais específicas:
*/

-- Seleciona todos os produtos com preço entre 50 e 100 (exclusive)
SELECT * FROM products
WHERE unit_price >= 50 AND unit_price < 100;

-- Seleciona todos os produtos com preço fora do intervalo 20 a 40
SELECT * FROM products
WHERE unit_price < 20 OR unit_price > 40;

-- Is null and is not null: Usado em conjunto com o where para criar regras mais complexas de filtro nos registros.
SELECT * FROM customers
WHERE contact_name is Null;

SELECT * FROM customers
WHERE contact_name is not null;

-- LIKE

-- Nome do cliente começando com "a":
SELECT * FROM customers
WHERE contact_name LIKE 'a%';

/*
Para tratar as strings como maiúsculas ou minúsculas em uma consulta SQL, 
você pode usar as funções UPPER() ou LOWER(), respectivamente. Essas funções convertem 
todas as letras em uma string para maiúsculas ou minúsculas, 
permitindo que você faça comparações de forma mais flexível, ignorando a diferença entre maiúsculas e minúsculas.


Aqui está como você pode modificar a consulta para encontrar todos os clientes cujo nome começa com a letra "a", independentemente de ser maiúscula ou minúscula:
*/

-- Para encontrar nomes que começam com "a" em maiúscula ou minúscula:
SELECT * FROM customers
WHERE LOWER(contact_name) LIKE 'a%';

-- Essa consulta converte todo o contact_name para minúsculas antes de fazer a comparação, o que torna a busca insensível a maiúsculas e minúsculas.

-- Para encontrar nomes que começam com "A" em maiúscula:
SELECT * FROM customers
WHERE UPPER(contact_name) LIKE 'A%';

/*
Essa consulta converte todo o contact_name para maiúsculas 
antes de fazer a comparação, garantindo que apenas os nomes 
que começam com "A" maiúscula sejam selecionados.

Usar UPPER() ou LOWER() é uma prática comum para garantir 
que as condições aplicadas em campos de texto não sejam afetadas 
por diferenças de capitalização nas entradas de dados.
*/

-- Nome do cliente terminando com "a":
SELECT * FROM customers
WHERE contact_name LIKE '%a';

-- Nome do cliente que possui "or" em qualquer posição:
SELECT * FROM customers
WHERE contact_name LIKE '%or%';

-- Nome do cliente com "r" na segunda posição:
SELECT * FROM customers
WHERE contact_name LIKE '_r%';

-- Nome do cliente que começa com "A" e tem pelo menos 3 caracteres de comprimento:
SELECT * FROM customers
WHERE contact_name LIKE 'A_%_%';

-- Nome do contato que começa com "A" e termina com "o":
SELECT * FROM customers
WHERE contact_name LIKE 'A%o';

-- Nome do cliente que NÃO começa com "a":
SELECT * FROM customers
WHERE contact_name NOT LIKE 'A%';

-- Usando o curinga [charlist] (SQL server)
SELECT * FROM customers
WHERE city LIKE '[BSP]%';

-- Usando o curinga Similar To (Postgres)
SELECT * FROM customers
WHERE city SIMILAR TO '(B|S|P)%';

-- Usando o MySQL (coitado, tem nada)
SELECT * FROM customers
WHERE (city LIKE 'B%' OR city LIKE 'S%' OR city LIKE 'P%');
Operador IN

-- localizado na "Alemanha", "França" ou "Reino Unido":
SELECT * FROM customers
WHERE country IN ('Germany', 'France', 'UK');

-- NÃO localizado na "Alemanha", "França" ou "Reino Unido":
SELECT * FROM customers
WHERE country NOT IN ('Germany', 'France', 'UK');

-- Só para dar um gostinho de uma subqueyr... Seleciona todos os clientes que são dos mesmos países que os fornecedores:

SELECT * FROM customers
WHERE country IN (SELECT country FROM suppliers);

-- Exemplo com BETWEEN
SELECT * FROM products
WHERE unit_price BETWEEN 10 AND 20;

-- Exemplo com NOT BETWEEN
SELECT * FROM products
WHERE unit_price NOT BETWEEN 10 AND 20;

-- Seleciona todos os produtos com preço ENTRE 10 e 20. Adicionalmente, não mostra produtos com CategoryID de 1, 2 ou 3:
SELECT * FROM products
WHERE (unit_price BETWEEN 10 AND 20) AND category_id NOT IN (1, 2, 3);

--selects todos os produtos entre 'Carnarvon Tigers' e 'Mozzarella di Giovanni':
SELECT * FROM products
WHERE product_name BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY product_name;

--Selecione todas as ordens BETWEEN '04-July-1996' e '09-July-1996':
SELECT * FROM orders
WHERE order_date BETWEEN '07/04/1996' AND '07/09/1996';

/*
Tangente sobre diferentes bancos
O comando SQL que você mencionou é específico para PostgreSQL e 
não necessariamente padrão em todos os SGBDs (Sistemas de Gerenciamento de Banco de Dados). 
Cada SGBD pode ter funções e formatos de data ligeiramente diferentes. No entanto, 
a estrutura básica do comando SELECT e a cláusula WHERE usando BETWEEN são bastante universais.

Aqui estão algumas variantes para outros SGBDs populares:

SQL Server
Para formatar datas em SQL Server, você usaria a função CONVERT ou FORMAT (a partir do SQL Server 2012):
*/

-- Usando CONVERT
SELECT CONVERT(VARCHAR, order_date, 120) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- Usando FORMAT
SELECT FORMAT(order_date, 'yyyy-MM-dd') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';
MySQL
MySQL utiliza a função DATE_FORMAT para formatar datas:

SELECT DATE_FORMAT(order_date, '%Y-%m-%d') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- Oracle
-- Oracle também usa a função TO_CHAR como PostgreSQL para formatação de datas:

SELECT TO_CHAR(order_date, 'YYYY-MM-DD') FROM orders
WHERE order_date BETWEEN TO_DATE('1996-04-07', 'YYYY-MM-DD') AND TO_DATE('1996-09-07', 'YYYY-MM-DD');

-- SQLite
-- SQLite não tem uma função dedicada para formatar datas, mas você pode usar funções de string para manipular formatos de data padrão:

SELECT strftime('%Y-%m-%d', order_date) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

/*
Funções Agregadas (COUNT, MAX, MIN, SUM, AVG): Usadas para realizar cálculos em um conjunto de valores.
As funções agregadas são uma ferramenta fundamental na linguagem SQL, 
utilizadas para realizar cálculos sobre um conjunto de valores e retornar um único valor resultante. 
Essas funções são especialmente úteis em operações que envolvem a análise estatística de dados, 
como a obtenção de médias, somas, valores máximos e mínimos, entre outros. Ao operar em conjuntos de dados, 
as funções agregadas permitem extrair insights significativos, suportar decisões de negócios, e simplificar dados complexos em informações gerenciáveis.

As funções agregadas geralmente são usadas em consultas SQL com a cláusula GROUP BY, 
que agrupa linhas que têm os mesmos valores em colunas especificadas. No entanto, 
podem ser usadas sem GROUP BY para resumir todos os dados de uma tabela. Aqui estão 
as principais funções agregadas e como são aplicadas:
*/

-- Exemplo de MIN()
SELECT MIN(unit_price) AS preco_minimo
FROM products;

-- Exemplo de MAX()
SELECT MAX(unit_price) AS preco_maximo
FROM products;

-- Exemplo de COUNT()
SELECT COUNT(*) AS total_de_produtos
FROM products;

-- Exemplo de AVG()
SELECT AVG(unit_price) AS preco_medio
FROM products;

-- Exemplo de SUM()
SELECT SUM(quantity) AS quantidade_total_de_order_details
FROM order_details;
Práticas Recomendadas
Precisão de dados: Ao usar AVG() e SUM(), esteja ciente do tipo de dados da coluna para evitar imprecisões, especialmente com dados flutuantes.
NULLs: Lembre-se de que a maioria das funções agregadas ignora valores NULL, exceto COUNT(*), que conta todas as linhas, incluindo aquelas com valores NULL.
Performance: Em tabelas muito grandes, operações agregadas podem ser custosas em termos de desempenho. Considere usar índices adequados ou realizar pré-agregações quando aplicável.
Clareza: Ao usar GROUP BY, assegure-se de que todas as colunas não agregadas na sua cláusula SELECT estejam incluídas na cláusula GROUP BY.

-- Exemplo de MIN() com GROUP BY
-- Calcula o menor preço unitário de produtos em cada categoria
SELECT category_id, MIN(unit_price) AS preco_minimo
FROM products
GROUP BY category_id;

-- Exemplo de MAX() com GROUP BY
-- Calcula o maior preço unitário de produtos em cada categoria
SELECT category_id, MAX(unit_price) AS preco_maximo
FROM products
GROUP BY category_id;

-- Exemplo de COUNT() com GROUP BY
-- Conta o número total de produtos em cada categoria
SELECT category_id, COUNT(*) AS total_de_produtos
FROM products
GROUP BY category_id;

-- Exemplo de AVG() com GROUP BY
-- Calcula o preço médio unitário de produtos em cada categoria
SELECT category_id, AVG(unit_price) AS preco_medio
FROM products
GROUP BY category_id;

-- Exemplo de SUM() com GROUP BY
-- Calcula a quantidade total de produtos pedidos por pedido
SELECT order_id, SUM(quantity) AS quantidade_total_por_pedido
FROM order_details
GROUP BY order_id;