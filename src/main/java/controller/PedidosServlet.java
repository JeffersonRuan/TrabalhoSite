package controller;

import jakarta.servlet.http.HttpSession;
import model.Pedido;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Produto;

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
                int numeroPedido = pedidos.size() + 1;
                Pedido novoPedido = new Pedido(numeroPedido, new ArrayList<>(carrinho));

                pedidos.add(novoPedido);
                session.setAttribute("pedidos", pedidos);

                for (Produto produto : produtos) {
                    for (Produto prod : carrinho ) {
                        if (produto.getQuantidade() > 0) {
                            produto.setQuantidade(produto.getQuantidade() - prod.getQuantidade());
                        }
                    }
                }

                session.removeAttribute("carrinho");
                request.setAttribute("sucesso", "Pedido finalizado com sucesso!");
                request.getRequestDispatcher("pedidos.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("pedidos.jsp").forward(request, response);
        }
    }
}
