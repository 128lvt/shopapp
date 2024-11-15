package com.project.shopapp.repository;

import com.project.shopapp.model.TopSellingProductsMonthly;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TopSellingProductsMonthlyRepository extends JpaRepository<TopSellingProductsMonthly, Long> {

    @Query(nativeQuery = true, value = "SELECT * FROM top_selling_products_monthly")
    List<TopSellingProductsMonthly> getTopSellingProductsMonthly();

}
