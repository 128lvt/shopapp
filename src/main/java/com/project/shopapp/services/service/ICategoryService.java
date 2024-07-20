package com.project.shopapp.services.service;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;
import org.springframework.stereotype.Service;

import java.util.List;

public interface ICategoryService {
    Category getCategoryById(Long id);

    void createCategory(CategoryDTO categoryDTO);

    List<Category> getAllCategories();

    void updateCategory(Long id, CategoryDTO categoryDTO);

    void deleteCategory(Long id);
}
