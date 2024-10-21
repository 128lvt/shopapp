package com.project.shopapp.services.product_variant;

import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductVariant;
import org.springframework.stereotype.Service;

import java.util.List;

public interface IProductVariantService {
    public List<Product> findAll();
}
