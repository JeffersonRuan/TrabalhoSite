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
        <a href="carrinho.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Carrinho</a>
    </div>

    <!-- Conteúdo da página -->
    <div style="padding: 20px; flex-grow: 1; overflow-y: auto;">
        <h1>Carrinho</h1>
        <%
            List<Produto> produtos = (List<Produto>) session.getAttribute("carrinho");
            if (produtos != null && !produtos.isEmpty()) {
                for (Produto p : produtos) { %>
                    <div>
                        <%= p.getNome() %><br>
                        <%= p.getDescricao() %><br>
                        <%= p.getPreco() %><br>
                        <%= p.getQuantidade() %><br>

                        <!-- Formulário para remover o produto -->
                        <form action="carrinho" method="post">
                            <input type="hidden" name="acao" value="remover">
                            <input type="hidden" name="nome" value="<%= p.getNome() %>">
                            <button type="submit">Remover</button>
                        </form>
                    </div>

        <%      }
            } else { %>
                <p>Carrinho Vazio</p>
        <% } %>

        <% if (produtos != null && !produtos.isEmpty()) { %>
            <form action="carrinho" method="post">
                <input type="hidden" name="acao" value="finalizar">
                <button type="submit">Finalizar Pedido</button>
            </form>
        <% } %>
    </div>

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