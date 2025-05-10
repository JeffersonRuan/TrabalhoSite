<%@ page contentType="text/html; charset=UTF-8" %>
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
    <title>Cadastro de Produtos</title>
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

    <div class="content" style="display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0;>
        <div class="form">
                <h2>Cadastrar Produto</h2>
                <form class="form" action="cadastrar" method="post" style="display:flex; flex-direction: column; justify-content: space-around;">
                    <div style="display:flex; flex-direction: column;">Nome <input type="text" name="nome" required></div>
                    <div style="display:flex; flex-direction: column;">Descrição <input type="text" name="descricao" required></div>
                    <div class="inputs" style="display:flex; flex-direction: row;">
                        <div class="input" style="display:flex; flex-direction: column;">Preco <input type="number" name="preco" required></div>
                        <div class="input" style="display:flex; flex-direction: column;">Quantidade <input type="number" name="quantidade" required></div>
                    </div>

                    <button class="button" type="submit">Cadastrar</button>
                </form>
        </div>

        <!-- Script para exibir alertas -->\
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