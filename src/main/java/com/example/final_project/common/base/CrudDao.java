package com.example.final_project.common.base;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface CrudDao<T extends SuperEntity> extends SuperDao{
    boolean add(Connection connection, T entity) throws SQLException, ClassNotFoundException;

    List<T> getAll(Connection connection, Map<String, String> searchParams) throws SQLException, ClassNotFoundException;

    boolean update(Connection connection, T entity) throws SQLException, ClassNotFoundException;

    boolean delete(Connection connection, Object... args) throws SQLException, ClassNotFoundException;

    T searchById(Connection connection, Object... args) throws SQLException, ClassNotFoundException;


}
