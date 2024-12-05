package com.project.shopapp.service.product;

import com.project.shopapp.dto.ProductDTO;
import com.project.shopapp.dto.ProductImageDTO;
import com.project.shopapp.exception.DataNotFoundException;
import com.project.shopapp.exception.InvalidParamException;
import com.project.shopapp.model.Category;
import com.project.shopapp.model.Product;
import com.project.shopapp.model.ProductImage;
import com.project.shopapp.repository.CategoryRepository;
import com.project.shopapp.repository.ProductImageRepository;
import com.project.shopapp.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ProductImageRepository productImageRepository;

    public Product createProduct(ProductDTO productDTO) throws DataNotFoundException {
        Category category = categoryRepository.findById(productDTO.getCategoryId()).orElseThrow(() -> new DataNotFoundException("Cannot find category with id: " + productDTO.getCategoryId()));
        Product product = Product.builder()
                .name(productDTO.getName())
                .category(category)
                .price(productDTO.getPrice())
                .description(productDTO.getDescription())
                .build();
        productRepository.save(product);
        return product;
    }


    public Product getProduct(Long id) throws DataNotFoundException {
        //Find by id tra ve kieu optional
        return productRepository.findById(id).orElseThrow(() -> new DataNotFoundException("Cannot find product with id: " + id));
    }

    public Page<Product> searchProducts(String name, Double minPrice, Double maxPrice,
                                        String description, List<Long> categoryIds,
                                        String sortOrder, int page, int limit) {

        Sort sort = Sort.by(sortOrder);

        if (sortOrder != null && sortOrder.equals("-1")) {
            sort = Sort.by(Sort.Order.asc("updatedAt"));
        } else {
            assert sortOrder != null;
            sort = sortOrder.equalsIgnoreCase("desc") ? Sort.by("price").descending() : Sort.by("price").ascending();
        }
        PageRequest pageRequest = PageRequest.of(page, limit, sort);
        return productRepository.findProductsByFilters(name, minPrice, maxPrice, description, categoryIds, pageRequest);
    }


    public List<Product> getAllProducts() {
        //Lấy danh sách sản paharm theo trang (page) giới hạn (limit)
        return productRepository.findAll();
    }


    public Product updateProduct(Long id, ProductDTO productDTO) throws DataNotFoundException {
        Product product = getProduct(id); //getProduct đã có exception
        if (product != null) {
            //ModelMapper
            Category category = categoryRepository.findById(productDTO.getCategoryId()).orElseThrow(() -> new DataNotFoundException("Cannot find category with id: " + productDTO.getCategoryId()));
            product.setName(productDTO.getName());
            product.setCategory(category);
            product.setPrice(productDTO.getPrice());
            product.setDescription(productDTO.getDescription());
            return productRepository.save(product);
        }
        return null;
    }


    public void deleteProduct(Long id) {
        Optional<Product> productOptional = productRepository.findById(id);
        productOptional.ifPresent(productRepository::delete);
    }


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


    public boolean existsByName(String name) {
        return productRepository.existsByName(name);
    }

    public ProductImage getProductImage(Long productImageId) throws DataNotFoundException {
        return productImageRepository.findById(productImageId).orElseThrow(() -> new DataNotFoundException("Không tìm thấy Image"));
    }

    public void updateProductImage(Long productImageId, ProductImage productImage) throws DataNotFoundException, InvalidParamException {
        productImage.setImageUrl(productImage.getImageUrl());
        productImageRepository.save(productImage);
    }


}
