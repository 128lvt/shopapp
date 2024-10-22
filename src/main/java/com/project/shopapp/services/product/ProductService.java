package com.project.shopapp.services.product;

import com.project.shopapp.dtos.ProductDTO;
import com.project.shopapp.dtos.ProductImageDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.exceptions.InvalidParamException;
import com.project.shopapp.models.Category;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductImage;
import com.project.shopapp.repositories.CategoryRepository;
import com.project.shopapp.repositories.ProductImageRepository;
import com.project.shopapp.repositories.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductService implements IProductService {
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ProductImageRepository productImageRepository;

    @Override
    public Product createProduct(ProductDTO productDTO) throws DataNotFoundException {
        Category category = categoryRepository.findById(productDTO.getCategoryId()).orElseThrow(() -> new DataNotFoundException("Cannot find category with id: " + productDTO.getCategoryId()));
        Product product = Product.builder()
                .name(productDTO.getName())
                .category(category)
                .price(productDTO.getPrice())
                .description(productDTO.getDescription())
                .thumbnail(productDTO.getThumbnail())
                .build();
        productRepository.save(product);
        return product;
    }

    @Override
    public Product getProduct(Long id) throws DataNotFoundException {
        //Find by id tra ve kieu optional
        return productRepository.findById(id).orElseThrow(() -> new DataNotFoundException("Cannot find product with id: " + id));
    }

    @Override
    public Page<Product> getAllProducts(PageRequest pageRequest) {
        //Lấy danh sách sản paharm theo trang (page) giới hạn (limit)
        return productRepository.findAll(pageRequest);
    }

    @Override
    public void updateProduct(Long id, ProductDTO productDTO) throws DataNotFoundException {
        Product product = getProduct(id); //getProduct đã có exception
        if (product != null) {
            //ModelMapper
            Category category = categoryRepository.findById(productDTO.getCategoryId()).orElseThrow(() -> new DataNotFoundException("Cannot find category with id: " + productDTO.getCategoryId()));
            product.setName(productDTO.getName());
            product.setCategory(category);
            product.setPrice(productDTO.getPrice());
            product.setDescription(productDTO.getDescription());
            product.setThumbnail(productDTO.getThumbnail());
            productRepository.save(product);
        }
    }

    @Override
    public void deleteProduct(Long id) {
        Optional<Product> productOptional = productRepository.findById(id);
        productOptional.ifPresent(productRepository::delete);
    }

    @Override
    public ProductImage createProductImage(Long productId, ProductImageDTO productImageDTO) throws DataNotFoundException, InvalidParamException {
        Product product = productRepository.findById(productId).orElseThrow(() -> new DataNotFoundException("Cannot find product with id: " + productId));
        ProductImage productImage = ProductImage.builder()
                .product(product)
                .imageUrl(productImageDTO.getImageUrl())
                .build();
        //Không cho insert quá 5 ảnh cho 1 sản pẩm
        int size = productImageRepository.findByProductId(productId).size();
        if (size >= ProductImage.MAXIMUM_IMAGE_PER_PRODUCT) {
            throw new InvalidParamException("Number of product's image must be <= " + ProductImage.MAXIMUM_IMAGE_PER_PRODUCT);
        }
        return productImageRepository.save(productImage);
    }

    @Override
    public boolean existsByName(String name) {
        return productRepository.existsByName(name);
    }
}
