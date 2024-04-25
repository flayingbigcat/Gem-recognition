package com.example.demo.controller;

import com.example.demo.pojo.User;
import com.example.demo.pojo.order;
import com.example.demo.service.OrderService;
import com.example.demo.service.UserService;
import org.apache.ibatis.jdbc.Null;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController @CrossOrigin(origins = "*", maxAge = 3600) // 允许所有源发起请求，有效时间为 3600 秒
public class SelectUser {
//    public static void main(String[] args) {
//
//    }
    @Resource
    private UserService userService;


    @GetMapping("/aaa")
    public List<User> getAllUser(){
        return userService.getAllUser();
    }

    @PostMapping("/addUser")
    public void addUser(@RequestBody User user){
        userService.addUser(user);
    }

    @PostMapping("/addUsercc")
    public User addUserCheckIsExist(@RequestBody User user){
        if(userService.selectUserByName(user.getUser_email())!=null){
            return null;
        }
            userService.addUserCheckIsExist(user);//添加用户
        return userService.selectId(user.getUser_email());//添加用户后，通过用户的邮箱查询数据返回给前端

    }

//    @PostMapping("/login")
//    public ResponseEntity<?> userLogin(@RequestBody User user) {
//        try {
//        User authenticatedUser = userService.userLogin(user);
//        Map<String, Object> response = new HashMap<>();
//        if (authenticatedUser != null) {
//// 登录成功
//            response.put("status", "success");
//            response.put("user", authenticatedUser);
//            return ResponseEntity.ok(response);
//            } else {
//// 登录失败
//            response.put("status", "fail");
//            response.put("message", "用户名或密码错误");
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
//        }
//    } catch (Exception e) {
//        Map<String, String> errorResponse = new HashMap<>();
//        errorResponse.put("status", "error");
//        errorResponse.put("message", "服务器错误");
//        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
//    }
//}
    @PostMapping("/login")
    public ResponseEntity<?> userLogin(@RequestBody User user) {
        try {
            User authenticatedUser = userService.userLogin(user);
            Map<String, Object> response = new HashMap<String, Object>();
            if (authenticatedUser != null) {
    // 登录成功
                response.put("status", "success");
                response.put("user", authenticatedUser);
                return ResponseEntity.ok(response);
            } else {
    // 登录失败
                response.put("status", "fail");
                response.put("message", "用户名或密码错误");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<String, String>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "服务器错误");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    @GetMapping("/getUserName")
    public ResponseEntity<String> getUserName(@RequestParam String user_email) {
        // 在UserService中编写相应的逻辑来查询user_name
        String user_name = userService.getUserNameByEmail(user_email);
        if (user_name != null) {
            return ResponseEntity.ok(user_name);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @PostMapping("/reviseUser")
    boolean reviseUser(@RequestBody User user){
        return userService.reviseUser(user);
    }
    @GetMapping("/selectUser")
    User selectUser(@RequestParam("id") int id){
        return userService.selectUser(id);
    }
}
