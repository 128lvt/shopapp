package com.project.shopapp.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "top_selling_products_monthly")
@SqlResultSetMapping(
        name = "TopSellingProductsMonthlyMapping",
        entities = @EntityResult(
                entityClass = TopSellingProductsMonthly.class,
                fields = {
                        @FieldResult(name = "january", column = "January"),
                        @FieldResult(name = "february", column = "February"),
                        @FieldResult(name = "march", column = "March"),
                        @FieldResult(name = "april", column = "April"),
                        @FieldResult(name = "may", column = "May"),
                        @FieldResult(name = "june", column = "June"),
                        @FieldResult(name = "july", column = "July"),
                        @FieldResult(name = "august", column = "August"),
                        @FieldResult(name = "september", column = "September"),
                        @FieldResult(name = "october", column = "October"),
                        @FieldResult(name = "november", column = "November"),
                        @FieldResult(name = "december", column = "December")
                }
        )
) // Tên của view trong cơ sở dữ liệu
public class TopSellingProductsMonthly {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long year;

    private Long january;
    private Long february;
    private Long march;
    private Long april;
    private Long may;
    private Long june;
    private Long july;
    private Long august;
    private Long september;
    private Long october;
    private Long november;
    private Long december;
}
