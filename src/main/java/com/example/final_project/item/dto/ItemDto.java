package com.example.final_project.item.dto;

public class ItemDto {
    private int item_id;
    private String item_name;
    private double price_per_unit;



    public ItemDto(int item_id, String item_name, double price_per_unit) {
        this.item_id = item_id;
        this.item_name = item_name;
        this.price_per_unit = price_per_unit;
    }

    public ItemDto() {

    }

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public String getItem_name() {
        return item_name;
    }

    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    public double getPrice_per_unit() {
        return price_per_unit;
    }

    public void setPrice_per_unit(double price_per_unit) {
        this.price_per_unit = price_per_unit;
    }
}
