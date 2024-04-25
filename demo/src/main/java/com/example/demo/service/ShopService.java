package com.example.demo.service;
import com.example.demo.pojo.shop;
import jdk.xml.internal.XMLSecurityManager;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
@Service
public interface ShopService {
    List<shop> selectShop();
    shop selectShop1(int id);
    shop searchShop(String product_name);
    List<shop> selectShop2();
}
