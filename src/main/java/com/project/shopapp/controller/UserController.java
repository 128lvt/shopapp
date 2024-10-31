package com.project.shopapp.controller;

import com.project.shopapp.dto.UserDTO;
import com.project.shopapp.dto.UserLoginDTO;
import com.project.shopapp.response.Response;
import com.project.shopapp.service.user.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<?> createUser(@Valid @RequestBody UserDTO userDTO) {
        try {
            if (!userDTO.getPassword().equals(userDTO.getRetypePassword())) {
                return ResponseEntity.badRequest().body("Password does not match");
            }
            return ResponseEntity.ok().body(Response.success(userService.createUser(userDTO)));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Response.error(e.getMessage()));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody UserLoginDTO userLoginDTO) {
        //Kiểm tra thông tin đăng nhập và sinh token
        //Trả về token trong response
        try {
            String token = userService.login(userLoginDTO.getPhoneNumber(), userLoginDTO.getPassword());
            return ResponseEntity.ok().body(Response.success(token));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Response.error(e.getMessage()));
        }
    }
}
