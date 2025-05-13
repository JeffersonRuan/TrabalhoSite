package controller;

import model.Produto;
import model.Usuario;
import util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cadastrar")
public class ProdutoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Verifica permissão
        HttpSession session = request.getSession(false);
        Usuario usuario = session != null
                ? (Usuario) session.getAttribute("usuarioLogado")
                : null;

        if (usuario == null || !"ADMIN".equalsIgnoreCase(usuario.getPermissao())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acesso negado.");
            return;
        }

        EntityManager em = null;
        EntityTransaction tx = null;

        try {
            String nome      = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            float preco      = Float.parseFloat(request.getParameter("preco"));
            int quantidade   = Integer.parseInt(request.getParameter("quantidade"));

            // Validações
            if (preco <= 0) {
                request.setAttribute("erro", "O preço deve ser maior do que 0!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
                return;
            }
            if (quantidade <= 0) {
                request.setAttribute("erro", "A quantidade deve ser pelo menos 1!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
                return;
            }

            // Persiste o novo produto
            em = JPAUtil.getEntityManager();
            tx = em.getTransaction();
            tx.begin();

            Produto novoProduto = new Produto();
            novoProduto.setNome(nome);
            novoProduto.setDescricao(descricao);
            novoProduto.setPreco(preco);
            novoProduto.setQuantidade(quantidade);

            em.persist(novoProduto);
            tx.commit();

            // Após salvar, redireciona para a listagem (sempre reflete o banco)
            response.sendRedirect(request.getContextPath() + "/produtos");
        }
        catch (NumberFormatException e) {
            request.setAttribute("erro", "Erro: Preço ou quantidade inválidos!");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }
        catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }
        finally {
            if (em != null) em.close();
        }
    }
}
