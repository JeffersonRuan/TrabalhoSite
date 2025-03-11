<%@ page contentType="text/html; charset=UTF-8" %>
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
    <div class="navbar" style="background-color: #333; padding: 10px; text-align: center; flex-shrink: 0;">
        <a href="index.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Produtos</a>
        <a href="cadastro.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Cadastro</a>
        <a href="carrinho.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Carrinho</a>
        <a href="pedidos.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Pedidos</a>
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