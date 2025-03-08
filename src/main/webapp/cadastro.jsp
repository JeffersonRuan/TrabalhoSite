<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastro de Produtos</title>
</head>
<body style="display: flex; flex-direction: column; height: 100vh; margin: 0;">
    <!-- Menu superior -->
    <div style="background-color: #333; padding: 10px; text-align: center; flex-shrink: 0;">
        <a href="index.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Produtos</a>
        <a href="cadastro.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Cadastro</a>
        <a href="carrinho.jsp" style="color: white; margin: 0 15px; text-decoration: none; font-weight: bold;">Carrinho</a>
    </div>

    <div style="display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #F0F4F9">
        <div style="display: flex; flex-direction: column; align-items: center; gap: 10px; padding: 20px; border: 1px solid #000; border-radius: 10px; width: 300px; background-color: #FFF">
                <h2>Cadastrar Produto</h2>
                <% if (request.getAttribute("erro") != null) { %>
                    <p style="color:red;"><%= request.getAttribute("erro") %></p>
                <% } %>

                <% if (request.getAttribute("sucesso") != null) { %>
                    <p style="color:green;"><%= request.getAttribute("sucesso") %></p>
                <% } %>
                <form action="cadastrar" method="post" style="display:flex; flex-direction: column; justify-content: space-around; height: 300px;">
                    <div style="display:flex; flex-direction: column;">Nome <input type="text" name="nome" required></div>
                    <div style="display:flex; flex-direction: column;">Descrição <input type="text" name="descricao" required></div>
                    <div style="display:flex; flex-direction: column;">Preco <input type="number" name="preco" required></div>
                    <div style="display:flex; flex-direction: column;">Quantidade <input type="number" name="quantidade" required></div>
                    <button type="submit" style="background-color: #1A73E8; padding: 8px 16px; border-radius: 6px; border: 1px solid #1A73E8; color: white;">Cadastrar</button>
                </form>
            </div>
    </div>

</body>
</html>