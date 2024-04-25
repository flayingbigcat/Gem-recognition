package com.example.demo.service.serviceimpl;

import com.example.demo.pojo.order;
import com.example.demo.service.OrderService;
import com.example.demo.mapper.orderMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
@Service
public class OrderServiceImpl implements OrderService {
    @Resource
    private orderMapper orderMapper;
    @Override
    public boolean addOrder(order order) {
        if(orderMapper.addOrder(order)){
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteOrder(order order) {
        if(orderMapper.deleteOrder(order)){
            return true;
        }
        return false;
    }
}
