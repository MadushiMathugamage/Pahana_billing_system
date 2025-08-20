package com.example.final_project.customer.dto;

public class CustomerDto {
    private int id;
    private String name;
    private String address;
    private String Telephone;
    private String code;

    // Constructor
    public CustomerDto(int id, String name, String address, String phone, String code) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.Telephone = phone;
        this.code = code;
    }

    public CustomerDto() {

    }


    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getAddress() { return address; }
    public String getPhone() { return Telephone; }
    public String getCode() { return code; }

    // Setters (optional)
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setAddress(String address) { this.address = address; }
    public void setPhone(String phone) { this.Telephone = phone; }
    public void setCode(String code) { this.code = code; }
}
