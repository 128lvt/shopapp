package com.project.shopapp.service.category;

import com.project.shopapp.dto.CategoryDTO;
import com.project.shopapp.model.Category;

import java.util.List;

public interface ICategoryService {
    Category getCategoryById(Long id);

    Category createCategory(CategoryDTO categoryDTO);

    List<Category> getAllCategories();

    void updateCategory(Long id, CategoryDTO categoryDTO);

    void deleteCategory(Long id);
}
