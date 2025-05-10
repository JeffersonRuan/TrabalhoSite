const cadastroForm  = document.getElementById('cadastroForm');
if (cadastroForm ) {
    document.getElementById('cadastroForm').addEventListener('submit', async function (e) {
        e.preventDefault();

        console.log('ativou a funcao')

        const nome = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const senha = document.getElementById('password').value;

        try {
            const response = await fetch('/usuarios/registrar', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    nome: nome,
                    email: email,
                    senha: senha
                })
            });

            if (!response.ok) {
                throw new Error('Erro ao cadastrar usuário');
            }

            const data = await response.json();
            alert("Usuário cadastrado com sucesso!");
            console.log(data);
        } catch (error) {
            console.error('Erro ao cadastrar:', error);
            alert("Erro ao cadastrar usuário.");
        }
    });
}

const loginForm = document.getElementById('loginForm');
if (loginForm) {
    document.getElementById("loginForm").addEventListener("submit", function(e) {
        e.preventDefault();

        const data = {
            email: document.getElementById("email").value,
            senha: document.getElementById("senha").value
        };

        fetch("/fazer-login", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        })
            .then(res => res.text())
            .then(msg => {
                if (msg === "sucesso") {
                    alert("Login bem-sucedido!");
                    localStorage.setItem("logado", "true");
                    window.location.href = "/";
                } else {
                    alert("Email ou senha inválidos!");
                }
            });
    });
}
