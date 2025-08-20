package com.example.final_project.customer.service;

import com.example.final_project.customer.dto.CustomerDto;

import java.util.ArrayList;
import java.util.List;

/**
 * Service class for managing customers.
 * Currently returns sample data; can be extended to use a real database.
 */
public class CustomerService {

    /**
     * Returns a list of sample customers for testing.
     *
     * @return List of CustomerDto objects
     */
    public List<CustomerDto> getAllCustomers() {
        List<CustomerDto> customers = new ArrayList<>();

        // Sample data
        customers.add(new CustomerDto(1, "John Doe", "123 Main Street", "+94 71 234 5678", "CUST-001"));
        customers.add(new CustomerDto(2, "Jane Smith", "456 High Street", "+94 77 987 6543", "CUST-002"));
        customers.add(new CustomerDto(3, "Alice Brown", "789 Low Street", "+94 70 555 1234", "CUST-003"));

        return customers;
    }

    /*
     * TODO: Implement real DB method later
     *
     * public List<CustomerDto> getAllCustomersFromDB() {
     *     List<CustomerDto> customers = new ArrayList<>();
     *     try (Connection conn = DBConnection.getInstance().getConnection();
     *          Statement stmt = conn.createStatement();
     *          ResultSet rs = stmt.executeQuery("SELECT * FROM customers")) {
     *
     *         while (rs.next()) {
     *             CustomerDto customer = new CustomerDto();
     *             customer.setId(rs.getInt("customer_id"));
     *             customer.setName(rs.getString("name"));
     *             customer.setAddress(rs.getString("address"));
     *             customer.setPhone(rs.getString("phone"));
     *             customer.setCode(rs.getString("code"));
     *             customers.add(customer);
     *         }
     *
     *     } catch (Exception e) {
     *         e.printStackTrace();
     *     }
     *     return customers;
     * }
     */
}
