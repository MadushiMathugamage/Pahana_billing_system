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
        ItemDto ItemDto = null;
        String sql = "SELECT * FROM items WHERE item_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ItemDto = extractItem(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ItemDto;
    }

    public boolean insertItem(ItemDto itemDto) {
        String sql = "INSERT INTO items (item_id, item_name, price_per_unit) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemDto.getItem_id()); // Assuming item_id is int
            ps.setString(2, itemDto.getItem_name());
            ps.setDouble(3, itemDto.getPrice_per_unit());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean updateItem(ItemDto itemDto) {
        String sql = "UPDATE items SET item_id=?, item_name=?, price_per_unit=?, stock=? WHERE item_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemDto.getItem_id()); // Assuming item_id is int
            ps.setString(2, itemDto.getItem_name());
            ps.setDouble(3, itemDto.getPrice_per_unit());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete item

    public boolean deleteItem(int itemId) {
        String sql = "DELETE FROM items WHERE item_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ItemDto> getAllItems() {
        List<ItemDto> items = new ArrayList<>();
        String sql = "SELECT * FROM items";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                items.add(extractItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    private ItemDto extractItem(ResultSet rs) throws SQLException {
        ItemDto itemDto = new ItemDto();
        itemDto.setItem_id(rs.getInt("item_id"));
        itemDto.setItem_name(rs.getString("item_name"));
        itemDto.setPrice_per_unit(rs.getDouble("price_per_unit"));
        return itemDto;
    }






}
