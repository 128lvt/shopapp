package com.project.shopapp.services.user;

import com.project.shopapp.dtos.UserDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import org.springframework.stereotype.Service;

public interface IUserService {
    void createUser(UserDTO userDTO) throws DataNotFoundException;

    String login(String phoneNumber, String password);
}
