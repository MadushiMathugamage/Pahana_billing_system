package com.example.final_project.common.Factory;

import com.example.final_project.Bill.Impl.BillImpl;
import com.example.final_project.Bill.Impl.BillItemImpl;
import com.example.final_project.customer.dao.impl.CustomerImpl;
import com.example.final_project.item.dao.impl.ItemImpl;
import com.example.final_project.users.dao.Impl.UserImpl;

public class DAOFactory {
    public static CustomerImpl getCustomerDAO() {
        return new CustomerImpl();
    }

    public static ItemImpl getItemDAO() {
        return new ItemImpl();
    }

    public static BillImpl getBillDAO() {
        return new BillImpl();
    }

    public static BillItemImpl getBillItemDAO() {
        return new BillItemImpl();
    }

    public static UserImpl getUserDAO() {
        return new UserImpl();
    }
}
