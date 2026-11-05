<?php

require_once "conexao.php";

$sql = "SELECT
            p.id,
            p.nome AS produto,
            p.preco,
            p.quantidade,
            c.nome AS categoria
        FROM tbl_produtos AS p
        INNER JOIN tbl_categorias AS c
            ON p.id_categoria = c.id
        ORDER BY p.id ASC";

$resultado = mysqli_query($conexao, $sql);

if (!$resultado) {
    die("Erro na consulta: " . mysqli_error($conexao));
}

?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>ETEC - Consulta de Produtos</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f8f9fa;
        }

        h1 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
        }

        th,
        td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

    </style>

</head>

<body>

    <h1>Lista de Produtos Cadastrados</h1>

    <p>
        Esta página executa o comando <strong>SELECT</strong>
        no MySQL e exibe os produtos cadastrados.
    </p>

    <table>

        <thead>

            <tr>
                <th>Código (ID)</th>
                <th>Nome do Produto</th>
                <th>Categoria</th>
                <th>Preço (R$)</th>
                <th>Estoque (Qtd)</th>
            </tr>

        </thead>

        <tbody>

            <?php while ($linha = mysqli_fetch_assoc($resultado)): ?>

                <tr>

                    <td>
                        <?= htmlspecialchars($linha['id']) ?>
                    </td>

                    <td>
                        <?= htmlspecialchars($linha['produto']) ?>
                    </td>

                    <td>
                        <?= htmlspecialchars($linha['categoria']) ?>
                    </td>

                    <td>
                        R$
                        <?= number_format($linha['preco'], 2, ',', '.') ?>
                    </td>

                    <td>
                        <?= htmlspecialchars($linha['quantidade']) ?>
                    </td>

                </tr>

            <?php endwhile; ?>

        </tbody>

    </table>

</body>

</html>

<?php

mysqli_close($conexao);

?>
