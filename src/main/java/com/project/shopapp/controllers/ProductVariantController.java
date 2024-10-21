package com.project.shopapp.controllers;

import com.project.shopapp.services.product_variant.ProductVariantService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/product-variants")
@RequiredArgsConstructor
public class ProductVariantController {
    private final ProductVariantService productVariantService;

    @GetMapping
    public ResponseEntity<?> getAllProductVariants() {
        return ResponseEntity.ok(productVariantService.findAll());
    }
}
