package com.example.demo.controller;

import com.example.demo.pojo.shop;
import com.example.demo.service.ShopService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class SelectShop {
    @Resource
    private ShopService shopService;
    @PostMapping("/selectShop")
    List<shop> selectShop(){
       return shopService.selectShop();
    }
    @PostMapping("/selectShop1")
    shop selectShop1(@RequestParam("id") int id){
        return shopService.selectShop1(id);
    }
    @PostMapping("/searchShop")
    shop searchShop(@RequestBody String product_name) throws JsonProcessingException {
        System.out.println(product_name);
        // JSON字符串
        // 创建ObjectMapper实例
        ObjectMapper objectMapper = new ObjectMapper();

        // 解析JSON字符串为JsonNode对象
        JsonNode jsonNode = objectMapper.readTree(product_name);

        // 获取 "productName" 的值
        String productName = jsonNode.get("productName").asText();

        // 打印获取的值
        System.out.println("productName: " + productName);
        System.out.println(shopService.searchShop(productName));
        return shopService.searchShop(productName);
    }

    @PostMapping("/selectShop2")
    List<shop> selectShop2(){
        return shopService.selectShop2();
    }
}
