package com.example.final_project.users.entity;

import com.example.final_project.common.base.SuperEntity;
import com.example.final_project.common.basic.Role;

public class UserEntity implements SuperEntity {
    private int user_id;
    private String username;
    private String password;
    private Role role;

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
