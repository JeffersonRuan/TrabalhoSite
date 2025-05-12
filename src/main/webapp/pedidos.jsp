<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Pedido, java.util.List" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.Produto" %>
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
    <title>Meus Pedidos</title>
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
            overflow-y: auto;
        }

        h1 {
            font-size: 2em;
            color: #333;
            margin-bottom: 20px;
        }

        .contentPedidos {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .pedido {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .pedido-header {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
        }

        .pedido-produtos {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .produto {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            color: #555;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }

        .produto p {
            margin: 0;
        }

        .cancelar-btn {
            background-color: #ff6b6b;
            color: white;
            padding: 10px 20px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .cancelar-btn:hover {
            background-color: #e64a4a;
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
        <a href="index.jsp">Produtos</a>
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
    <h1>Meus Pedidos</h1>

    <div class="contentPedidos">
        <%
            List<Pedido> pedidos = (List<Pedido>) session.getAttribute("pedidos");
            if (pedidos != null && !pedidos.isEmpty()) {
                for (Pedido p : pedidos) {
        %>
        <div class="pedido">
            <div class="pedido-header">
                Pedido #: <%= p.getNumeroPedido() %>
            </div>
            <div class="pedido-produtos">
                <% for (Produto produto : p.getProdutos()) { %>
                <div class="produto">
                    <p><strong>Nome:</strong> <%= produto.getNome() %></p>
                    <p><strong>Quantidade:</strong> <%= produto.getQuantidade() %></p>
                    <p><strong>Preço:</strong> R$ <%= produto.getPreco() %></p>
                </div>
                <% } %>
            </div>
            <form action="pedidos" method="post">
                <input type="hidden" name="acao" value="cancelar">
                <input type="hidden" name="idPedido" value="<%= p.getId() %>">
                <button class="cancelar-btn" type="submit">Cancelar Pedido</button>
            </form>
        </div>
        <%
            }
        } else {
        %>
        <p>Você não tem pedidos.</p>
        <%
            }
        %>
    </div>

    <%-- Exibindo alertas de sucesso ou erro --%>
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