package controller;

import model.Produto;
import model.Usuario;
import util.JPAUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cadastrar")
public class ProdutoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Verifica permissão
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuarioLogado");

        if (usuario == null || !"ADMIN".equalsIgnoreCase(usuario.getPermissao())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acesso negado.");
            return;
        }

        EntityManager em = null;
        EntityTransaction tx = null;

        try {
            // Coleta as informações do produto
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            float preco = Float.parseFloat(request.getParameter("preco"));
            int quantidade = Integer.parseInt(request.getParameter("quantidade"));

            // Validação dos valores
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

            // Cria um novo objeto Produto e atribui os valores
            Produto novoProduto = new Produto();
            novoProduto.setNome(nome);         // Atribuindo nome
            novoProduto.setDescricao(descricao); // Atribuindo descrição
            novoProduto.setPreco(preco);         // Atribuindo preço
            novoProduto.setQuantidade(quantidade); // Atribuindo quantidade

            // Persistir o produto no banco de dados usando JPA
            em = JPAUtil.getEntityManager();
            tx = em.getTransaction();
            tx.begin();

            // Salva o produto
            em.persist(novoProduto);

            // Commit da transação
            tx.commit();

            // Atribui a lista de produtos na sessão (caso seja necessário, pode ser útil para o front-end)
            List<Produto> produtos = (List<Produto>) request.getSession().getAttribute("produtos");
            if (produtos == null) {
                produtos = new ArrayList<>();
            }
            produtos.add(novoProduto);
            request.getSession().setAttribute("produtos", produtos);

            // Mensagem de sucesso
            request.setAttribute("sucesso", "Produto cadastrado com sucesso!");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Erro: Preço ou quantidade inválidos!");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
}