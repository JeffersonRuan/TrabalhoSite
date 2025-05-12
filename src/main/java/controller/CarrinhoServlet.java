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

                // Verifica se a quantidade solicitada é válida
                if (quantidade <= 0) {
                    request.setAttribute("erro", "Quantidade inválida!");
                    request.getRequestDispatcher("carrinho.jsp").forward(request, response);
                    return;
                }

                boolean produtoExiste = false;

                for (Produto p : carrinho) {
                    if (p.getNome().equals(nome)) {
                        produtoExiste = true;
                        // Atualiza a quantidade se o produto já existir no carrinho
                        p.setQuantidade(p.getQuantidade() + quantidade);
                        break;
                    }
                }

                if (!produtoExiste) {
                    Produto produto = new Produto();
                    produto.setNome(nome);
                    produto.setDescricao(descricao);
                    produto.setPreco(preco);
                    produto.setQuantidade(quantidade);
                    carrinho.add(produto);
                }

                session.setAttribute("carrinho", carrinho);
                request.setAttribute("sucesso", "Produto adicionado ao carrinho!");
                response.sendRedirect("carrinho.jsp");

            } else if ("remover".equals(acao)) {
                String nomeProduto = request.getParameter("nome");

                carrinho.removeIf(p -> p.getNome().equals(nomeProduto));

                session.setAttribute("carrinho", carrinho);
                request.setAttribute("sucesso", "Produto removido!");
                response.sendRedirect("carrinho.jsp");
            }

            // Calcular o valor total e a quantidade total
            float valorTotal = 0;
            int quantidadeTotal = 0;

            for (Produto p : carrinho) {
                valorTotal += p.getPreco() * p.getQuantidade();
                quantidadeTotal += p.getQuantidade();
            }

            // Passar esses valores para a página JSP
            session.setAttribute("valorTotal", valorTotal);
            session.setAttribute("quantidadeTotal", quantidadeTotal);

        } catch (Exception e) {
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("carrinho.jsp").forward(request, response);
        }
    }
}