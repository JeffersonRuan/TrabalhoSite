package com.TrabalhoSite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    @GetMapping("/")
    public String home() {
        return "index"; // Retorna a página index.html
    }

    @GetMapping("/login")
    public String login() {
        return "login"; // Retorna a página login.html
    }
}
