package com.example.final_project.customer.dto;

import com.example.final_project.common.base.SuperDto;

public class CustomerDto implements SuperDto {
    private int customer_id;
    private String account_number;
    private String name;
    private String address;
    private String telephone;
    private int units_consumed;

    public CustomerDto(int customer_id, String account_number, String name, String address, String telephone, int units_consumed) {
        this.customer_id = customer_id;
        this.account_number = account_number;
        this.name = name;
        this.address = address;
        this.telephone = telephone;
        this.units_consumed = units_consumed;
    }

    public CustomerDto() {

    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getAccount_number() {
        return account_number;
    }

    public void setAccount_number(String account_number) {
        this.account_number = account_number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public int getUnits_consumed() {
        return units_consumed;
    }

    public void setUnits_consumed(int units_consumed) {
        this.units_consumed = units_consumed;
    }
}
