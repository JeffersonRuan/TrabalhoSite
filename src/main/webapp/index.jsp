<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Produto, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Produtos</title>
</head>
<body style="display: flex; flex-direction: column; height: 100vh; margin: 0;">
    <!-- Menu superior -->
    <div style="background-color: #333; padding: 10px; text-align: center; flex-shrink: 0;">
        <a href="index.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Produtos</a>
        <a href="cadastro.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Cadastro</a>
        <a href="#" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Carrinho</a>
    </div>

    <!-- Conteúdo da página -->
    <div style="padding: 20px; flex-grow: 1; overflow-y: auto;">
        <h1>Produtos</h1>
        <%
            List<Produto> produtos = (List<Produto>) session.getAttribute("produtos");
            if (produtos != null) {
                for (Produto p : produtos) { %>
                    <div>
                        <%= p.getNome() %><br>
                        <%= p.getDescricao() %><br>
                        <%= p.getPreco() %><br>
                        <%= p.getQuantidade() %><br>
                    </div>
        <%      }
            } else { %>
                <p>Nenhum produto cadastrado.</p>
        <% } %>
    </div>
</body>
</html>