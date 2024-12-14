package com.project.shopapp.controller;

import com.project.shopapp.model.TopSellingCategory;
import com.project.shopapp.model.TopSellingProductsMonthly;
import com.project.shopapp.service.dashboard.DashboardService;
import com.project.shopapp.service.product.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("${api.prefix}/dashboard")
public class DashboardController {
    private final DashboardService dashboardService;
    private final ProductService productService;

    @GetMapping("/top-selling-monthly")
    public List<TopSellingProductsMonthly> getTopSelling() {
        return dashboardService.getTopSellingProducts();
    }

    @GetMapping("/top-selling-categories")
    public List<TopSellingCategory> getTopSellingCategories() {
        return dashboardService.getTopSellingCategories();
    }

    @GetMapping("/count")
    public ResponseEntity<?> getProductCount() {
        return ResponseEntity.ok(dashboardService.getCount());
    }
}
