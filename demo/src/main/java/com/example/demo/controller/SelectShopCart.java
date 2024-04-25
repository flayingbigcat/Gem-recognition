package com.example.demo.controller;

import com.example.demo.pojo.ShopCart;
import com.example.demo.service.ShopCartService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


import javax.annotation.Resource;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class SelectShopCart {
    @Resource
    private ShopCartService shopCartService;
    @PostMapping("/addShopCart")
    boolean addShopCart(@RequestBody ShopCart shopCart){


        System.out.println(shopCart);

        return shopCartService.addShopCart(shopCart);
    }
}
