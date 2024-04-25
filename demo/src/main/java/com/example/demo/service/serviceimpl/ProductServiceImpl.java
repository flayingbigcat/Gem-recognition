package com.example.demo.service.serviceimpl;

import com.example.demo.mapper.productMapper;
import com.example.demo.pojo.Product;
import com.example.demo.service.ProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Resource
    private com.example.demo.mapper.productMapper productMapper;
    public Product selectProductById(int id) {
        return productMapper.selectProductById(id);
    }

    @Override
    public boolean deleteProduct(int id) {
        return productMapper.deleteProduct(id);
    }

    @Override
    public List<Product> getProduct(int id) {
        return productMapper.getProduct(id);
    }

    @Override
    public List<Product> selectProduct(int user_id) {
        return productMapper.selectProduct(user_id);
    }
}
