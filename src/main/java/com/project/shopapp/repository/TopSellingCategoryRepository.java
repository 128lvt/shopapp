package com.project.shopapp.repository;

import com.project.shopapp.model.TopSellingCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TopSellingCategoryRepository extends JpaRepository<TopSellingCategory, String> {
}
