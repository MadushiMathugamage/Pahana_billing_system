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

    // DAOs
    private final BillImpl billDAO = DAOFactory.getBillDAO();
    private final BillItemImpl billItemDAO = DAOFactory.getBillItemDAO();
    private final CustomerImpl customerDAO = DAOFactory.getCustomerDAO();

    private final List<BillObsever> observers = new ArrayList<>();

    // Add an observer
    public void addObserver(BillObsever observer) {
        if (observer != null) {
            observers.add(observer);
        }
    }

    /**
     * Create a bill and insert its items.
     * Notifies observers after creation.
     * @param bill Bill object (must not be null)
     * @param items List of Billitem objects (must not be null or empty)
     * @return generated billId or -1 if creation fails
     */
    public int createBillWithItems(Bill bill, List<Billitem> items) {
        if (bill == null || items == null || items.isEmpty()) {
            throw new IllegalArgumentException("Bill or items cannot be null/empty");
        }

        int billId = -1;

        try {
            // Insert bill
            billId = billDAO.insertBill(bill);

            if (billId > 0) {
                // Insert bill items
                for (Billitem item : items) {
                    item.setBillId(billId);
                    billItemDAO.insertBillItem(item);
                }

                bill.setBillId(billId);

                // Fetch customer info
                CustomerDto customer = customerDAO.getCustomerByAccountNo(bill.getAccountNo());
                String customerContact = (customer != null) ? customer.getName() : null;

                // Notify observers
                for (BillObsever observer : observers) {
                    observer.onBillCreated(bill, customerContact);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            billId = -1; // mark as failed
        }

        return billId;
    }
}
