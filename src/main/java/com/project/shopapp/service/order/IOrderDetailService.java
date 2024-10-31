package com.project.shopapp.service.order;

import com.project.shopapp.dto.OrderDetailDTO;
import com.project.shopapp.exception.DataNotFoundException;
import com.project.shopapp.model.OrderDetail;

import java.util.List;

public interface IOrderDetailService {
    OrderDetail createOrderDetail(OrderDetailDTO orderDetailDTO) throws DataNotFoundException;

    OrderDetail updateOrderDetail(Long id, OrderDetailDTO orderDetailDTO) throws DataNotFoundException;

    OrderDetail getOrderDetail(Long id) throws DataNotFoundException;

    void deleteOrderDetail(Long id) throws DataNotFoundException;

    List<OrderDetail> getOrderDetails();

    List<OrderDetail> findByOrderId(Long orderId) throws DataNotFoundException;
}
