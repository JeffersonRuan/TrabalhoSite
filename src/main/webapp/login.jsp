<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.TrabalhoSite.model.Produto, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../resources/static/css/global.css">
    <title>Login</title>
    <style>
        body {
            background-color: #fff !important;
            margin: 0;
            padding: 0;
            font-family: 'Montserrat', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            background: #f9f9f9;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        h2 {
            color: #000;
            text-align: center;
            margin-bottom: 24px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }
        .button {
            width: 100%;
            padding: 12px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-bottom: 10px;
        }
        .button:hover {
            background-color: #333;
        }
        .link-container {
            text-align: center;
            margin-top: 16px;
        }

        .link-container a {
            text-decoration: none;
            font-weight: bolder;
            color: #115EA3;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="carrinho" method="post">
            <label for="user">Usuário</label>
            <input type="text" name="user">
            <label for="password">Senha</label>
            <input type="password" name="password">
            <button class="button" type="submit">Entrar</button>
            <div class="link-container">
                <a href="cadastroUser.jsp">Criar uma conta</a>
            </div>
        </form>
    </div>
</body>
</html>