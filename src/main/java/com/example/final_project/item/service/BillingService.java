/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.final_project.item.service;



import com.example.final_project.Bill.Impl.BillImpl;
import com.example.final_project.Bill.Impl.BillItemImpl;
import com.example.final_project.Bill.model.Bill;
import com.example.final_project.Bill.model.Billitem;
import com.example.final_project.Bill.observer.BillObsever;
import com.example.final_project.common.Factory.DAOFactory;
import com.example.final_project.customer.dao.impl.CustomerImpl;
import com.example.final_project.customer.dto.CustomerDto;


import java.util.ArrayList;
import java.util.List;

public class BillingService {

    private BillImpl billDAO = DAOFactory.getBillDAO();
    private BillItemImpl billItemDAO = DAOFactory.getBillItemDAO();
    private CustomerImpl customerDAO = DAOFactory.getCustomerDAO();
    private List<BillObsever> observers = new ArrayList<>();

    public void addObserver(BillObsever observer) {
        observers.add(observer);
    }

    public int createBillWithItems(Bill bill, List<Billitem> items) {
        int billId = billDAO.insertBill(bill);
        if (billId > 0) {
            for (Billitem item : items) {
                item.setBillId(billId);
                billItemDAO.insertBillItem(item);
            }
            bill.setBillId(billId);

            // Fetch customer email from DB

            CustomerDto customer = customerDAO.getCustomerByAccountNo(bill.getAccountNo());
            String customerEmail = (customer != null) ? customer.getPhone() : null;

            // Notify all observers

            for (BillObsever observer : observers) {
                observer.onBillCreated(bill, customerEmail);
            }
        }
        return billId;
    }
}
