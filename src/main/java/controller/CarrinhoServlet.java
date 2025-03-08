package controller;

import jakarta.servlet.http.HttpSession;
import model.Produto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/carrinho")
public class CarrinhoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            List<Produto> carrinho = (List<Produto>) session.getAttribute("carrinho");

            if (carrinho == null) {
                carrinho = new ArrayList<>();
            }

            String acao = request.getParameter("acao");

            if ("adicionar".equals(acao)) {
                String nome = request.getParameter("nome");
                String descricao = request.getParameter("descricao");
                float preco = Float.parseFloat(request.getParameter("preco"));
                int quantidade = Integer.parseInt(request.getParameter("quantidade"));

                if (quantidade <= 0) {
                    request.setAttribute("erro", "Produto sem estoque!");
                    return;
                }

                boolean produtoExiste = false;

                for (Produto p : carrinho) {
                    if (p.getNome().equals(nome)) {
                        produtoExiste = true;
                        if (p.getQuantidade() < quantidade) {
                            p.setQuantidade(p.getQuantidade() + 1);
                            break;
                        } else {
                            request.setAttribute("erro", "Não é possível adicionar mais produtos!");
                            return;
                        }
                    }
                }

                if (!produtoExiste) {
                    Produto produto = new Produto(nome, descricao, preco, 1);
                    carrinho.add(produto);
                }

                request.setAttribute("sucesso", "Produto adicionado ao carrinho!");
                session.setAttribute("carrinho", carrinho);

            } else if ("remover".equals(acao)) {
                String nomeProduto = request.getParameter("nome");

                carrinho.removeIf(p -> p.getNome().equals(nomeProduto));

                session.setAttribute("carrinho", carrinho);
                request.setAttribute("sucesso", "Produto removido!");
            }

            response.sendRedirect("carrinho.jsp");
        } catch (Exception e) {
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("carrinho.jsp").forward(request, response);
        }
    }
}
