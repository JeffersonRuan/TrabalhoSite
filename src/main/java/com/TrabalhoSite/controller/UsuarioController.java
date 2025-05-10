package com.TrabalhoSite.controller;

import com.TrabalhoSite.model.Usuario;
import com.TrabalhoSite.repository.UsuarioRepository;
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

    @GetMapping
    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }
}
