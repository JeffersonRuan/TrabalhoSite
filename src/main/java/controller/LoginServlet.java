package controller;

import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;
import util.JPAUtil;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        EntityManager em = null;

        try {
            String senhaHash = hashSenha(senha); // criptografa a senha recebida

            em = JPAUtil.getEntityManager();

            TypedQuery<Usuario> query = em.createQuery(
                    "SELECT u FROM Usuario u WHERE u.email = :email AND u.senha = :senha", Usuario.class);
            query.setParameter("email", email);
            query.setParameter("senha", senhaHash); // compara com o hash

            Usuario usuario = query.getSingleResult();

            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", usuario);
            response.sendRedirect("index.jsp");

        } catch (NoResultException e) {
            request.setAttribute("erro", "Email ou senha inválidos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Erro no login", e);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
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
