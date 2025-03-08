package controller;

import model.Produto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cadastrar")
    public class ProdutoServlet extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                String nome = request.getParameter("nome");
                String descricao = request.getParameter("descricao");
                float preco = Float.parseFloat(request.getParameter("preco"));
                int quantidade = Integer.parseInt(request.getParameter("quantidade"));

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

                Produto novoProduto = new Produto(nome, descricao, preco, quantidade);

                List<Produto> produtos = (List<Produto>) request.getSession().getAttribute("produtos");
                if(produtos == null) {
                    produtos = new ArrayList<>();
                }
                produtos.add(novoProduto);

                System.out.println("Produtos na sessão: " + produtos);
                request.getSession().setAttribute("produtos", produtos);

                request.setAttribute("sucesso", "Produto cadastrado com sucesso!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                request.setAttribute("erro", "Erro: Preço ou quantidade inválidos!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            }
        }
}
