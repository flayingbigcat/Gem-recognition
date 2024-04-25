package com.example.demo.service;

import com.example.demo.pojo.order;
import org.springframework.stereotype.Service;

@Service
public interface OrderService {
    boolean addOrder(order order);
    boolean deleteOrder(order order);
}
