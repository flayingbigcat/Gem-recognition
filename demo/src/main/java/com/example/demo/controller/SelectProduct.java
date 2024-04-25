package com.example.demo.controller;

import com.example.demo.pojo.Product;
import com.example.demo.pojo.User;
import com.example.demo.service.ProductService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class SelectProduct {
    @Resource
    private ProductService productService;
    @PostMapping("/selectId")
    public ResponseEntity<?> selectProductById(@RequestParam("user_id") int id){
        Product product = productService.selectProductById(id);
        if (product != null) {
            return ResponseEntity.ok(product);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product with ID: " + id + " not found.");
        }
    }

    @PostMapping("/deleteProduct")
    public boolean deleteProductById(@RequestParam("id") int id){
        return productService.deleteProduct(id);
    }

    @PostMapping("/getProduct")
    List<Product> getProduct(@RequestParam("id")int id){
        return productService.getProduct(id);
    }

    @PostMapping("/selectProduct")
    List<Product> selectProduct(@RequestBody Map<String, Object> payload){
    int id = Integer.parseInt(payload.get("user_id").toString());
    return productService.selectProduct(id);
}

}
