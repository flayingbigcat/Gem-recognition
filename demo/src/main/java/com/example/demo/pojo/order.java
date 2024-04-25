package com.example.demo.pojo;

import java.util.Date;

public class order {
    private int order_Id;
    private Date order_Date;
    private int order_Items;
    private double order_Price;
    private String order_Status;

    public order() {
    }

    public order(int order_Id, Date order_Date, int order_Items, double order_Price, String order_Status) {
        this.order_Id = order_Id;
        this.order_Date = order_Date;
        this.order_Items = order_Items;
        this.order_Price = order_Price;
        this.order_Status = order_Status;
    }

    public int getOrder_Id() {
        return order_Id;
    }

    public Date getOrder_Date() {
        return order_Date;
    }

    public int getOrder_Items() {
        return order_Items;
    }

    public double getOrder_Price() {
        return order_Price;
    }

    public String getOrder_Status() {
        return order_Status;
    }

    public void setOrder_Id(int order_Id) {
        this.order_Id = order_Id;
    }

    public void setOrder_Date(Date order_Date) {
        this.order_Date = order_Date;
    }

    public void setOrder_Items(int order_Items) {
        this.order_Items = order_Items;
    }

    public void setOrder_Price(double orderPrice) {
        this.order_Price = orderPrice;
    }

    public void setOrder_Status(String orderStatus) {
        this.order_Status = orderStatus;
    }

    @Override
    public String toString() {
        return "order{" +
                "order_Id=" + order_Id +
                ", order_Date=" + order_Date +
                ", order_Items='" + order_Items + '\'' +
                ", orderPrice=" + order_Price +
                ", orderStatus='" + order_Status + '\'' +
                '}';
    }
}
