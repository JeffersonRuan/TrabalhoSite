package model;

import java.util.List;

public class Pedido {
    private int numeroPedido;
    private List<Produto> produtos;

    public Pedido(int numeroPedido, List<Produto> produtos) {
        this.numeroPedido = numeroPedido;
        this.produtos = produtos;
    }

    public int getNumeroPedido() {
        return this.numeroPedido;
    }

    public List<Produto> getProdutos() {
        return this.produtos;
    }
}

