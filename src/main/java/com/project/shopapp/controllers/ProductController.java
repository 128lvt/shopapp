package com.project.shopapp.controllers;

import com.github.javafaker.Faker;
import com.project.shopapp.dtos.ProductDTO;
import com.project.shopapp.dtos.ProductImageDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductImage;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.responses.ProductResponse;
import com.project.shopapp.responses.Response;
import com.project.shopapp.services.product.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@RestController
@RequestMapping("${api.prefix}/products")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    private final ProductRepository productRepository;

    @PostMapping
    //@Valid để validate dữ liệu
    //<?> Có thể vừa nhận String và List<String>
    /*{
        "name": "IPad Pro 2023",
            "price": 812.34,
            "thumbnail": "",
            "description": "This is a test",
            "category_id": 1
    }*/
    public ResponseEntity<?> createProduct(@Valid @RequestBody ProductDTO productDTO, BindingResult bindingResult) throws DataNotFoundException {
        if (bindingResult.hasErrors()) {
            List<String> errorMessage = bindingResult.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errorMessage);
        }
        //Phai luu vao database thi moi co productId de lay
        Product product = productService.createProduct(productDTO);
        return ResponseEntity.ok(product);

    }

    @PostMapping(value = "uploads/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> uploadImages(@ModelAttribute("files") List<MultipartFile> files, @PathVariable("id") Long productId) {
        try {
            Product product = productService.getProduct(productId);
            //Nếu không có files thì tạo mảng rỗng
            files = files == null ? new ArrayList<MultipartFile>() : files;
            if (files.size() > ProductImage.MAXIMUM_IMAGE_PER_PRODUCT) {
                return ResponseEntity.badRequest().body("Cannot upload more than " + ProductImage.MAXIMUM_IMAGE_PER_PRODUCT + " images");
            }
            List<ProductImage> productImages = new ArrayList<>();
            for (MultipartFile file : files) {
                if (file != null) {
                    if (file.getSize() == 0) {
                        continue;
                    }
                    //Kiểm tra kích thước file và định dạng
                    if (file.getSize() > 10 * 1024 * 1024) {
                        return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("File is too large! Maximum size is 10MB");
                    }
                    String contentType = file.getContentType();
                    if (contentType == null || !contentType.startsWith("image/")) {
                        return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE).body("File must be an image");
                    }
                    //Lưu file và cập nhật thumbnail trong DTO
                    String fileName = storeFile(file);
                    ProductImage productImage = productService.createProductImage(
                            product.getId(),
                            ProductImageDTO.builder()
                                    .imageUrl(fileName)
                                    .build()
                    );
                    productImages.add(productImage);
                }
            }
            return ResponseEntity.ok().body(productImages);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    public String storeFile(MultipartFile file) throws IOException {
        if (isImageFile(file) || file.getOriginalFilename() == null) {
            throw new IOException("Invalid image file");
        }
        String fileName = StringUtils.cleanPath((Objects.requireNonNull(file.getOriginalFilename())));
        //Thêm UUID vào trước tên file để đảm bảo tên file là duy nhất
        String uniqueFileName = UUID.randomUUID() + "_" + fileName;
        //Đường dẫn đến thư mục luu file
        Path uploadDir = Paths.get("uploads");

        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        //Đường dẫn đầy đủ đến file
        Path destination = Paths.get(uploadDir.toString(), uniqueFileName);

        //Sao chép file vào thư mục đích
        Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);

        return uniqueFileName;
    }

    private boolean isImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType == null || !contentType.startsWith("image/");
    }

    @GetMapping
    public ResponseEntity<?> getProducts(@RequestParam("page") int page, @RequestParam("limit") int limit) {
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("createdAt").descending());
        Page<Product> productPage = productService.getAllProducts(pageRequest);
        int totalPages = productPage.getTotalPages();
        List<Product> products = productPage.getContent();
        Response response = Response
                .builder()
                .data(ProductResponse
                        .builder()
                        .products(products)
                        .totalPages(totalPages)
                        .build())
                .message("success")
                .build();
        return ResponseEntity.ok().body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getProductById(@PathVariable("id") Long productId) {
        try {
            return ResponseEntity.ok(productService.getProduct(productId));
        } catch (DataNotFoundException e) {
            return ResponseEntity.badRequest().body(Response.builder()
                    .message("Product not found")
                    .data(e.getMessage())
                    .build());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateProduct(@PathVariable("id") Long productId, @RequestBody ProductDTO productDTO) throws DataNotFoundException {
        productService.updateProduct(productId, productDTO);
        return ResponseEntity.ok("Product updated successfully");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteProduct(@PathVariable("id") Long productId) {
        productService.deleteProduct(productId);
        return ResponseEntity.ok("delete id=" + productId);
    }

    @PostMapping("/generateFakeProducts")
    public ResponseEntity<String> generateFakeProducts() {
        Faker faker = new Faker();
        for (int i = 0; i < 5; i++) {
            String productName = faker.commerce().productName();
            if (productService.existsByName(productName)) {
                continue;
            }
            ProductDTO productDTO = ProductDTO
                    .builder()
                    .name(productName)
                    .price((double) faker.number().numberBetween(100000, 9000000))
                    .description(faker.lorem().sentence())
                    .thumbnail("")
                    .categoryId((long) faker.number().numberBetween(1, 3))
                    .build();
            try {
                productService.createProduct(productDTO);
            } catch (Exception e) {
                return ResponseEntity.badRequest().body(e.getMessage());
            }
        }
        return ResponseEntity.ok("generateFakeProducts");
    }
}
