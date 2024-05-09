package com.example.demo.controller;


import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sun.misc.BASE64Encoder;
import com.example.demo.pojo.ResponseVo;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;


@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/file")
public class FileController {
//    @GetMapping("/image")
//    public ResponseVo<String> image() throws IOException {
//        String path = "D:\\yxz\\yuzai_web\\WebGIS-Based-Second-Hand-Car-Trading-Website\\demo\\src\\Image\\1.jpg";
//        return ResponseVo.success(getImage(path));
//    }
//
//    private String getImage(String path) throws IOException {
//
//        //读取图片变成字节数组
//        FileInputStream fileInputStream = new FileInputStream(path);
//
//        ByteArrayOutputStream bos = new ByteArrayOutputStream();
//        byte[] b = new byte[1024];
//        int len = -1;
//        while((len = fileInputStream.read(b)) != -1) {
//            bos.write(b, 0, len);
//        }
//        byte[] fileByte = bos.toByteArray();
//
//        //进行base64编码
//        BASE64Encoder encoder = new BASE64Encoder();
//        String data = encoder.encode(fileByte);
//
//        return data;
//    }

    @GetMapping("/images")
    public ResponseVo<List<String>> images() {
        String directoryPath = "D:\\yxz\\yuzai_web\\Gem-recognition\\demo\\src\\CrouselImage";
        try {
            List<String> imageBase64List = getAllImagesAsBase64(directoryPath);
            return ResponseVo.success(imageBase64List);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseVo.error("Error reading image files");
        }
    }

    @GetMapping("/Product_images")
    public ResponseVo<List<String>> product_images() {
        String directoryPath = "D:\\yxz\\yuzai_web\\Gem-recognition\\demo\\src\\Productimages";
        try {
            List<String> imageBase64List = getAllImagesAsBase64(directoryPath);
            return ResponseVo.success(imageBase64List);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseVo.error("Error reading image files");
        }
    }

    @GetMapping("/Gem_img")
    public ResponseVo<List<String>> Gme_img() {
        String directoryPath = "D:\\yxz\\yuzai_web\\Gem-recognition\\demo\\src\\Gem_img";
        try {
            List<String> imageBase64List = getAllImagesAsBase64(directoryPath);
            return ResponseVo.success(imageBase64List);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseVo.error("Error reading image files");
        }
    }

    private List<String> getAllImagesAsBase64(String directoryPath) throws IOException {
        List<String> imageBase64List = new ArrayList<>();
        // 获取指定目录下的所有图片文件
        Path dirPath = Paths.get(directoryPath);
        Files.list(dirPath)
                .filter(Files::isRegularFile)
                .filter(path -> path.toString().toLowerCase().endsWith(".jpg") || path.toString().toLowerCase().endsWith(".png")) // 可根据需要添加其他格式的图片
                .forEach(imagePath -> {
                    try {
                        byte[] imageBytes = Files.readAllBytes(imagePath);
                        String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                        imageBase64List.add(imageBase64);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });
        return imageBase64List;
    }
}
