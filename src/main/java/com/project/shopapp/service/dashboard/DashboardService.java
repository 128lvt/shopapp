package com.project.shopapp.service.dashboard;

import com.project.shopapp.model.TopSellingProductsMonthly;
import com.project.shopapp.repository.TopSellingProductsMonthlyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final TopSellingProductsMonthlyRepository repository;

    public List<TopSellingProductsMonthly> getTopSellingProducts() {
        return repository.getTopSellingProductsMonthly();
    }
}
