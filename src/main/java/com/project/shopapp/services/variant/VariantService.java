package com.project.shopapp.services.variant;

import com.project.shopapp.dtos.ProductVariantDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductVariant;
import com.project.shopapp.repositories.ProductVariantRepository;
import com.project.shopapp.services.product.ProductService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class VariantService implements IVariantService {
    private final ProductVariantRepository productVariantRepository;
    private final ProductService productService;

    @Override
    public ProductVariant create(ProductVariantDTO productVariantDTO) throws DataNotFoundException {
        Product product = productService.getProduct(productVariantDTO.getProductId());
        ModelMapper modelMapper = new ModelMapper();
        modelMapper.typeMap(ProductVariantDTO.class, ProductVariant.class).addMappings(mapper -> mapper.skip(ProductVariant::setId));
        ProductVariant productVariant = new ProductVariant();
        modelMapper.map(productVariantDTO, productVariant);
        return productVariantRepository.save(productVariant);
    }
}
