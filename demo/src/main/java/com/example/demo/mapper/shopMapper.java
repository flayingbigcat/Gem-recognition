package com.example.demo.mapper;

import com.example.demo.pojo.shop;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
@Mapper
@Repository
public interface shopMapper {
    List<shop> selectShop();
    shop selectShop1(int id);
    shop searchShop(@Param("product_name") String product_name);
    List<shop> selectShop2();
}
