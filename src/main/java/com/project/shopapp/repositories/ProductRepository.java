package com.project.shopapp.repositories;

import com.project.shopapp.models.Product;
import com.project.shopapp.responses.ProductResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    boolean existsByName(String name);

    Page<Product> findAll(Pageable pageable);

    @Query(value = "SELECT p.id AS product_id, p.name AS product_name, p.price, p.thumbnail, p.description, " +
            "p.created_at, p.updated_at, pv.id AS variant_id, pv.size, pv.color, pv.stock " +
            "FROM products p " +
            "JOIN product_variants pv ON p.id = pv.product_id",
            nativeQuery = true)
    List<ProductResponse> getAllProducts();
    
}
