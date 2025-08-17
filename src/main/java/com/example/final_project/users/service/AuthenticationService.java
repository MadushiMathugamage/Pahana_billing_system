package com.example.final_project.users.service;

import com.example.final_project.common.Factory.DAOFactory;
import com.example.final_project.users.dao.Impl.UserImpl;
import com.example.final_project.users.dao.UserDao;
import com.example.final_project.users.dto.UserDto;

public class AuthenticationService {
    private UserImpl userImpl = DAOFactory.getUserDAO();

    public UserDto authenticate(String username, String password) {
        UserDto user = userImpl.getUserByUsername(username);

        return null;
    }
}
