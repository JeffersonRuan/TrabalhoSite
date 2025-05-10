package com.TrabalhoSite.controller;

import com.TrabalhoSite.model.Usuario;
import com.TrabalhoSite.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class AuthController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @PostMapping("/fazer-login")
    public String fazerLogin(@RequestBody Usuario usuario) {
        Usuario user = usuarioRepository.findByEmailAndSenha(usuario.getEmail(), usuario.getSenha());

        return user != null ? "sucesso" : "erro";
    }
}