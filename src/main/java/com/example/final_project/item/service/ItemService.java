package com.example.final_project.item.service;

import com.example.final_project.item.dto.ItemDto;
import java.util.ArrayList;
import java.util.List;

public class ItemService {
    public List<ItemDto> getAllItems() {
        List<ItemDto> items = new ArrayList<>();
        items.add(new ItemDto(1, "Pen", 20.0, 50));
        items.add(new ItemDto(2, "Book", 100.0, 30));
        return items;
    }
}
