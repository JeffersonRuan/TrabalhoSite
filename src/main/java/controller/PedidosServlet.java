package controller;

import jakarta.servlet.http.HttpSession;
import model.Pedido;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Produto;
import util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/pedidos")
public class PedidosServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            List<Pedido> pedidos = (List<Pedido>) session.getAttribute("pedidos");

            if (pedidos == null) {
                pedidos = new ArrayList<>();
            }

            List<Produto> carrinho = (List<Produto>) session.getAttribute("carrinho");
            List<Produto> produtos = (List<Produto>) session.getAttribute("produtos");

            if (carrinho == null || carrinho.isEmpty()) {
                request.setAttribute("erro", "Carrinho vazio! Não é possível finalizar o pedido.");
                request.getRequestDispatcher("carrinho.jsp").forward(request, response);
                return;
            }

            String acao = request.getParameter("acao");

            if ("finalizar".equals(acao)) {
                // Gerando número do pedido
                int numeroPedido = pedidos.size() + 1;

                Pedido novoPedido = new Pedido();
                novoPedido.setNumeroPedido(numeroPedido);
                novoPedido.setProdutos(carrinho);  // Associa os produtos ao pedido

                // Atualizando o estoque de produtos
                for (Produto prod : carrinho) {
                    if (prod.getQuantidade() >= 1) {
                        prod.setQuantidade(prod.getQuantidade() - 1);  // Atualiza estoque
                    }
                }

                // Persistindo o pedido e produtos no banco
                EntityManager em = null;
                EntityTransaction tx = null;

                try {
                    em = JPAUtil.getEntityManager();
                    tx = em.getTransaction();
                    tx.begin();

                    // Persistindo o novo pedido
                    em.persist(novoPedido);

                    // Persistindo os produtos atualizados
                    for (Produto prod : carrinho) {
                        em.merge(prod);
                    }

                    tx.commit();

                    pedidos.add(novoPedido);
                    session.setAttribute("pedidos", pedidos);

                    // Removendo o carrinho após a finalização do pedido
                    session.removeAttribute("carrinho");

                    request.setAttribute("sucesso", "Pedido finalizado com sucesso!");
                    request.getRequestDispatcher("pedidos.jsp").forward(request, response);

                } catch (Exception e) {
                    if (tx != null && tx.isActive()) {
                        tx.rollback();
                    }
                    request.setAttribute("erro", "Erro ao finalizar o pedido: " + e.getMessage());
                    request.getRequestDispatcher("pedidos.jsp").forward(request, response);
                } finally {
                    if (em != null) {
                        em.close();
                    }
                }
            }

        } catch (Exception e) {
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("pedidos.jsp").forward(request, response);
        }
    }
}
