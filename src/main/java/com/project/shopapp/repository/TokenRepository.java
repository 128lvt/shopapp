package com.project.shopapp.repository;

import com.project.shopapp.model.Token;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;

@RequestMapping
public interface TokenRepository extends JpaRepository<Token, Long> {
    Token findByToken(String token);

    Token findByUserEmail(String email);

    void deleteByExpirationDateBefore(LocalDateTime date);
}
