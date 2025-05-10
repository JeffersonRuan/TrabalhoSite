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
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <title>Produtos</title>
</head>
<body style="display: flex; flex-direction: column; height: 100vh; margin: 0;">
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
    <div class="content" style="padding: 20px; flex-grow: 1; overflow-y: auto;">
        <h1>Carrinho</h1>
        <div class="contentCarrinho">
        <%
                    List<Produto> produtos = (List<Produto>) session.getAttribute("carrinho");
                    if (produtos != null && !produtos.isEmpty()) {
                        for (Produto p : produtos) { %>
                            <div class="produto">
                                Nome: <%= p.getNome() %><br>
                                Descrição: <%= p.getDescricao() %><br>
                                Preço: R$ <%= p.getPreco() %><br>
                                Quantidade: <%= p.getQuantidade() %><br>

                                <!-- Formulário para remover o produto -->
                                <form action="carrinho" method="post">
                                    <input type="hidden" name="acao" value="remover">
                                    <input type="hidden" name="nome" value="<%= p.getNome() %>">
                                    <button class="button remover" type="submit">Remover</button>
                                </form>
                            </div>

                <%      }
                    } else { %>
                        <p>Carrinho Vazio</p>
                <% } %>
        </div>

        <% if (produtos != null && !produtos.isEmpty()) { %>
            <form action="pedidos" method="post">
                <input type="hidden" name="acao" value="finalizar">
                <button class="button finalizar" type="submit">Finalizar Pedido</button>
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