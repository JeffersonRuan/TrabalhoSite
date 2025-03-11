<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Produto, java.util.List" %>
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
    <div class="navbar" style="background-color: #333; padding: 10px; text-align: center; flex-shrink: 0;">
        <a href="index.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Produtos</a>
        <a href="cadastro.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Cadastro</a>
        <a href="carrinho.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Carrinho</a>
        <a href="pedidos.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Pedidos</a>
    </div>

    <!-- Conteúdo da página -->
    <div class="content" style="padding: 20px; flex-grow: 1; overflow-y: auto;">
        <h1>Produtos</h1>
        <div class="contentProdutos">
        <%
                    List<Produto> produtos = (List<Produto>) session.getAttribute("produtos");
                    if (produtos != null) {
                        for (Produto p : produtos) { %>
                            <div class="produto">
                                Nome: <%= p.getNome() %><br>
                                Descrição: <%= p.getDescricao() %><br>
                                Preço: R$ <%= p.getPreco() %><br>
                                Quantidade: <%= p.getQuantidade() %><br>

                                <!-- Formulário para adicionar ao carrinho -->
                                <form action="carrinho" method="post">
                                    <input type="hidden" name="acao" value="adicionar">
                                    <input type="hidden" name="nome" value="<%= p.getNome() %>">
                                    <input type="hidden" name="descricao" value="<%= p.getDescricao() %>">
                                    <input type="hidden" name="preco" value="<%= p.getPreco() %>">
                                    <input type="hidden" name="quantidade" value="<%= p.getQuantidade() %>">
                                    <button class="button" type="submit">Adicionar ao carrinho</button>
                                </form>
                            </div>
                <%      }
                    } else { %>
                        <p>Nenhum produto cadastrado.</p>
                        <a class="button" href="cadastro.jsp">Clique para cadastrar</a>
                <% } %>
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