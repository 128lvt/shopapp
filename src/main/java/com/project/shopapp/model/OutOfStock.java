package com.project.shopapp.model;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class OutOfStock {
    private Product product;
    private ProductVariant productVariant;

    public static OutOfStock getOutOfStock(Product product, ProductVariant productVariant) {
        return OutOfStock
                .builder()
                .product(product)
                .productVariant(productVariant)
                .build();
    }
}
