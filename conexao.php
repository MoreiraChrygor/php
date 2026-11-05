<?php

$host = "localhost";
$usuario = "root";
$senha = "";
$banco = "db_sistema_vendas";

$conexao = mysqli_connect($host, $usuario, $senha, $banco);

if (!$conexao) {
    die("Erro ao conectar ao banco de dados: " . mysqli_connect_error());
}

mysqli_set_charset($conexao, "utf8mb4");
