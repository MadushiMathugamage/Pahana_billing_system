package com.example.final_project.common.base;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface CrudService <T extends SuperDto> extends SuperService{
    boolean add(T dto) throws SQLException, ClassNotFoundException;


    List<T> getAll(Map<String, String> searchParams) throws SQLException, ClassNotFoundException;

    boolean update(T dto) throws SQLException, ClassNotFoundException;
    T searchById(Object... args) throws SQLException, ClassNotFoundException;
    boolean delete(Object... args) throws SQLException, ClassNotFoundException;

}
