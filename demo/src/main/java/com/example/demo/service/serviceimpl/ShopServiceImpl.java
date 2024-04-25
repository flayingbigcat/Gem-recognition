package com.example.demo.service.serviceimpl;

import com.example.demo.mapper.shopMapper;
import com.example.demo.pojo.shop;
import com.example.demo.service.ShopService;
import jdk.xml.internal.XMLSecurityManager;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ShopServiceImpl implements ShopService {
    @Resource
    private shopMapper shopMapper;
    @Override
    public List<shop> selectShop() {
        return shopMapper.selectShop();
    }

    @Override
    public shop selectShop1(int id) {
        return shopMapper.selectShop1(id);
    }

    @Override
    public shop searchShop(String product_name) {
        return shopMapper.searchShop(product_name);
    }

    @Override
    public List<shop> selectShop2() {
        return shopMapper.selectShop2();
    }

}
