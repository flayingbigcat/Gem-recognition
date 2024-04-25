package com.example.demo.pojo;

public class User {
    private int user_id;
    private String user_name;
    private String user_password;
    private String user_email;
    private String user_sex;
    private String user_address;
    private String user_phone;
    private String user_description;
    private String user_imageSrc;

    public User() {
    }

    public User(int user_id, String user_name, String user_password, String user_email, String user_sex, String user_address, String user_phone, String user_description, String user_imagesrc) {
        this.user_id = user_id;
        this.user_name = user_name;
        this.user_password = user_password;
        this.user_email = user_email;
        this.user_sex = user_sex;
        this.user_address = user_address;
        this.user_phone = user_phone;
        this.user_description = user_description;
        this.user_imageSrc = user_imageSrc;
    }

    @Override
    public String toString() {
        return "User{" +
                "user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", user_password='" + user_password + '\'' +
                ", user_email='" + user_email + '\'' +
                ", user_sex='" + user_sex + '\'' +
                ", user_address='" + user_address + '\'' +
                ", user_phone='" + user_phone + '\'' +
                ", user_description='" + user_description + '\'' +
                ", user_imageSrc='" + user_imageSrc + '\'' +
                '}';
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_password() {
        return user_password;
    }

    public void setUser_password(String user_password) {
        this.user_password = user_password;
    }

    public String getUser_email() {
        return user_email;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

    public String getUser_sex() {
        return user_sex;
    }

    public void setUser_sex(String user_sex) {
        this.user_sex = user_sex;
    }

    public String getUser_address() {
        return user_address;
    }

    public void setUser_address(String user_address) {
        this.user_address = user_address;
    }

    public String getUser_phone() {
        return user_phone;
    }

    public void setUser_phone(String user_phone) {
        this.user_phone = user_phone;
    }

    public String getUser_description() {
        return user_description;
    }

    public void setUser_description(String user_description) {
        this.user_description = user_description;
    }

    public String getUser_imageSrc() {
        return user_imageSrc;
    }

    public void setUser_imageSrc(String user_imageSrc) {
        this.user_imageSrc = user_imageSrc;
    }
}
