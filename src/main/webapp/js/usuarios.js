<script>
document.getElementById('cadastroForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const nome = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const senha = document.getElementById('password').value;

    fetch('/registrar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            nome: nome,
            email: email,
            senha: senha
        })
    })
    .then(response => response.json())
    .then(data => {
        alert("Usuário cadastrado com sucesso!");
        console.log(data);
    })
    .catch(error => {
        console.error('Erro ao cadastrar:', error);
        alert("Erro ao cadastrar usuário.");
    });
});
</script>