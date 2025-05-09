package controller;

import model.Usuario;
import repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @PostMapping("/registrar")
    public Usuario registrar(@RequestBody Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody Usuario login) {
        Usuario usuario = usuarioRepository.findByEmail(login.getEmail());
        if (usuario != null && usuario.getSenha().equals(login.getSenha())) {
            return ResponseEntity.ok("Login realizado com sucesso");
        }
        return ResponseEntity.status(401).body("Email ou senha incorretos");
    }

    @GetMapping
    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }
}
