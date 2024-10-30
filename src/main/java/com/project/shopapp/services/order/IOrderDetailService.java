package com.project.shopapp.services.order;

import com.project.shopapp.dtos.OrderDetailDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.OrderDetail;

import java.util.List;

public interface IOrderDetailService {
    OrderDetail createOrderDetail(OrderDetailDTO orderDetailDTO) throws DataNotFoundException;

    OrderDetail updateOrderDetail(Long id, OrderDetailDTO orderDetailDTO);

    OrderDetail getOrderDetail(Long id) throws DataNotFoundException;

    void deleteOrderDetail(Long id);

    List<OrderDetail> getOrderDetails();

    List<OrderDetail> findByOrderId(Long orderId);
}
