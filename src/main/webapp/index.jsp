<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Usuario, model.Produto, java.util.List" %>

<%
    // 1) Valida login
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2) Pega produtos do request (ListarProdutosServlet fez request.setAttribute)
    @SuppressWarnings("unchecked")
    List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Produtos</title>
    <link rel="stylesheet" href="./css/global.css">
    <style>
        /* ... seu CSS aqui ... */
    </style>
</head>
<body>
<div class="navbar">
    <p>Loja</p>
    <div>
        <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
        <% if ("ADMIN".equalsIgnoreCase(usuario.getPermissao())) { %>
        <a href="cadastro.jsp">Cadastro</a>
        <% } %>
        <a href="carrinho.jsp">Carrinho</a>
        <a href="pedidos.jsp">Pedidos</a>
    </div>
    <a href="logout.jsp">Sair</a>
</div>

<div class="content">
    <h2>Bem-vindo, <%= usuario.getNome() %>!</h2>
    <h1>Produtos</h1>

    <div class="contentProdutos">
        <% if (produtos != null && !produtos.isEmpty()) {
            for (Produto p : produtos) { %>
        <div class="produto">
            <p><strong>Nome:</strong> <%= p.getNome() %></p>
            <p><strong>Descrição:</strong> <%= p.getDescricao() %></p>
            <p><strong>Preço:</strong> R$ <%= p.getPreco() %></p>
            <p><strong>Quantidade disponível:</strong> <%= p.getQuantidade() %></p>
            <form action="carrinho" method="post">
                <input type="hidden" name="acao" value="adicionar"/>
                <input type="hidden" name="nome" value="<%= p.getNome() %>"/>
                <input type="hidden" name="descricao" value="<%= p.getDescricao() %>"/>
                <input type="hidden" name="preco" value="<%= p.getPreco() %>"/>
                <input type="hidden" name="quantidadeEstoque" value="<%= p.getQuantidade() %>"/>
                <label for="qtd_<%=p.getId()%>">Quantidade:</label>
                <input type="number"
                       id="qtd_<%=p.getId()%>"
                       name="quantidade"
                       min="1"
                       max="<%=p.getQuantidade()%>"
                       value="1"
                       required/>
                <button class="button" type="submit">Adicionar ao carrinho</button>
            </form>
        </div>
        <%   }
        } else { %>
        <p>Nenhum produto encontrado.</p>
        <% if ("ADMIN".equalsIgnoreCase(usuario.getPermissao())) { %>
        <a class="button" href="cadastro.jsp">Clique para cadastrar</a>
        <% } %>
        <% } %>
    </div>
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