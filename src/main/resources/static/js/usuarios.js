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