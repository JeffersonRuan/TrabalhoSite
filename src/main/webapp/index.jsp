<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Produto, java.util.List" %>
<%@ page import="model.Usuario" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Produtos</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <style>
        /* Resetando margens e preenchimento */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Layout geral */
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f4f4f9;
            color: #333;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        /* Menu superior */
        .navbar {
            background-color: #2a2a72;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }

        .navbar a:hover {
            color: #f1c40f;
        }

        .navbar p {
            font-size: 24px;
            margin-right: 30px;
        }

        /* Conteúdo da página */
        .content {
            padding: 30px;
            flex-grow: 1;
            overflow-y: auto;
        }

        h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 10px;
        }

        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        /* Cards de produto */
        .contentProdutos {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .produto {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .produto:hover {
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        .produto p {
            font-size: 16px;
            margin-bottom: 10px;
        }

        /* Botões */
        .button {
            background-color: #2a2a72;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            width: 100%;
            text-align: center;
        }

        .button:hover {
            background-color: #f1c40f;
        }

        /* Formulários */
        form {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        label {
            font-size: 14px;
            margin-bottom: 5px;
        }

        input[type="number"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            width: 100%;
            margin-bottom: 15px;
        }

        /* Responsividade */
        @media (max-width: 768px) {
            .navbar p {
                font-size: 20px;
            }

            .content {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<!-- Menu superior -->
<div class="navbar">
    <p>Loja</p>
    <div>
        <a href="index.jsp">Produtos</a>
        <%
            if (usuario != null && "ADMIN".equals(usuario.getPermissao())) {
        %>
        <a href="cadastro.jsp">Cadastro</a>
        <% } %>
        <a href="carrinho.jsp">Carrinho</a>
        <a href="pedidos.jsp">Pedidos</a>
    </div>
    <a href="logout.jsp">Sair</a>
</div>

<!-- Conteúdo da página -->
<div class="content">
    <h2>Bem-vindo, <%= usuario.getNome() %>!</h2>
    <h1>Produtos</h1>
    <div class="contentProdutos">
        <%
            List<Produto> produtos = (List<Produto>) session.getAttribute("produtos");
            if (produtos != null) {
                for (Produto p : produtos) {
        %>
        <div class="produto">
            <p><strong>Nome:</strong> <%= p.getNome() %></p>
            <p><strong>Descrição:</strong> <%= p.getDescricao() %></p>
            <p><strong>Preço:</strong> R$ <%= p.getPreco() %></p>
            <p><strong>Quantidade disponível:</strong> <%= p.getQuantidade() %></p>

            <!-- Formulário para adicionar ao carrinho com a opção de selecionar quantidade -->
            <form action="carrinho" method="post">
                <input type="hidden" name="acao" value="adicionar">
                <input type="hidden" name="nome" value="<%= p.getNome() %>">
                <input type="hidden" name="descricao" value="<%= p.getDescricao() %>">
                <input type="hidden" name="preco" value="<%= p.getPreco() %>">
                <input type="hidden" name="quantidadeEstoque" value="<%= p.getQuantidade() %>">

                <label for="quantidade">Quantidade:</label>
                <input type="number" id="quantidade" name="quantidade" min="1" max="<%= p.getQuantidade() %>" value="1" required>
                <button class="button" type="submit">Adicionar ao carrinho</button>
            </form>
        </div>
        <%
            }
        } else {
        %>
        <p>Nenhum produto cadastrado.</p>
        <%
            if (usuario != null && "ADMIN".equals(usuario.getPermissao())) {
        %>
        <a class="button" href="cadastro.jsp">Clique para cadastrar</a>
        <% } %>
        <%
            }
        %>
    </div>
</div>

<!-- Script para exibir alertas -->
<script>
    <% if (request.getAttribute("erro") != null) { %>
    alert("<%= request.getAttribute("erro") %>");
    <% } %>

    <% if (request.getAttribute("sucesso") != null) { %>
    alert("<%= request.getAttribute("sucesso") %>");
    <% } %>
</script>
</body>
</html>