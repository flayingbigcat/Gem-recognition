package com.example.demo.pojo;

public class ShopCart {
    private int user_id;
    private int product_id;
    private String product_name;
    private String product_price;

    public ShopCart() {
    }

    public ShopCart(int user_id, int product_id, String product_name, String product_price) {
        this.user_id = user_id;
        this.product_id = product_id;
        this.product_name = product_name;
        this.product_price = product_price;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getProduct_price() {
        return product_price;
    }

    public void setProduct_price(String product_price) {
        this.product_price = product_price;
    }

    @Override
    public String toString() {
        return "ShopCart{" +
                "user_id=" + user_id +
                ", product_id=" + product_id +
                ", product_name='" + product_name + '\'' +
                ", product_price='" + product_price + '\'' +
                '}';
    }
}
