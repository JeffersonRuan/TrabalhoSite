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
</head>
<body class="layout">

<!-- Menu superior -->
<div class="navbar">
    <p>Loja</p>
    <div>
        <a href="index.jsp">Produtos</a>
        <a href="cadastro.jsp">Cadastro</a>
        <a href="carrinho.jsp">Carrinho</a>
        <a href="pedidos.jsp">Pedidos</a>
    </div>
    <a href="logout.jsp">Sair</a>
</div>

<!-- Conteúdo da página -->
<div class="content scrollable">
    <h2>Bem-vindo, <%= usuario.getNome() %>!</h2>
    <h1>Produtos</h1>
    <div class="contentProdutos">
        <%
            List<Produto> produtos = (List<Produto>) session.getAttribute("produtos");
            if (produtos != null) {
                for (Produto p : produtos) {
        %>
        <div class="produto">
            Nome: <%= p.getNome() %><br>
            Descrição: <%= p.getDescricao() %><br>
            Preço: R$ <%= p.getPreco() %><br>
            Quantidade: <%= p.getQuantidade() %><br>

            <form action="carrinho" method="post">
                <input type="hidden" name="acao" value="adicionar">
                <input type="hidden" name="nome" value="<%= p.getNome() %>">
                <input type="hidden" name="descricao" value="<%= p.getDescricao() %>">
                <input type="hidden" name="preco" value="<%= p.getPreco() %>">
                <input type="hidden" name="quantidade" value="<%= p.getQuantidade() %>">
                <button class="button" type="submit">Adicionar ao carrinho</button>
            </form>
        </div>
        <%
            }
        } else {
        %>
        <p>Nenhum produto cadastrado.</p>
        <a class="button" href="cadastro.jsp">Clique para cadastrar</a>
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
