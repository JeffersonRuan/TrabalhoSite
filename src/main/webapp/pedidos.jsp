<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Pedido, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <title>Pedidos</title>
</head>
<body style="display: flex; flex-direction: column; height: 100vh; margin: 0;">
    <!-- Menu superior -->
    <div class="navbar">
        <p>Loja</p>
        <div>
            <a href="index.jsp">Produtos</a>
            <a href="cadastro.jsp">Cadastro</a>
            <a href="carrinho.jsp">Carrinho</a>
            <a href="pedidos.jsp">Pedidos</a>
        </div>
        <a href="#">Sair</a>
    </div>

    <!-- Conteúdo da página -->
    <div class="content" style="padding: 20px; flex-grow: 1; overflow-y: auto;">
        <h1>Pedidos</h1>
        <div class="contentPedidos">
        <%
                    List<Pedido> pedidos = (List<Pedido>) session.getAttribute("pedidos");
                    if (pedidos != null) {
                        for (Pedido p : pedidos) { %>
                            <div class="pedido">
                                <%= p.getNumeroPedido() %>
                                <%= p.getProdutos() %>
                            </div>
                <%      }
                    } else { %>
                        <p>Seu carrinho está vazio.</p>
                <% } %>
        </div>
    </div>
</body>
</html>