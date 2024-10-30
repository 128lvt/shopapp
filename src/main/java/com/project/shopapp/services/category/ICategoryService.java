package com.project.shopapp.services.category;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;

import java.util.List;

public interface ICategoryService {
    Category getCategoryById(Long id);

    Category createCategory(CategoryDTO categoryDTO);

    List<Category> getAllCategories();

    void updateCategory(Long id, CategoryDTO categoryDTO);

    void deleteCategory(Long id);
}
