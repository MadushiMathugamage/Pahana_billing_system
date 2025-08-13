package com.example.final_project.users.dao.Impl;

import com.example.final_project.users.dao.UserDao;
import com.example.final_project.users.entity.UserEntity;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;

public class UserImpl implements UserDao {
    private static final Logger loger = Logger.getLogger(UserDao);

    public boolean add(Connection connection, UserEntity userEntity) throws SQLException, ClassNotFoundException {
        return DAOUt
    }
}
