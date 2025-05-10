package com.TrabalhoSite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    @GetMapping("/")
    public String home() {
        return "index"; // Retorna a página index.html
    }

    @GetMapping("/cadastroUsuario")
    public String cadastroUsuario() {
        return "cadastroUsuario"; // Retorna a página login.html
    }

    @GetMapping("/login")
    public String login() {
        return "login"; // Retorna a página login.html
    }

    @GetMapping("/carrinho")
    public String carrinho() {
        return "carrinho"; // Retorna a página login.html
    }

    @GetMapping("/cadastroProduto")
    public String cadastroProduto() {
        return "cadastroProduto"; // Retorna a página login.html
    }

    @GetMapping("/pedidos")
    public String pedidos() {
        return "pedidos"; // Retorna a página login.html
    }
}
