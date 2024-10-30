package com.project.shopapp.services.variant;

import com.project.shopapp.dtos.ProductVariantDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.ProductVariant;

public interface IVariantService {
    public ProductVariant create(ProductVariantDTO productVariantDTO) throws DataNotFoundException;
}
