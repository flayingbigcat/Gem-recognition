package com.example.demo.mapper;

import com.example.demo.pojo.Product;
import com.example.demo.pojo.ShopCart;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface shopCartMapper {
    boolean addShopCart(ShopCart shopCart);

}
