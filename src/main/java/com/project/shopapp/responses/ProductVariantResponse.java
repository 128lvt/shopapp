package com.project.shopapp.responses;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductVariantResponse {
    private Long id;
    private String size;
    private String color;
    private Integer stock;
}
