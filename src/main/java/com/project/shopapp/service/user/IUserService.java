package com.project.shopapp.service.user;

import com.project.shopapp.dto.UserDTO;
import com.project.shopapp.exception.DataNotFoundException;
import com.project.shopapp.model.User;

public interface IUserService {
    User createUser(UserDTO userDTO) throws Exception;

    Object login(String phoneNumber, String password) throws DataNotFoundException;
}
