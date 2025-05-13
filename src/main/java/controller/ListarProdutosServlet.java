package controller;

import model.Produto;
import util.JPAUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.persistence.EntityManager;
import java.io.IOException;
import java.util.List;

@WebServlet("/produtos")
public class ListarProdutosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = JPAUtil.getEntityManager();
        List<Produto> produtos = em.createQuery("SELECT p FROM Produto p", Produto.class)
                .getResultList();
        em.close();

        req.setAttribute("produtos", produtos);
        req.getRequestDispatcher("/index.jsp")
                .forward(req, resp);
    }
}