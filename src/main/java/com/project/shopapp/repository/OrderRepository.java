package com.project.shopapp.repository;

import com.project.shopapp.model.Order;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrderRepository extends CrudRepository<Order, Long> {


    List<Order> findAllByOrderByIdDesc();

    List<Order> findByUserIdOrderByIdDesc(Long userId);
}
