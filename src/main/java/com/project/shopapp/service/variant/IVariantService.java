package com.project.shopapp.service.variant;

import com.project.shopapp.dto.ProductVariantDTO;
import com.project.shopapp.exception.DataNotFoundException;
import com.project.shopapp.model.ProductVariant;

public interface IVariantService {
    public ProductVariant create(ProductVariantDTO productVariantDTO) throws DataNotFoundException;
}
