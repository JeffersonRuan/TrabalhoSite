<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Pedido, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pedidos</title>
</head>
<body style="display: flex; flex-direction: column; height: 100vh; margin: 0;">
    <!-- Menu superior -->
    <div style="background-color: #333; padding: 10px; text-align: center; flex-shrink: 0;">
        <a href="index.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Produtos</a>
        <a href="cadastro.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Cadastro</a>
        <a href="carrinho.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Carrinho</a>
        <a href="pedidos.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Pedidos</a>
    </div>

    <!-- Conteúdo da página -->
    <div style="padding: 20px; flex-grow: 1; overflow-y: auto;">
        <h1>Pedidos</h1>
        <%
            List<Pedido> pedidos = (List<Pedido>) session.getAttribute("pedidos");
            if (pedidos != null) {
                for (Pedido p : pedidos) { %>
                    <div>
                        <%= p.getNumeroPedido() %>
                    </div>
        <%      }
            } else { %>
                <p>Nenhum pedido realizado.</p>
        <% } %>
    </div>
</body>
</html>