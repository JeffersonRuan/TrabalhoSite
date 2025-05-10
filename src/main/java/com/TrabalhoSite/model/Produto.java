package com.TrabalhoSite.model;

public class Produto {
    private String nome;
    private String descricao;
    private float preco;
    private int quantidade;

    public Produto(String nome, String descricao, float preco, int quantidade) {
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.quantidade = quantidade;
    }


    public String getNome() { return nome; }
    public String getDescricao() { return descricao; }
    public float getPreco() { return preco; }
    public int getQuantidade() { return quantidade; }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    @Override
    public String toString() {
        return " Produto: " + nome + " - " +
                "Descrição: " + descricao + " - " +
                "Preço R$ " + preco + " - " +
                "Quantidade: " + quantidade;
    }
}