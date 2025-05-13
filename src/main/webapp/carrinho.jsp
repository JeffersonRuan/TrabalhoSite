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
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrinho de Compras</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        .navbar {
            background-color: #333;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 18px;
        }

        .navbar a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-weight: bold;
        }

        .navbar a:hover {
            color: #f4a261;
        }

        .content {
            flex-grow: 1;
            padding: 20px;
        }

        h1 {
            font-size: 2em;
            color: #333;
            margin-bottom: 20px;
        }

        .contentCarrinho {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .produto {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 16px;
        }

        .produto p {
            margin: 5px 0;
        }

        .produto .detalhes {
            display: flex;
            flex-direction: column;
            width: 60%;
        }

        .produto .actions {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }

        .button {
            background-color: #f4a261;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #e76f51;
        }

        .finalizar {
            background-color: #2a9d8f;
        }

        .finalizar:hover {
            background-color: #264c43;
        }

        .total {
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .erro, .sucesso {
            background-color: #ff6b6b;
            padding: 10px;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            margin-top: 15px;
        }

        .sucesso {
            background-color: #4caf50;
        }
    </style>
</head>
<body>

<!-- Menu superior -->
<div class="navbar">
    <p>Loja</p>
    <div>
        <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
        <% if (usuario != null && "ADMIN".equals(usuario.getPermissao())) { %>
        <a href="cadastro.jsp">Cadastro</a>
        <% } %>
        <a href="carrinho.jsp">Carrinho</a>
        <a href="pedidos.jsp">Pedidos</a>
    </div>
    <a href="logout.jsp">Sair</a>
</div>

<!-- Conteúdo da página -->
<div class="content">
    <h1>Carrinho de Compras</h1>

    <div class="contentCarrinho">
        <%
            List<Produto> produtos = (List<Produto>) session.getAttribute("carrinho");
            if (produtos != null && !produtos.isEmpty()) {
                for (Produto p : produtos) {
        %>
        <div class="produto">
            <div class="detalhes">
                <p><strong>Nome:</strong> <%= p.getNome() %></p>
                <p><strong>Descrição:</strong> <%= p.getDescricao() %></p>
                <p><strong>Preço:</strong> R$ <%= p.getPreco() %></p>
                <p><strong>Quantidade:</strong> <%= p.getQuantidade() %></p>
            </div>
            <div class="actions">
                <!-- Formulário para remover o produto -->
                <form action="carrinho" method="post">
                    <input type="hidden" name="acao" value="remover">
                    <input type="hidden" name="nome" value="<%= p.getNome() %>">
                    <button class="button">Remover</button>
                </form>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <p>Carrinho Vazio</p>
        <%
            }
        %>
    </div>

    <%-- Exibindo o valor total e a quantidade total --%>
    <%
        Float valorTotal = (Float) session.getAttribute("valorTotal");
        Integer quantidadeTotal = (Integer) session.getAttribute("quantidadeTotal");
    %>

    <div class="total">
        <p>Total de Produtos: <%= quantidadeTotal %></p>
        <p>Total: R$ <%= String.format("%.2f", valorTotal) %></p>
    </div>

    <%-- Exibindo o botão para finalizar o pedido --%>
    <%
        if (produtos != null && !produtos.isEmpty()) {
    %>
    <form action="pedidos" method="post">
        <input type="hidden" name="acao" value="finalizar">
        <button class="button finalizar" type="submit">Finalizar Pedido</button>
    </form>
    <% } %>

    <%-- Exibindo alertas --%>
    <script>
        <% if (request.getAttribute("erro") != null) { %>
        alert("<%= request.getAttribute("erro") %>");
        <% } %>

        <% if (request.getAttribute("sucesso") != null) { %>
        alert("<%= request.getAttribute("sucesso") %>");
        <% } %>
    </script>
</div>

</body>
</html>
