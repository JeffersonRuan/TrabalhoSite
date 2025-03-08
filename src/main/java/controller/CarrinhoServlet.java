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
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            float preco = Float.parseFloat(request.getParameter("preco"));
            int quantidade = Integer.parseInt(request.getParameter("quantidade"));

            if (quantidade <= 0) {
                request.setAttribute("erro", "Produto sem estoque!");
                return;
            }

            Produto produto = new Produto(nome, descricao, preco, quantidade);

            HttpSession session = request.getSession();
            List<Produto> carrinho = (List<Produto>) session.getAttribute("carrinho");

            if(carrinho == null) {
                carrinho = new ArrayList<>();
            }
            carrinho.add(produto);
            session.setAttribute("carrinho", carrinho);

            System.out.println("Produtos no carrinho: " + carrinho);
            response.sendRedirect("carrinho.jsp");
        } catch (Exception e) {
            request.setAttribute("erro", "Erro inesperado: " + e.getMessage());
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }
    }
}
