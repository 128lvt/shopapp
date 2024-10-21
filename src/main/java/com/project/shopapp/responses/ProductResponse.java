package com.project.shopapp.responses;

import jakarta.persistence.Column;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductResponse extends BaseResponse {
    @Column(name = "product_id")
    private Long id;
    @Column(name = "product_name")
    private String name;
    private Float price;
    private String thumbnail;
    private String description;
    private List<ProductVariantResponse> variants;
}
