<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.TrabalhoSite.model.Pedido, java.util.List" %>
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
    <div class="navbar" style="background-color: #333; padding: 10px; text-align: center; flex-shrink: 0;">
        <a href="index.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Produtos</a>
        <a href="WEB-INF/jsp/cadastro.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Cadastro</a>
        <a href="carrinho.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Carrinho</a>
        <a href="pedidos.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Pedidos</a>
    </div>

    <!-- Conteúdo da página -->
    <div class="content" style="color: white; padding: 30px; flex-grow: 1; overflow-y: auto;">
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