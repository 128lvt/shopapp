package com.project.shopapp.responses;

import com.project.shopapp.models.Product;
import jakarta.persistence.MappedSuperclass;
import lombok.*;

import java.util.List;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@MappedSuperclass
@Builder
public class ProductResponse {
    private List<Product> products;
    private int totalPages;
}
