package com.example.final_project.Bill.observer;

import com.example.final_project.Bill.model.Bill;

public interface BillObsever {
    void onBillCreated(Bill bill, String customerEmail);

}
