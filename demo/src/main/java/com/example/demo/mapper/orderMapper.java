package com.example.demo.mapper;

import com.example.demo.pojo.order;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface orderMapper {
    boolean addOrder(order order);
    boolean deleteOrder(order order);
}
