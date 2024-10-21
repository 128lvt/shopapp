package com.project.shopapp.services.product_variant;

import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductVariant;
import com.project.shopapp.repositories.ProductVariantRepository;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductVariantService implements IProductVariantService {
    private final ProductVariantRepository productVariantRepository;

    @Override
    public List<Product> findAll() {
        return productVariantRepository.findAll();
    }
}
