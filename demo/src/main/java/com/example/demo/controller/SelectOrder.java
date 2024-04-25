package com.example.demo.controller;

import com.example.demo.pojo.order;
import com.example.demo.service.OrderService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class SelectOrder {
    @Resource
    private OrderService orderService;
    @PostMapping("/addOrder")
    public boolean addOrder(@RequestBody order order){
        return orderService.addOrder(order);
    }
    @PostMapping("/deleteOrder")
    public boolean deleteOrder(@RequestBody order order){
        return orderService.deleteOrder(order);
    }
}
