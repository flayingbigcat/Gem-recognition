package com.example.demo.mapper;

import com.example.demo.pojo.Product;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface productMapper {
    Product selectProductById(int id);
    boolean deleteProduct(int id);

    List<Product> getProduct(int id);

    List<Product> getProduct();
    List<Product> selectProduct(int user_id);

}
