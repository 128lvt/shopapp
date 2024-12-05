package com.project.shopapp.controller;

import com.project.shopapp.dto.ForgotPasswordDTO;
import com.project.shopapp.dto.UserDTO;
import com.project.shopapp.dto.UserLoginDTO;
import com.project.shopapp.exception.DataNotFoundException;
import com.project.shopapp.model.Token;
import com.project.shopapp.model.User;
import com.project.shopapp.response.Response;
import com.project.shopapp.service.user.EmailService;
import com.project.shopapp.service.user.TokenService;
import com.project.shopapp.service.user.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@RestController
@RequestMapping("${api.prefix}/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final TokenService tokenService;
    private final EmailService emailService;

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
            Object response = userService.login(userLoginDTO.getEmail(), userLoginDTO.getPassword());
            return ResponseEntity.ok().body(Response.success(response));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Response.error(e.getMessage()));
        }
    }

    @GetMapping("/token")
    public ResponseEntity<?> generateToken(@Valid @RequestParam String email) {
        try {
            if (tokenService.findByUserEmail(email) != null) {
                return ResponseEntity.badRequest().body(Response.success("Token đã được gửi đến email của bạn, vui lòng không SPAM"));
            }
            User user = userService.findByEmail(email);
            String token = tokenService.createToken(user);
            return ResponseEntity.ok().body(Response.success("Token đã được gửi qua email. "));
        } catch (DataNotFoundException e) {
            return ResponseEntity.badRequest().body(Response.error("Email không tồn tại. "));
        }
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<?> getToken(@Valid @RequestBody ForgotPasswordDTO forgotPasswordDTO) throws DataNotFoundException {
        if (!Objects.equals(forgotPasswordDTO.getPassword(), forgotPasswordDTO.getRetypePassword())) {
            return ResponseEntity.badRequest().body("Password does not match");
        }
        try {
            Token existingToken = tokenService.findByToken(forgotPasswordDTO.getToken());
            boolean isTokenValid = tokenService.isTokenValid(forgotPasswordDTO.getToken());
            if (existingToken != null && isTokenValid) {
                User user = existingToken.getUser();
                if (forgotPasswordDTO.getEmail().equals(user.getEmail())) {
                    userService.setPassword(forgotPasswordDTO.getEmail(), forgotPasswordDTO.getPassword());
                    tokenService.delete(existingToken);
                    return ResponseEntity.ok().body(Response.success("Xác nhận mật khẩu thành công. "));
                }
            }
            return ResponseEntity.badRequest().body(Response.error("Token không hợp lệ. "));
        } catch (DataNotFoundException e) {
            return ResponseEntity.badRequest().body(Response.error(e.getMessage()));
        }
    }

    @GetMapping("/test-email")
    public String testEmail() {
        emailService.sendTestEmail();
        return "Test email sent!";
    }
}
