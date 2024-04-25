package com.example.demo.service;

import com.example.demo.pojo.Product;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ProductService {
    Product selectProductById(int id);
    boolean deleteProduct(int id);
    List<Product> getProduct(int id);

    List<Product> selectProduct(int user_id);

}
