package com.project.shopapp.controller;

import com.project.shopapp.model.TopSellingProductsMonthly;
import com.project.shopapp.service.dashboard.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("${api.prefix}/dashboard")
public class DashboardController {
    private final DashboardService dashboardService;

    @GetMapping("/top-selling")
    public List<TopSellingProductsMonthly> getTopSelling() {
        return dashboardService.getTopSellingProducts();
    }
}
