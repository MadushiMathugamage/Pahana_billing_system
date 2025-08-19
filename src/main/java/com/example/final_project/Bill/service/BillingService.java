package com.example.final_project.Bill.service;

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

    // Use interface types if DAOFactory returns interfaces
    private BillImpl billDAO = DAOFactory.getBillDAO();
    private BillItemImpl billItemDAO = DAOFactory.getBillItemDAO();
    private CustomerImpl customerDAO = DAOFactory.getCustomerDAO();

    private List<BillObsever> observers = new ArrayList<>();

    // Add an observer
    public void addObserver(BillObsever observer) {
        observers.add(observer);
    }

    // Create a bill with items
    public int createBillWithItems(Bill bill, List<Billitem> items) {
        if (bill == null || items == null || items.isEmpty()) {
            throw new IllegalArgumentException("Bill or items cannot be null/empty");
        }

        // Insert bill
        int billId = billDAO.insertBill(bill);

        if (billId > 0) {
            // Insert bill items
            for (Billitem item : items) {
                item.setBillId(billId);
                billItemDAO.insertBillItem(item);
            }

            bill.setBillId(billId);

            // Fetch customer email
            CustomerDto customer = customerDAO.getCustomerByAccountNo(bill.getAccountNo());
            String customerEmail = (customer != null) ? customer.getTelephone() : null;

            // Notify observers
            for (BillObsever observer : observers) {
                observer.onBillCreated(bill, customerEmail);
            }
        }

        return billId;
    }
}
