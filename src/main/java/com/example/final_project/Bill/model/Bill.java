package com.example.final_project.Bill.model;

import java.sql.Timestamp;

public class Bill {
    private int billId;
    private int accountNo;
    private int userId;
    private Timestamp billDate;
    private double totalAmount;
    private double discount;
    private double tax;
    private double paidAmount;
    private String paymentMethod;
    private String status;
    private String remarks;

    public Bill() {
    }

    public Bill(int billId, int accountNo, int userId, Timestamp billDate, double totalAmount, double discount, double tax, double paidAmount, String paymentMethod, String status, String remarks) {
        this.billId = billId;
        this.accountNo = accountNo;
        this.userId = userId;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
        this.discount = discount;
        this.tax = tax;
        this.paidAmount = paidAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.remarks = remarks;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(int accountNo) {
        this.accountNo = accountNo;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getBillDate() {
        return billDate;
    }

    public void setBillDate(Timestamp billDate) {
        this.billDate = billDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
    }

    public double getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(double paidAmount) {
        this.paidAmount = paidAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Override
    public String toString() {
        return "Bill{" + "billId=" + billId + ", accountNo=" + accountNo + ", userId=" + userId + ", billDate=" + billDate + ", totalAmount=" + totalAmount + ", discount=" + discount + ", tax=" + tax + ", paidAmount=" + paidAmount + ", paymentMethod=" + paymentMethod + ", status=" + status + ", remarks=" + remarks + '}';
    }
}
