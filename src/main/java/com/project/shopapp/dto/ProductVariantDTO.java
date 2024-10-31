package com.project.shopapp.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class ProductVariantDTO {
    @JsonProperty("product_id")
    private Long productId;

    private String color;

    private String size;

    private int stock;
}
