package com.example.final_project.Bill.Impl;

import com.example.final_project.Bill.model.Bill;
import com.example.final_project.common.basic.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillImpl {
    public Bill getBillById(int billId) {
        Bill bill = null;
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, billId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bill = extractBill(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bill;
    }

    // Insert new bill

    public int insertBill(Bill bill) {
        String sql = "INSERT INTO bills (account_no, user_id, bill_date, total_amount, discount, tax, paid_amount, payment_method, status, remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bill.getAccountNo());
            ps.setInt(2, bill.getUserId());
            ps.setTimestamp(3, bill.getBillDate());
            ps.setDouble(4, bill.getTotalAmount());
            ps.setDouble(5, bill.getDiscount());
            ps.setDouble(6, bill.getTax());
            ps.setDouble(7, bill.getPaidAmount());
            ps.setString(8, bill.getPaymentMethod());
            ps.setString(9, bill.getStatus());
            ps.setString(10, bill.getRemarks());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Inserting bill failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // indicate error
    }

    // Update bill (if needed)

    public boolean updateBill(Bill bill) {
        String sql = "UPDATE bills SET account_no=?, user_id=?, bill_date=?, total_amount=?, discount=?, tax=?, paid_amount=?, payment_method=?, status=?, remarks=? WHERE bill_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bill.getAccountNo());
            ps.setInt(2, bill.getUserId());
            ps.setTimestamp(3, bill.getBillDate());
            ps.setDouble(4, bill.getTotalAmount());
            ps.setDouble(5, bill.getDiscount());
            ps.setDouble(6, bill.getTax());
            ps.setDouble(7, bill.getPaidAmount());
            ps.setString(8, bill.getPaymentMethod());
            ps.setString(9, bill.getStatus());
            ps.setString(10, bill.getRemarks());
            ps.setInt(11, bill.getBillId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete bill (rare, but possible)

    public boolean deleteBill(int billId) {
        String sql = "DELETE FROM bills WHERE bill_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, billId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // List all bills

    public List<Bill> getAllBills() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT * FROM bills";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractBill(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Bill> getBillsFiltered(java.sql.Date fromDate, java.sql.Date toDate, Integer customerAccountNo) {
        List<Bill> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM bills WHERE 1=1");
        if (fromDate != null) {
            sql.append(" AND bill_date >= ?");
        }
        if (toDate != null) {
            sql.append(" AND bill_date <= ?");
        }
        if (customerAccountNo != null) {
            sql.append(" AND account_no = ?");
        }
        sql.append(" ORDER BY bill_date DESC");
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (fromDate != null) {
                ps.setDate(idx++, fromDate);
            }
            if (toDate != null) {
                ps.setDate(idx++, toDate);
            }
            if (customerAccountNo != null) {
                ps.setInt(idx++, customerAccountNo);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractBill(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper: extract Bill from ResultSet

    private Bill extractBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setAccountNo(rs.getInt("account_no"));
        bill.setUserId(rs.getInt("user_id"));
        bill.setBillDate(rs.getTimestamp("bill_date"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setDiscount(rs.getDouble("discount"));
        bill.setTax(rs.getDouble("tax"));
        bill.setPaidAmount(rs.getDouble("paid_amount"));
        bill.setPaymentMethod(rs.getString("payment_method"));
        bill.setStatus(rs.getString("status"));
        bill.setRemarks(rs.getString("remarks"));
        return bill;
    }
}
