package com.project.shopapp.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity(name = "top_selling_categories")
@Data
public class TopSellingCategory {
    @Id
    @Column(name = "category_name")
    private String categoryName;

    @Column(name = "total_sold")
    private Long totalSold;
}
