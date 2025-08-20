package com.example.final_project.item.dao.impl;

import com.example.final_project.common.basic.DBConnection;
import com.example.final_project.item.dto.ItemDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemImpl {

    // Get item by ID
    public ItemDto getItemById(int itemId) {
        ItemDto itemDto = null;
        String sql = "SELECT * FROM items WHERE item_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                itemDto = extractItem(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemDto;
    }

    // Insert item
    public boolean insertItem(ItemDto itemDto) {
        String sql = "INSERT INTO items (item_name, item_price, item_stock) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemDto.getName());      // item_name
            ps.setDouble(2, itemDto.getPrice());     // item_price
            ps.setInt(3, itemDto.getStock());        // item_stock

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update item
    public boolean updateItem(int itemId, ItemDto itemDto) {
        String sql = "UPDATE items SET item_name=?, item_price=?, item_stock=? WHERE item_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemDto.getName());
            ps.setDouble(2, itemDto.getPrice());
            ps.setInt(3, itemDto.getStock());
            ps.setInt(4, itemId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete item
    public boolean deleteItem(int itemId) {
        String sql = "DELETE FROM items WHERE item_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all items
    public List<ItemDto> getAllItems() {
        List<ItemDto> items = new ArrayList<>();
        String sql = "SELECT * FROM items";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                items.add(extractItem(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    // Extract ItemDto from ResultSet
    private ItemDto extractItem(ResultSet rs) throws SQLException {
        ItemDto itemDto = new ItemDto();
        itemDto.setName(rs.getString("item_name"));       // String
        itemDto.setPrice(rs.getDouble("item_price"));     // double
        itemDto.setStock(rs.getInt("item_stock"));        // int
        return itemDto;
    }
}
