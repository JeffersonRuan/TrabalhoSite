package controller;

import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;
import util.JPAUtil;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        EntityManager em = null;

        try {
            em = JPAUtil.getEntityManager();

            TypedQuery<Usuario> query = em.createQuery(
                    "SELECT u FROM Usuario u WHERE u.email = :email AND u.senha = :senha", Usuario.class);
            query.setParameter("email", email);
            query.setParameter("senha", senha);

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
}