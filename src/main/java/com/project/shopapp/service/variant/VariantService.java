package com.project.shopapp.service.variant;

import com.project.shopapp.dto.ProductVariantDTO;
import com.project.shopapp.exception.DataNotFoundException;
import com.project.shopapp.model.Product;
import com.project.shopapp.model.ProductVariant;
import com.project.shopapp.repository.ProductVariantRepository;
import com.project.shopapp.service.product.ProductService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

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

    public ProductVariant update(Long variantId, ProductVariantDTO productVariantDTO) throws DataNotFoundException {
        ProductVariant variant = productVariantRepository.findById(variantId).orElseThrow(() -> new DataNotFoundException("Variant not found"));
        ModelMapper modelMapper = new ModelMapper();
        modelMapper.typeMap(ProductVariantDTO.class, ProductVariant.class)
                .addMappings(mapper -> mapper.skip(ProductVariant::setId));
        modelMapper.map(productVariantDTO, variant);
        return productVariantRepository.save(variant);
    }

    public List<ProductVariant> getVariantByProductId(Long productId) {
        return productVariantRepository.findByProductId(productId);
    }
}
