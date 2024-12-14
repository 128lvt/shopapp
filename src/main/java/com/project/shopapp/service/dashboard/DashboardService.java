package com.project.shopapp.service.dashboard;

import com.project.shopapp.model.TopSellingCategory;
import com.project.shopapp.model.TopSellingProductsMonthly;
import com.project.shopapp.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final TopSellingProductsMonthlyRepository monthlyRepository;
    private final TopSellingCategoryRepository sellingCategoryRepository;
    private final ProductRepository productRepository;
    private final ProductVariantRepository productVariantRepository;
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;

    public List<TopSellingProductsMonthly> getTopSellingProducts() {
        return monthlyRepository.getTopSellingProductsMonthly();
    }

    public List<TopSellingCategory> getTopSellingCategories() {
        return sellingCategoryRepository.findAll();
    }

    public Object getCount() {
        Map<String, Long> response = new HashMap<>();

        response.put("user", userRepository.count());
        response.put("product", productRepository.count());
        response.put("order", orderRepository.count());
        return response;
    }

}
