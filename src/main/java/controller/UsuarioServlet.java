package controller;

import model.Usuario;
import util.JPAUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


import java.io.IOException;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

@WebServlet("/cadastrarUsuario")
public class UsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (nome == null || nome.isEmpty() || email == null || email.isEmpty() || senha == null || senha.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Nome, email e senha são obrigatórios.");
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setNome(nome);
        usuario.setEmail(email);
        try {
            usuario.setSenha(hashSenha(senha));
        } catch (NoSuchAlgorithmException e) {
            throw new ServletException("Erro ao criptografar senha", e);
        }

        EntityManager em = null;
        EntityTransaction tx = null;

        try {
            em = JPAUtil.getEntityManager();
            tx = em.getTransaction();
            tx.begin();
            em.persist(usuario);
            tx.commit();
            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new ServletException("Erro ao cadastrar usuario", e);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    private String hashSenha(String senha) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = md.digest(senha.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hashBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}
