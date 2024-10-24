package com.project.shopapp.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;


@Entity
@Table(name = "users")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
public class User extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "fullname", length = 100)
    private String fullName;

    @Column(name = "phone_number", length = 10, nullable = false)
    private String phoneNumber;

    @Column(name = "address", length = 200)
    private String address;

    @Column(name = "password", length = 200, nullable = false)
    private String password;

    @Column(name = "is_active")
    private Boolean active;

    @Column(name = "date_of_birth")
    private Date dateOfBirth;

    @Column(name = "facebook_account_id", length = 50)
    private String facebookAccountId;

    @Column(name = "google_account_id", length = 50)
    private String googleAccountId;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;
}
