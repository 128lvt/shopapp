package com.project.shopapp.response;

import com.project.shopapp.model.Product;
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
