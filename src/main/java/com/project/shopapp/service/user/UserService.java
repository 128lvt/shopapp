package com.project.shopapp.service.user;

import com.project.shopapp.component.JwtTokenUtil;
import com.project.shopapp.dto.UserDTO;
import com.project.shopapp.exception.DataNotFoundException;
import com.project.shopapp.exception.PermissionDenyException;
import com.project.shopapp.model.Role;
import com.project.shopapp.model.User;
import com.project.shopapp.repository.RoleRepository;
import com.project.shopapp.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenUtil jwtTokenUtil;
    private final AuthenticationManager authenticationManager;

    @Override
    public User createUser(UserDTO userDTO) throws Exception {
        String phoneNUmber = userDTO.getPhoneNumber();
        //Kiểm tra số điện thoại đ ồn tại hay chưa
        if (userRepository.findByPhoneNumber(phoneNUmber).isPresent()) {
            throw new DataIntegrityViolationException("Phone number already exists");
        }
        Role role = roleRepository.findById(userDTO.getRoleId()).orElseThrow(() -> new DataNotFoundException("Role not found"));
        if (role.getName().toUpperCase().equals(Role.ADMIN)) {
            throw new PermissionDenyException("You can't register an ADMIN account");
        }
        //Convert UserDTO -> User
        User user = User.builder()
                .fullName(userDTO.getFullName())
                .phoneNumber(userDTO.getPhoneNumber())
                .password(userDTO.getPassword())
                .address(userDTO.getAddress())
                .facebookAccountId(userDTO.getFacebookAccountId())
                .googleAccountId(userDTO.getGoogleAccountId())
                .build();

        user.setRole(role);
        //Kiểm tra đăng nhập bằng facebook và google
        if (userDTO.getFacebookAccountId() == null && userDTO.getGoogleAccountId() == null) {
            String password = userDTO.getPassword();
            String encodePassword = passwordEncoder.encode(password);
            user.setPassword(encodePassword);
        }
        user.setActive(true);
        return userRepository.save(user);
    }

    @Override
    public Object login(String phoneNumber, String password) throws DataNotFoundException {
        User user = userRepository.findByPhoneNumber(phoneNumber).orElseThrow(() -> new DataNotFoundException("User not found"));

        if (user.getFacebookAccountId() == null && user.getGoogleAccountId() == null) {
            if (!passwordEncoder.matches(password, user.getPassword())) {
                throw new BadCredentialsException("Incorrect password");
            }
        }

        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(phoneNumber, password, user.getAuthorities()));

        Map<String, Object> response = new HashMap<>();
        response.put("token", jwtTokenUtil.generateToken(user));
        response.put("user", user);

        return response;
    }
}
