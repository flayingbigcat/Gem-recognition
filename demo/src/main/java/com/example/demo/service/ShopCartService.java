package com.example.demo.service;

import com.example.demo.pojo.Product;
import com.example.demo.pojo.ShopCart;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public interface ShopCartService {
    boolean addShopCart(ShopCart shopCart);
}
