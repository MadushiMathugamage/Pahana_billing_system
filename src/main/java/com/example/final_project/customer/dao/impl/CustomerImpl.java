package com.example.final_project.customer.dao.impl;

import com.example.final_project.common.basic.DBConnection;
import com.example.final_project.customer.dto.CustomerDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerImpl {
    public CustomerDto getCustomerByAccountNo(int accountNo) {
        CustomerDto customerDto = null;
        String sql = "SELECT * FROM customers WHERE account_no = ?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customerDto = extractCustomer(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerDto;
    }

    // Add a new customer

    public boolean insertCustomer(CustomerDto customerDto) {
        String sql = "INSERT INTO customers (id, account_number, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerDto.getCustomer_id());
            ps.setString(2, customerDto.getAccount_number());
            ps.setString(3, customerDto.getName());
            ps.setString(4, customerDto.getAddress());
            ps.setString(5, customerDto.getTelephone());
            ps.setInt(6, customerDto.getUnits_consumed());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCustomer(CustomerDto customerDto) {
        String sql = "UPDATE customers SET id=?, account_number=?, name=?, address=?, telephone=?, units_consumed=? WHERE account_number=?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerDto.getCustomer_id());
            ps.setString(2, customerDto.getAccount_number());
            ps.setString(3, customerDto.getName());
            ps.setString(4, customerDto.getAddress());
            ps.setString(5, customerDto.getTelephone());
            ps.setInt(6, customerDto.getUnits_consumed());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete customer

    public boolean deleteCustomer(int accountNo) {
        String sql = "DELETE FROM customers WHERE account_no=?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountNo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<CustomerDto> getAllCustomers() {
        List<CustomerDto> list = new ArrayList<>();
        String sql = "SELECT * FROM customers";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractCustomer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private CustomerDto extractCustomer(ResultSet rs) throws SQLException {
        CustomerDto customerDto = new CustomerDto();
        customerDto.setCustomer_id(rs.getInt("account_no"));
        customerDto.setAccount_number(rs.getString("name"));
        customerDto.setName(rs.getString("address"));
        customerDto.setAddress(rs.getString("phone"));
        customerDto.setTelephone(rs.getString("email"));
        customerDto.setUnits_consumed(rs.getInt("units_consumed"));

        return customerDto;
    }


}
