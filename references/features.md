### Kiến Trúc Microservices Chi Tiết cho Nền Tảng Thương Mại Điện Tử

Dưới đây là danh sách chi tiết các microservices và API của chúng theo yêu cầu của bạn:

## 1. Auth Service (Dịch vụ Xác thực)

**Trách nhiệm**: Quản lý xác thực người dùng, đăng nhập, đăng ký, và phân quyền.

**Bảng dữ liệu**:

- `accounts` (chỉ thông tin xác thực)
- `sessions`

**APIs**:

### 1.1. Đăng ký tài khoản

- **Method**: POST
- **Endpoint**: `/auth/register`
- **Tham số**:
- **Body**:

```json
{
  "email": "string",
  "password": "string",
  "fullName": "string",
  "phoneNumber": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "email": "string",
  "fullName": "string",
  "createdAt": "timestamp"
}
```

- **Output lỗi**:
- **Status**: 400 Bad Request

### 1.2. Đăng nhập

- **Method**: POST
- **Endpoint**: `/auth/login`
- **Tham số**:
- **Body**:

```json
{
  "email": "string",
  "password": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "accessToken": "string",
  "refreshToken": "string",
  "expiresIn": "number",
  "userId": "string"
}
```

- **Output lỗi**:
- **Status**: 401 Unauthorized

### 1.3. Làm mới token

- **Method**: POST
- **Endpoint**: `/auth/refresh-token`
- **Tham số**:
- **Body**:

```json
{
  "refreshToken": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "accessToken": "string",
  "refreshToken": "string",
  "expiresIn": "number"
}
```

- **Output lỗi**:
- **Status**: 401 Unauthorized

### 1.4. Đăng xuất

- **Method**: POST
- **Endpoint**: `/auth/logout`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "message": "Đăng xuất thành công"
}
```

### 1.5. Quên mật khẩu

- **Method**: POST
- **Endpoint**: `/auth/forgot-password`
- **Tham số**:
- **Body**:

```json
{
  "email": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "message": "Email khôi phục mật khẩu đã được gửi"
}
```

### 1.6. Đặt lại mật khẩu

- **Method**: POST
- **Endpoint**: `/auth/reset-password`
- **Tham số**:
- **Body**:

```json
{
  "token": "string",
  "newPassword": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "message": "Mật khẩu đã được cập nhật thành công"
}
```

- **Output lỗi**:
- **Status**: 400 Bad Request

### 1.7. Xác minh email

- **Method**: GET
- **Endpoint**: `/auth/verify-email/{token}`
- **Tham số**:
- **Path**: token - Mã xác minh email
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "message": "Email đã được xác minh thành công"
}
```

- **Output lỗi**:
- **Status**: 400 Bad Request

## 2. User Service (Dịch vụ Người dùng)

**Trách nhiệm**: Quản lý thông tin cá nhân người dùng, địa chỉ, và hoạt động người dùng.

**Bảng dữ liệu**:

- `users` (thông tin cá nhân)
- `user_addresses`
- `user_activities`

**APIs**:

### 2.1. Lấy thông tin người dùng

- **Method**: GET
- **Endpoint**: `/users/{id}`
- **Tham số**:
- **Path**: id - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "email": "string",
  "fullName": "string",
  "phoneNumber": "string",
  "avatarUrl": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "isActive": "boolean"
}
```

- **Output lỗi**:
- **Status**: 404 Not Found

### 2.2. Cập nhật thông tin người dùng

- **Method**: PUT
- **Endpoint**: `/users/{id}`
- **Tham số**:
- **Path**: id - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "fullName": "string",
  "phoneNumber": "string",
  "avatarUrl": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "email": "string",
  "fullName": "string",
  "phoneNumber": "string",
  "avatarUrl": "string",
  "updatedAt": "timestamp"
}
```

- **Output lỗi**:
- **Status**: 403 Forbidden

### 2.3. Đổi mật khẩu

- **Method**: PUT
- **Endpoint**: `/users/{id}/change-password`
- **Tham số**:
- **Path**: id - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "currentPassword": "string",
  "newPassword": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "message": "Mật khẩu đã được cập nhật thành công"
}
```

- **Output lỗi**:
- **Status**: 400 Bad Request

### 2.4. Lấy danh sách địa chỉ

- **Method**: GET
- **Endpoint**: `/users/{id}/addresses`
- **Tham số**:
- **Path**: id - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "recipientName": "string",
    "phoneNumber": "string",
    "addressLine1": "string",
    "addressLine2": "string",
    "city": "string",
    "district": "string",
    "postalCode": "string",
    "country": "string",
    "isDefault": "boolean"
  }
]
```

### 2.5. Thêm địa chỉ mới

- **Method**: POST
- **Endpoint**: `/users/{id}/addresses`
- **Tham số**:
- **Path**: id - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "recipientName": "string",
  "phoneNumber": "string",
  "addressLine1": "string",
  "addressLine2": "string",
  "city": "string",
  "district": "string",
  "postalCode": "string",
  "country": "string",
  "isDefault": "boolean"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "recipientName": "string",
  "phoneNumber": "string",
  "addressLine1": "string",
  "addressLine2": "string",
  "city": "string",
  "district": "string",
  "postalCode": "string",
  "country": "string",
  "isDefault": "boolean"
}
```

### 2.6. Cập nhật địa chỉ

- **Method**: PUT
- **Endpoint**: `/users/{id}/addresses/{addressId}`
- **Tham số**:
- **Path**:
- id - ID người dùng
- addressId - ID địa chỉ
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "recipientName": "string",
  "phoneNumber": "string",
  "addressLine1": "string",
  "addressLine2": "string",
  "city": "string",
  "district": "string",
  "postalCode": "string",
  "country": "string",
  "isDefault": "boolean"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "recipientName": "string",
  "phoneNumber": "string",
  "addressLine1": "string",
  "addressLine2": "string",
  "city": "string",
  "district": "string",
  "postalCode": "string",
  "country": "string",
  "isDefault": "boolean"
}
```

### 2.7. Xóa địa chỉ

- **Method**: DELETE
- **Endpoint**: `/users/{id}/addresses/{addressId}`
- **Tham số**:
- **Path**:
- id - ID người dùng
- addressId - ID địa chỉ
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content
- **Output lỗi**:
- **Status**: 404 Not Found

### 2.8. Đặt địa chỉ mặc định

- **Method**: PUT
- **Endpoint**: `/users/{id}/addresses/{addressId}/default`
- **Tham số**:
- **Path**:
- id - ID người dùng
- addressId - ID địa chỉ
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "message": "Đã đặt địa chỉ mặc định thành công"
}
```

### 2.9. Lấy lịch sử hoạt động người dùng

- **Method**: GET
- **Endpoint**: `/users/{id}/activities`
- **Tham số**:
- **Path**: id - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "activityType": "string",
      "entityId": "string",
      "entityType": "string",
      "createdAt": "timestamp",
      "details": "string"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

## 3. Seller Service (Dịch vụ Người bán)

**Trách nhiệm**: Quản lý thông tin người bán, chỉ số hiệu suất, và giao dịch tài chính.

**Bảng dữ liệu**:

- `sellers`
- `seller_metrics`
- `seller_transactions`
- `fee_structures`

**APIs**:

### 3.1. Đăng ký làm người bán

- **Method**: POST
- **Endpoint**: `/sellers`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "sellerName": "string",
  "description": "string",
  "taxId": "string",
  "logoUrl": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "sellerName": "string",
  "description": "string",
  "createdAt": "timestamp",
  "isVerified": false,
  "logoUrl": "string",
  "taxId": "string"
}
```

- **Output lỗi**:
- **Status**: 400 Bad Request

### 3.2. Lấy thông tin người bán

- **Method**: GET
- **Endpoint**: `/sellers/{id}`
- **Tham số**:
- **Path**: id - ID người bán
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "sellerName": "string",
  "description": "string",
  "createdAt": "timestamp",
  "rating": "number",
  "isVerified": "boolean",
  "logoUrl": "string",
  "taxId": "string"
}
```

### 3.3. Cập nhật thông tin người bán

- **Method**: PUT
- **Endpoint**: `/sellers/{id}`
- **Tham số**:
- **Path**: id - ID người bán
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "sellerName": "string",
  "description": "string",
  "logoUrl": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "sellerName": "string",
  "description": "string",
  "logoUrl": "string",
  "updatedAt": "timestamp"
}
```

### 3.4. Lấy chỉ số hiệu suất người bán

- **Method**: GET
- **Endpoint**: `/sellers/{id}/metrics`
- **Tham số**:
- **Path**: id - ID người bán
- **Header**: Authorization: Bearer accessToken
- **Query**:
- periodStart - Thời gian bắt đầu (timestamp)
- periodEnd - Thời gian kết thúc (timestamp)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "totalSales": "number",
  "orderCount": "number",
  "cancellationRate": "number",
  "returnRate": "number",
  "avgRating": "number",
  "responseTimeMinutes": "number",
  "periodStart": "timestamp",
  "periodEnd": "timestamp"
}
```

### 3.5. Lấy giao dịch tài chính người bán

- **Method**: GET
- **Endpoint**: `/sellers/{id}/transactions`
- **Tham số**:
- **Path**: id - ID người bán
- **Header**: Authorization: Bearer accessToken
- **Query**:
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- startDate - Ngày bắt đầu (timestamp)
- endDate - Ngày kết thúc (timestamp)
- status - Trạng thái giao dịch
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "orderId": "string",
      "amount": "number",
      "feeAmount": "number",
      "netAmount": "number",
      "transactionType": "string",
      "status": "string",
      "createdAt": "timestamp"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

### 3.6. Lấy cấu trúc phí theo danh mục

- **Method**: GET
- **Endpoint**: `/sellers/categories/{categoryId}/fees`
- **Tham số**:
- **Path**: categoryId - ID danh mục
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "categoryId": "string",
  "percentage": "number",
  "fixedAmount": "number",
  "minFee": "number",
  "effectiveFrom": "timestamp",
  "effectiveTo": "timestamp"
}
```

## 4. Product Service (Dịch vụ Sản phẩm)

**Trách nhiệm**: Quản lý danh mục sản phẩm, thông tin sản phẩm, và biến thể sản phẩm.

**Bảng dữ liệu**:

- `products`
- `product_variants`
- `product_attributes`
- `variant_attributes`
- `product_images`
- `categories`
- `product_recommendations`

**APIs**:

### 4.1. Tạo sản phẩm mới

- **Method**: POST
- **Endpoint**: `/products`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "sellerId": "string",
  "name": "string",
  "description": "string",
  "categoryId": "string",
  "basePrice": "number",
  "attributes": [
    {
      "attributeName": "string",
      "attributeValue": "string"
    }
  ]
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "sellerId": "string",
  "name": "string",
  "description": "string",
  "categoryId": "string",
  "basePrice": "number",
  "isActive": true,
  "createdAt": "timestamp",
  "attributes": [
    {
      "id": "string",
      "attributeName": "string",
      "attributeValue": "string"
    }
  ]
}
```

### 4.2. Lấy thông tin sản phẩm

- **Method**: GET
- **Endpoint**: `/products/{id}`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "sellerId": "string",
  "name": "string",
  "description": "string",
  "categoryId": "string",
  "basePrice": "number",
  "isActive": "boolean",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "viewCount": "number",
  "soldCount": "number",
  "attributes": [
    {
      "id": "string",
      "attributeName": "string",
      "attributeValue": "string"
    }
  ],
  "images": [
    {
      "id": "string",
      "imageUrl": "string",
      "displayOrder": "number"
    }
  ],
  "category": {
    "id": "string",
    "name": "string"
  },
  "seller": {
    "id": "string",
    "sellerName": "string",
    "rating": "number"
  }
}
```

### 4.3. Cập nhật sản phẩm

- **Method**: PUT
- **Endpoint**: `/products/{id}`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "description": "string",
  "categoryId": "string",
  "basePrice": "number",
  "isActive": "boolean"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "categoryId": "string",
  "basePrice": "number",
  "isActive": "boolean",
  "updatedAt": "timestamp"
}
```

### 4.4. Xóa sản phẩm

- **Method**: DELETE
- **Endpoint**: `/products/{id}`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content
- **Output lỗi**:
- **Status**: 403 Forbidden

### 4.5. Tìm kiếm sản phẩm

- **Method**: GET
- **Endpoint**: `/products/search`
- **Tham số**:
- **Query**:
- q - Từ khóa tìm kiếm
- categoryId - ID danh mục
- minPrice - Giá tối thiểu
- maxPrice - Giá tối đa
- sort - Sắp xếp (newest, priceAsc, priceDesc, popular)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "name": "string",
      "basePrice": "number",
      "imageUrl": "string",
      "rating": "number",
      "soldCount": "number",
      "seller": {
        "id": "string",
        "sellerName": "string"
      }
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

### 4.6. Lấy biến thể sản phẩm

- **Method**: GET
- **Endpoint**: `/products/{id}/variants`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "sku": "string",
    "price": "number",
    "stockQuantity": "number",
    "imageUrl": "string",
    "attributes": [
      {
        "attributeName": "string",
        "attributeValue": "string"
      }
    ]
  }
]
```

### 4.7. Thêm biến thể sản phẩm

- **Method**: POST
- **Endpoint**: `/products/{id}/variants`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "sku": "string",
  "price": "number",
  "stockQuantity": "number",
  "imageUrl": "string",
  "attributes": [
    {
      "attributeName": "string",
      "attributeValue": "string"
    }
  ]
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "productId": "string",
  "sku": "string",
  "price": "number",
  "stockQuantity": "number",
  "imageUrl": "string",
  "attributes": [
    {
      "id": "string",
      "attributeName": "string",
      "attributeValue": "string"
    }
  ]
}
```

### 4.8. Cập nhật biến thể sản phẩm

- **Method**: PUT
- **Endpoint**: `/products/{id}/variants/{variantId}`
- **Tham số**:
- **Path**:
- id - ID sản phẩm
- variantId - ID biến thể
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "sku": "string",
  "price": "number",
  "stockQuantity": "number",
  "imageUrl": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "sku": "string",
  "price": "number",
  "stockQuantity": "number",
  "imageUrl": "string"
}
```

### 4.9. Xóa biến thể sản phẩm

- **Method**: DELETE
- **Endpoint**: `/products/{id}/variants/{variantId}`
- **Tham số**:
- **Path**:
- id - ID sản phẩm
- variantId - ID biến thể
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 4.10. Lấy hình ảnh sản phẩm

- **Method**: GET
- **Endpoint**: `/products/{id}/images`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "imageUrl": "string",
    "displayOrder": "number"
  }
]
```

### 4.11. Thêm hình ảnh sản phẩm

- **Method**: POST
- **Endpoint**: `/products/{id}/images`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "imageUrl": "string",
  "displayOrder": "number"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "productId": "string",
  "imageUrl": "string",
  "displayOrder": "number"
}
```

### 4.12. Xóa hình ảnh sản phẩm

- **Method**: DELETE
- **Endpoint**: `/products/{id}/images/{imageId}`
- **Tham số**:
- **Path**:
- id - ID sản phẩm
- imageId - ID hình ảnh
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 4.13. Lấy danh sách danh mục

- **Method**: GET
- **Endpoint**: `/categories`
- **Tham số**:
- **Query**:
- parentId - ID danh mục cha (tùy chọn)
- level - Cấp độ danh mục (tùy chọn)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "parentId": "string",
    "level": "number",
    "imageUrl": "string",
    "isActive": "boolean",
    "children": [
      {
        "id": "string",
        "name": "string"
      }
    ]
  }
]
```

### 4.14. Lấy chi tiết danh mục

- **Method**: GET
- **Endpoint**: `/categories/{id}`
- **Tham số**:
- **Path**: id - ID danh mục
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "parentId": "string",
  "level": "number",
  "imageUrl": "string",
  "isActive": "boolean",
  "parent": {
    "id": "string",
    "name": "string"
  },
  "children": [
    {
      "id": "string",
      "name": "string"
    }
  ]
}
```

### 4.15. Tạo danh mục

- **Method**: POST
- **Endpoint**: `/categories`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "description": "string",
  "parentId": "string",
  "imageUrl": "string",
  "isActive": "boolean"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "parentId": "string",
  "level": "number",
  "imageUrl": "string",
  "isActive": "boolean"
}
```

### 4.16. Cập nhật danh mục

- **Method**: PUT
- **Endpoint**: `/categories/{id}`
- **Tham số**:
- **Path**: id - ID danh mục
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "description": "string",
  "parentId": "string",
  "imageUrl": "string",
  "isActive": "boolean"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "parentId": "string",
  "level": "number",
  "imageUrl": "string",
  "isActive": "boolean"
}
```

### 4.17. Lấy sản phẩm đề xuất

- **Method**: GET
- **Endpoint**: `/products/{id}/recommendations`
- **Tham số**:
- **Path**: id - ID sản phẩm
- **Query**:
- type - Loại đề xuất (similar, frequentlyBoughtTogether, etc.)
- limit - Số lượng (mặc định: 10)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "basePrice": "number",
    "imageUrl": "string",
    "rating": "number",
    "soldCount": "number",
    "recommendationType": "string",
    "score": "number"
  }
]
```

## 5. Inventory Service (Dịch vụ Kho hàng)

**Trách nhiệm**: Quản lý tồn kho sản phẩm và thông tin kho hàng.

**Bảng dữ liệu**:

- `inventory`
- `warehouses`

**APIs**:

### 5.1. Lấy thông tin tồn kho của biến thể

- **Method**: GET
- **Endpoint**: `/inventory/variants/{variantId}`
- **Tham số**:
- **Path**: variantId - ID biến thể sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "warehouseId": "string",
    "warehouseName": "string",
    "quantity": "number",
    "lastUpdated": "timestamp"
  }
]
```

### 5.2. Cập nhật tồn kho

- **Method**: PUT
- **Endpoint**: `/inventory/variants/{variantId}`
- **Tham số**:
- **Path**: variantId - ID biến thể sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "warehouseId": "string",
  "quantity": "number"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "variantId": "string",
  "warehouseId": "string",
  "quantity": "number",
  "lastUpdated": "timestamp"
}
```

### 5.3. Lấy danh sách kho hàng

- **Method**: GET
- **Endpoint**: `/warehouses`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "address": "string",
    "city": "string",
    "country": "string",
    "postalCode": "string"
  }
]
```

### 5.4. Lấy chi tiết kho hàng

- **Method**: GET
- **Endpoint**: `/warehouses/{id}`
- **Tham số**:
- **Path**: id - ID kho hàng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "address": "string",
  "city": "string",
  "country": "string",
  "postalCode": "string"
}
```

### 5.5. Thêm kho hàng mới

- **Method**: POST
- **Endpoint**: `/warehouses`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "address": "string",
  "city": "string",
  "country": "string",
  "postalCode": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "address": "string",
  "city": "string",
  "country": "string",
  "postalCode": "string"
}
```

### 5.6. Cập nhật kho hàng

- **Method**: PUT
- **Endpoint**: `/warehouses/{id}`
- **Tham số**:
- **Path**: id - ID kho hàng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "address": "string",
  "city": "string",
  "country": "string",
  "postalCode": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "address": "string",
  "city": "string",
  "country": "string",
  "postalCode": "string"
}
```

### 5.7. Lấy tồn kho trong kho hàng

- **Method**: GET
- **Endpoint**: `/warehouses/{id}/inventory`
- **Tham số**:
- **Path**: id - ID kho hàng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "variantId": "string",
      "productName": "string",
      "variantSku": "string",
      "quantity": "number",
      "lastUpdated": "timestamp"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

## 6. Cart Service (Dịch vụ Giỏ hàng)

**Trách nhiệm**: Quản lý giỏ hàng của người dùng.

**Bảng dữ liệu**:

- `carts`
- `cart_items`

**APIs**:

### 6.1. Lấy giỏ hàng của người dùng

- **Method**: GET
- **Endpoint**: `/carts/{userId}`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "items": [
    {
      "id": "string",
      "variantId": "string",
      "quantity": "number",
      "addedAt": "timestamp",
      "product": {
        "id": "string",
        "name": "string",
        "imageUrl": "string"
      },
      "variant": {
        "id": "string",
        "sku": "string",
        "price": "number",
        "attributes": [
          {
            "attributeName": "string",
            "attributeValue": "string"
          }
        ]
      },
      "seller": {
        "id": "string",
        "sellerName": "string"
      }
    }
  ],
  "totalItems": "number",
  "subtotal": "number"
}
```

### 6.2. Thêm sản phẩm vào giỏ hàng

- **Method**: POST
- **Endpoint**: `/carts/{userId}/items`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "variantId": "string",
  "quantity": "number"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "cartId": "string",
  "variantId": "string",
  "quantity": "number",
  "addedAt": "timestamp"
}
```

- **Output lỗi**:
- **Status**: 400 Bad Request

### 6.3. Cập nhật sản phẩm trong giỏ hàng

- **Method**: PUT
- **Endpoint**: `/carts/{userId}/items/{itemId}`
- **Tham số**:
- **Path**:
- userId - ID người dùng
- itemId - ID mặt hàng trong giỏ
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "quantity": "number"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "cartId": "string",
  "variantId": "string",
  "quantity": "number",
  "addedAt": "timestamp"
}
```

### 6.4. Xóa sản phẩm khỏi giỏ hàng

- **Method**: DELETE
- **Endpoint**: `/carts/{userId}/items/{itemId}`
- **Tham số**:
- **Path**:
- userId - ID người dùng
- itemId - ID mặt hàng trong giỏ
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 6.5. Xóa toàn bộ giỏ hàng

- **Method**: DELETE
- **Endpoint**: `/carts/{userId}`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

## 7. Order Service (Dịch vụ Đơn hàng)

**Trách nhiệm**: Xử lý và theo dõi đơn hàng.

**Bảng dữ liệu**:

- `orders`
- `order_items`

**APIs**:

### 7.1. Tạo đơn hàng mới

- **Method**: POST
- **Endpoint**: `/orders`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "userId": "string",
  "addressId": "string",
  "items": [
    {
      "variantId": "string",
      "quantity": "number",
      "unitPrice": "number"
    }
  ],
  "paymentMethod": "string",
  "shippingMethod": "string",
  "shippingFee": "number",
  "tax": "number",
  "discount": "number"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "addressId": "string",
  "createdAt": "timestamp",
  "status": "pending",
  "subtotal": "number",
  "shippingFee": "number",
  "tax": "number",
  "discount": "number",
  "total": "number",
  "paymentMethod": "string",
  "shippingMethod": "string",
  "items": [
    {
      "id": "string",
      "variantId": "string",
      "quantity": "number",
      "unitPrice": "number",
      "subtotal": "number"
    }
  ]
}
```

### 7.2. Lấy chi tiết đơn hàng

- **Method**: GET
- **Endpoint**: `/orders/{id}`
- **Tham số**:
- **Path**: id - ID đơn hàng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "addressId": "string",
  "createdAt": "timestamp",
  "status": "string",
  "subtotal": "number",
  "shippingFee": "number",
  "tax": "number",
  "discount": "number",
  "total": "number",
  "paymentMethod": "string",
  "shippingMethod": "string",
  "items": [
    {
      "id": "string",
      "variantId": "string",
      "quantity": "number",
      "unitPrice": "number",
      "subtotal": "number",
      "product": {
        "id": "string",
        "name": "string",
        "imageUrl": "string"
      },
      "variant": {
        "sku": "string",
        "attributes": [
          {
            "attributeName": "string",
            "attributeValue": "string"
          }
        ]
      },
      "seller": {
        "id": "string",
        "sellerName": "string"
      }
    }
  ],
  "address": {
    "recipientName": "string",
    "phoneNumber": "string",
    "addressLine1": "string",
    "addressLine2": "string",
    "city": "string",
    "district": "string",
    "postalCode": "string",
    "country": "string"
  },
  "payment": {
    "id": "string",
    "status": "string",
    "createdAt": "timestamp"
  },
  "shipment": {
    "id": "string",
    "status": "string",
    "carrier": "string",
    "trackingNumber": "string",
    "estimatedDelivery": "timestamp"
  }
}
```

### 7.3. Cập nhật trạng thái đơn hàng

- **Method**: PUT
- **Endpoint**: `/orders/{id}/status`
- **Tham số**:
- **Path**: id - ID đơn hàng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "status": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "status": "string",
  "updatedAt": "timestamp"
}
```

### 7.4. Lấy đơn hàng của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/orders`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- status - Trạng thái đơn hàng (tùy chọn)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "createdAt": "timestamp",
      "status": "string",
      "total": "number",
      "itemCount": "number"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

### 7.5. Lấy đơn hàng của người bán

- **Method**: GET
- **Endpoint**: `/sellers/{sellerId}/orders`
- **Tham số**:
- **Path**: sellerId - ID người bán
- **Header**: Authorization: Bearer accessToken
- **Query**:
- status - Trạng thái đơn hàng (tùy chọn)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "userId": "string",
      "createdAt": "timestamp",
      "status": "string",
      "total": "number",
      "itemCount": "number",
      "user": {
        "id": "string",
        "fullName": "string"
      }
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

## 8. Payment Service (Dịch vụ Thanh toán)

**Trách nhiệm**: Xử lý các giao dịch thanh toán.

**Bảng dữ liệu**:

- `payments`

**APIs**:

### 8.1. Tạo thanh toán mới

- **Method**: POST
- **Endpoint**: `/payments`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "orderId": "string",
  "amount": "number",
  "paymentMethod": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "orderId": "string",
  "amount": "number",
  "status": "pending",
  "createdAt": "timestamp",
  "paymentMethod": "string",
  "paymentUrl": "string"
}
```

### 8.2. Lấy chi tiết thanh toán

- **Method**: GET
- **Endpoint**: `/payments/{id}`
- **Tham số**:
- **Path**: id - ID thanh toán
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "orderId": "string",
  "amount": "number",
  "status": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "paymentMethod": "string",
  "transactionId": "string"
}
```

### 8.3. Cập nhật trạng thái thanh toán

- **Method**: PUT
- **Endpoint**: `/payments/{id}/status`
- **Tham số**:
- **Path**: id - ID thanh toán
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "status": "string",
  "transactionId": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "status": "string",
  "updatedAt": "timestamp",
  "transactionId": "string"
}
```

### 8.4. Lấy thanh toán của đơn hàng

- **Method**: GET
- **Endpoint**: `/orders/{orderId}/payments`
- **Tham số**:
- **Path**: orderId - ID đơn hàng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "amount": "number",
    "status": "string",
    "createdAt": "timestamp",
    "paymentMethod": "string",
    "transactionId": "string"
  }
]
```

### 8.5. Webhook nhận thông báo thanh toán

- **Method**: POST
- **Endpoint**: `/payments/webhook/{provider}`
- **Tham số**:
- **Path**: provider - Nhà cung cấp dịch vụ thanh toán
- **Body**: Tùy thuộc vào nhà cung cấp
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "success": true
}
```

## 9. Shipping Service (Dịch vụ Vận chuyển)

**Trách nhiệm**: Quản lý thông tin vận chuyển và giao hàng.

**Bảng dữ liệu**:

- `shipments`

**APIs**:

### 9.1. Tạo vận chuyển mới

- **Method**: POST
- **Endpoint**: `/shipments`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "orderId": "string",
  "carrier": "string",
  "trackingNumber": "string",
  "estimatedDelivery": "timestamp"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "orderId": "string",
  "carrier": "string",
  "trackingNumber": "string",
  "status": "processing",
  "createdAt": "timestamp",
  "estimatedDelivery": "timestamp"
}
```

### 9.2. Lấy chi tiết vận chuyển

- **Method**: GET
- **Endpoint**: `/shipments/{id}`
- **Tham số**:
- **Path**: id - ID vận chuyển
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "orderId": "string",
  "carrier": "string",
  "trackingNumber": "string",
  "status": "string",
  "createdAt": "timestamp",
  "estimatedDelivery": "timestamp",
  "actualDelivery": "timestamp",
  "trackingHistory": [
    {
      "status": "string",
      "location": "string",
      "timestamp": "timestamp",
      "description": "string"
    }
  ]
}
```

### 9.3. Cập nhật trạng thái vận chuyển

- **Method**: PUT
- **Endpoint**: `/shipments/{id}/status`
- **Tham số**:
- **Path**: id - ID vận chuyển
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "status": "string",
  "actualDelivery": "timestamp"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "status": "string",
  "updatedAt": "timestamp",
  "actualDelivery": "timestamp"
}
```

### 9.4. Lấy vận chuyển của đơn hàng

- **Method**: GET
- **Endpoint**: `/orders/{orderId}/shipments`
- **Tham số**:
- **Path**: orderId - ID đơn hàng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "carrier": "string",
    "trackingNumber": "string",
    "status": "string",
    "createdAt": "timestamp",
    "estimatedDelivery": "timestamp",
    "actualDelivery": "timestamp"
  }
]
```

### 9.5. Webhook nhận cập nhật vận chuyển

- **Method**: POST
- **Endpoint**: `/shipments/webhook/{carrier}`
- **Tham số**:
- **Path**: carrier - Nhà vận chuyển
- **Body**: Tùy thuộc vào nhà vận chuyển
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "success": true
}
```

## 10. Review Service (Dịch vụ Đánh giá)

**Trách nhiệm**: Quản lý đánh giá và nhận xét sản phẩm.

**Bảng dữ liệu**:

- `reviews`
- `review_images`

**APIs**:

### 10.1. Tạo đánh giá mới

- **Method**: POST
- **Endpoint**: `/reviews`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "userId": "string",
  "productId": "string",
  "orderItemId": "string",
  "rating": "number",
  "comment": "string",
  "images": [
    {
      "imageUrl": "string"
    }
  ]
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "productId": "string",
  "orderItemId": "string",
  "rating": "number",
  "comment": "string",
  "createdAt": "timestamp",
  "isVerifiedPurchase": true,
  "images": [
    {
      "id": "string",
      "imageUrl": "string"
    }
  ]
}
```

### 10.2. Lấy chi tiết đánh giá

- **Method**: GET
- **Endpoint**: `/reviews/{id}`
- **Tham số**:
- **Path**: id - ID đánh giá
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "productId": "string",
  "orderItemId": "string",
  "rating": "number",
  "comment": "string",
  "createdAt": "timestamp",
  "isVerifiedPurchase": "boolean",
  "images": [
    {
      "id": "string",
      "imageUrl": "string"
    }
  ],
  "user": {
    "id": "string",
    "fullName": "string",
    "avatarUrl": "string"
  }
}
```

### 10.3. Cập nhật đánh giá

- **Method**: PUT
- **Endpoint**: `/reviews/{id}`
- **Tham số**:
- **Path**: id - ID đánh giá
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "rating": "number",
  "comment": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "rating": "number",
  "comment": "string",
  "updatedAt": "timestamp"
}
```

### 10.4. Xóa đánh giá

- **Method**: DELETE
- **Endpoint**: `/reviews/{id}`
- **Tham số**:
- **Path**: id - ID đánh giá
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 10.5. Lấy đánh giá của sản phẩm

- **Method**: GET
- **Endpoint**: `/products/{productId}/reviews`
- **Tham số**:
- **Path**: productId - ID sản phẩm
- **Query**:
- rating - Lọc theo số sao (tùy chọn)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- sort - Sắp xếp (newest, highestRating, lowestRating)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "userId": "string",
      "rating": "number",
      "comment": "string",
      "createdAt": "timestamp",
      "isVerifiedPurchase": "boolean",
      "images": [
        {
          "id": "string",
          "imageUrl": "string"
        }
      ],
      "user": {
        "id": "string",
        "fullName": "string",
        "avatarUrl": "string"
      }
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number",
  "ratingSummary": {
    "average": "number",
    "totalCount": "number",
    "ratingDistribution": {
      "5": "number",
      "4": "number",
      "3": "number",
      "2": "number",
      "1": "number"
    }
  }
}
```

### 10.6. Thêm hình ảnh vào đánh giá

- **Method**: POST
- **Endpoint**: `/reviews/{id}/images`
- **Tham số**:
- **Path**: id - ID đánh giá
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "imageUrl": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "reviewId": "string",
  "imageUrl": "string"
}
```

### 10.7. Xóa hình ảnh đánh giá

- **Method**: DELETE
- **Endpoint**: `/reviews/{id}/images/{imageId}`
- **Tham số**:
- **Path**:
- id - ID đánh giá
- imageId - ID hình ảnh
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

## 11. Promotion Service (Dịch vụ Khuyến mãi)

**Trách nhiệm**: Quản lý chương trình khuyến mãi và mã giảm giá.

**Bảng dữ liệu**:

- `promotions`
- `promotion_products`
- `user_promotions`
- `flash_sales`
- `flash_sale_items`

**APIs**:

### 11.1. Tạo khuyến mãi mới

- **Method**: POST
- **Endpoint**: `/promotions`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "description": "string",
  "startDate": "timestamp",
  "endDate": "timestamp",
  "promoType": "string",
  "discountValue": "number",
  "minPurchase": "number",
  "usageLimit": "number",
  "couponCode": "string",
  "isActive": "boolean"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "startDate": "timestamp",
  "endDate": "timestamp",
  "promoType": "string",
  "discountValue": "number",
  "minPurchase": "number",
  "usageLimit": "number",
  "usedCount": 0,
  "couponCode": "string",
  "isActive": "boolean"
}
```

### 11.2. Lấy chi tiết khuyến mãi

- **Method**: GET
- **Endpoint**: `/promotions/{id}`
- **Tham số**:
- **Path**: id - ID khuyến mãi
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "startDate": "timestamp",
  "endDate": "timestamp",
  "promoType": "string",
  "discountValue": "number",
  "minPurchase": "number",
  "usageLimit": "number",
  "usedCount": "number",
  "couponCode": "string",
  "isActive": "boolean",
  "products": [
    {
      "id": "string",
      "name": "string",
      "imageUrl": "string"
    }
  ]
}
```

### 11.3. Cập nhật khuyến mãi

- **Method**: PUT
- **Endpoint**: `/promotions/{id}`
- **Tham số**:
- **Path**: id - ID khuyến mãi
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "description": "string",
  "startDate": "timestamp",
  "endDate": "timestamp",
  "discountValue": "number",
  "minPurchase": "number",
  "usageLimit": "number",
  "isActive": "boolean"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "startDate": "timestamp",
  "endDate": "timestamp",
  "discountValue": "number",
  "minPurchase": "number",
  "usageLimit": "number",
  "isActive": "boolean"
}
```

### 11.4. Xóa khuyến mãi

- **Method**: DELETE
- **Endpoint**: `/promotions/{id}`
- **Tham số**:
- **Path**: id - ID khuyến mãi
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 11.5. Lấy khuyến mãi đang hoạt động

- **Method**: GET
- **Endpoint**: `/promotions/active`
- **Tham số**:
- **Query**:
- categoryId - ID danh mục (tùy chọn)
- productId - ID sản phẩm (tùy chọn)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "startDate": "timestamp",
    "endDate": "timestamp",
    "promoType": "string",
    "discountValue": "number",
    "minPurchase": "number",
    "couponCode": "string"
  }
]
```

### 11.6. Thêm sản phẩm vào khuyến mãi

- **Method**: POST
- **Endpoint**: `/promotions/{id}/products`
- **Tham số**:
- **Path**: id - ID khuyến mãi
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "productId": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "promotionId": "string",
  "productId": "string"
}
```

### 11.7. Xóa sản phẩm khỏi khuyến mãi

- **Method**: DELETE
- **Endpoint**: `/promotions/{id}/products/{productId}`
- **Tham số**:
- **Path**:
- id - ID khuyến mãi
- productId - ID sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 11.8. Gán khuyến mãi cho người dùng

- **Method**: POST
- **Endpoint**: `/users/{userId}/promotions/{promotionId}`
- **Tham số**:
- **Path**:
- userId - ID người dùng
- promotionId - ID khuyến mãi
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "promotionId": "string",
  "isUsed": false
}
```

### 11.9. Lấy khuyến mãi của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/promotions`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- isUsed - Lọc theo đã sử dụng (tùy chọn)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "promotionId": "string",
    "isUsed": "boolean",
    "usedAt": "timestamp",
    "promotion": {
      "name": "string",
      "description": "string",
      "endDate": "timestamp",
      "promoType": "string",
      "discountValue": "number",
      "minPurchase": "number",
      "couponCode": "string"
    }
  }
]
```

### 11.10. Tạo flash sale mới

- **Method**: POST
- **Endpoint**: `/flash-sales`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "description": "string",
  "startTime": "timestamp",
  "endTime": "timestamp",
  "status": "string",
  "maxItemsPerUser": "number"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "startTime": "timestamp",
  "endTime": "timestamp",
  "status": "string",
  "maxItemsPerUser": "number"
}
```

### 11.11. Lấy flash sale đang hoạt động

- **Method**: GET
- **Endpoint**: `/flash-sales/active`
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "startTime": "timestamp",
    "endTime": "timestamp",
    "status": "string",
    "maxItemsPerUser": "number",
    "items": [
      {
        "id": "string",
        "variantId": "string",
        "discountPercentage": "number",
        "discountedPrice": "number",
        "quantityLimit": "number",
        "quantitySold": "number",
        "product": {
          "id": "string",
          "name": "string",
          "imageUrl": "string",
          "originalPrice": "number"
        }
      }
    ]
  }
]
```

### 11.12. Thêm sản phẩm vào flash sale

- **Method**: POST
- **Endpoint**: `/flash-sales/{id}/items`
- **Tham số**:
- **Path**: id - ID flash sale
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "variantId": "string",
  "discountPercentage": "number",
  "discountedPrice": "number",
  "quantityLimit": "number"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "flashSaleId": "string",
  "variantId": "string",
  "discountPercentage": "number",
  "discountedPrice": "number",
  "quantityLimit": "number",
  "quantitySold": 0
}
```

## 12. Notification Service (Dịch vụ Thông báo)

**Trách nhiệm**: Gửi thông báo đến người dùng.

**Bảng dữ liệu**:

- `notifications`

**APIs**:

### 12.1. Tạo thông báo mới

- **Method**: POST
- **Endpoint**: `/notifications`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "userId": "string",
  "title": "string",
  "content": "string",
  "type": "string",
  "referenceId": "string",
  "referenceType": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "title": "string",
  "content": "string",
  "type": "string",
  "isRead": false,
  "createdAt": "timestamp",
  "referenceId": "string",
  "referenceType": "string"
}
```

### 12.2. Lấy thông báo của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/notifications`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- isRead - Lọc theo đã đọc (tùy chọn)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "title": "string",
      "content": "string",
      "type": "string",
      "isRead": "boolean",
      "createdAt": "timestamp",
      "referenceId": "string",
      "referenceType": "string"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number",
  "unreadCount": "number"
}
```

### 12.3. Đánh dấu thông báo đã đọc

- **Method**: PUT
- **Endpoint**: `/notifications/{id}/read`
- **Tham số**:
- **Path**: id - ID thông báo
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "isRead": true
}
```

### 12.4. Xóa thông báo

- **Method**: DELETE
- **Endpoint**: `/notifications/{id}`
- **Tham số**:
- **Path**: id - ID thông báo
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

## 13. Wishlist Service (Dịch vụ Danh sách yêu thích)

**Trách nhiệm**: Quản lý danh sách sản phẩm yêu thích.

**Bảng dữ liệu**:

- `wishlists`
- `wishlist_items`

**APIs**:

### 13.1. Tạo danh sách yêu thích mới

- **Method**: POST
- **Endpoint**: `/users/{userId}/wishlists`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "name": "string"
}
```

### 13.2. Lấy danh sách yêu thích của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/wishlists`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "itemCount": "number"
  }
]
```

### 13.3. Cập nhật danh sách yêu thích

- **Method**: PUT
- **Endpoint**: `/wishlists/{id}`
- **Tham số**:
- **Path**: id - ID danh sách yêu thích
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string"
}
```

### 13.4. Xóa danh sách yêu thích

- **Method**: DELETE
- **Endpoint**: `/wishlists/{id}`
- **Tham số**:
- **Path**: id - ID danh sách yêu thích
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 13.5. Thêm sản phẩm vào danh sách yêu thích

- **Method**: POST
- **Endpoint**: `/wishlists/{id}/items`
- **Tham số**:
- **Path**: id - ID danh sách yêu thích
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "productId": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "wishlistId": "string",
  "productId": "string",
  "addedAt": "timestamp"
}
```

### 13.6. Xóa sản phẩm khỏi danh sách yêu thích

- **Method**: DELETE
- **Endpoint**: `/wishlists/{id}/items/{productId}`
- **Tham số**:
- **Path**:
- id - ID danh sách yêu thích
- productId - ID sản phẩm
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

## 14. Messaging Service (Dịch vụ Tin nhắn)

**Trách nhiệm**: Hỗ trợ giao tiếp giữa người mua và người bán.

**Bảng dữ liệu**:

- `conversations`
- `messages`

**APIs**:

### 14.1. Tạo cuộc trò chuyện mới

- **Method**: POST
- **Endpoint**: `/conversations`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "userId": "string",
  "sellerId": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "sellerId": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "status": "active"
}
```

### 14.2. Lấy cuộc trò chuyện của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/conversations`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "sellerId": "string",
    "createdAt": "timestamp",
    "updatedAt": "timestamp",
    "status": "string",
    "lastMessage": {
      "content": "string",
      "createdAt": "timestamp",
      "senderType": "string"
    },
    "seller": {
      "id": "string",
      "sellerName": "string",
      "logoUrl": "string"
    },
    "unreadCount": "number"
  }
]
```

### 14.3. Lấy cuộc trò chuyện của người bán

- **Method**: GET
- **Endpoint**: `/sellers/{sellerId}/conversations`
- **Tham số**:
- **Path**: sellerId - ID người bán
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "userId": "string",
    "createdAt": "timestamp",
    "updatedAt": "timestamp",
    "status": "string",
    "lastMessage": {
      "content": "string",
      "createdAt": "timestamp",
      "senderType": "string"
    },
    "user": {
      "id": "string",
      "fullName": "string",
      "avatarUrl": "string"
    },
    "unreadCount": "number"
  }
]
```

### 14.4. Lấy tin nhắn trong cuộc trò chuyện

- **Method**: GET
- **Endpoint**: `/conversations/{id}/messages`
- **Tham số**:
- **Path**: id - ID cuộc trò chuyện
- **Header**: Authorization: Bearer accessToken
- **Query**:
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "senderId": "string",
      "senderType": "string",
      "content": "string",
      "createdAt": "timestamp",
      "isRead": "boolean",
      "attachmentUrl": "string"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

### 14.5. Gửi tin nhắn

- **Method**: POST
- **Endpoint**: `/conversations/{id}/messages`
- **Tham số**:
- **Path**: id - ID cuộc trò chuyện
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "senderId": "string",
  "senderType": "string",
  "content": "string",
  "attachmentUrl": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "conversationId": "string",
  "senderId": "string",
  "senderType": "string",
  "content": "string",
  "createdAt": "timestamp",
  "isRead": false,
  "attachmentUrl": "string"
}
```

### 14.6. Đánh dấu tin nhắn đã đọc

- **Method**: PUT
- **Endpoint**: `/messages/{id}/read`
- **Tham số**:
- **Path**: id - ID tin nhắn
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "isRead": true
}
```

## 15. Content Suggestion Service (Dịch vụ Gợi ý nội dung)

**Trách nhiệm**: Gợi ý nội dung phù hợp cho người dùng dựa trên hành vi và sở thích.

**Bảng dữ liệu**:

- `user_preferences`
- `content_suggestions`
- `user_interactions`

**APIs**:

### 15.1. Lấy sản phẩm gợi ý cho người dùng

- **Method**: GET
- **Endpoint**: `/suggestions/users/{userId}/products`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- limit - Số lượng (mặc định: 20)
- category - Danh mục (tùy chọn)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "productId": "string",
      "score": "number",
      "reason": "string",
      "product": {
        "id": "string",
        "name": "string",
        "basePrice": "number",
        "imageUrl": "string",
        "rating": "number"
      }
    }
  ],
  "total": "number"
}
```

### 15.2. Lấy danh mục gợi ý cho người dùng

- **Method**: GET
- **Endpoint**: `/suggestions/users/{userId}/categories`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- limit - Số lượng (mặc định: 10)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "categoryId": "string",
    "score": "number",
    "category": {
      "id": "string",
      "name": "string",
      "imageUrl": "string"
    }
  }
]
```

### 15.3. Lưu tương tác người dùng

- **Method**: POST
- **Endpoint**: `/suggestions/interactions`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "userId": "string",
  "entityId": "string",
  "entityType": "string",
  "interactionType": "string",
  "metadata": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "entityId": "string",
  "entityType": "string",
  "interactionType": "string",
  "createdAt": "timestamp"
}
```

### 15.4. Cập nhật sở thích người dùng

- **Method**: PUT
- **Endpoint**: `/suggestions/users/{userId}/preferences`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "preferences": [
    {
      "key": "string",
      "value": "string"
    }
  ]
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "userId": "string",
  "preferences": [
    {
      "key": "string",
      "value": "string"
    }
  ],
  "updatedAt": "timestamp"
}
```

### 15.5. Lấy sở thích người dùng

- **Method**: GET
- **Endpoint**: `/suggestions/users/{userId}/preferences`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "userId": "string",
  "preferences": [
    {
      "key": "string",
      "value": "string"
    }
  ],
  "updatedAt": "timestamp"
}
```

## 16. Content Moderation Service (Dịch vụ Kiểm duyệt nội dung)

**Trách nhiệm**: Hỗ trợ kiểm duyệt nội dung tự động để đảm bảo tuân thủ quy định.

**Bảng dữ liệu**:

- `moderation_requests`
- `moderation_results`
- `moderation_rules`

**APIs**:

### 16.1. Kiểm duyệt văn bản

- **Method**: POST
- **Endpoint**: `/moderation/text`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "text": "string",
  "contextType": "string",
  "entityId": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "isApproved": "boolean",
  "score": "number",
  "categories": [
    {
      "name": "string",
      "score": "number"
    }
  ],
  "flaggedContent": [
    {
      "text": "string",
      "category": "string",
      "score": "number"
    }
  ]
}
```

### 16.2. Kiểm duyệt hình ảnh

- **Method**: POST
- **Endpoint**: `/moderation/image`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "imageUrl": "string",
  "contextType": "string",
  "entityId": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "isApproved": "boolean",
  "score": "number",
  "categories": [
    {
      "name": "string",
      "score": "number"
    }
  ],
  "flaggedContent": [
    {
      "boundingBox": {
        "x": "number",
        "y": "number",
        "width": "number",
        "height": "number"
      },
      "category": "string",
      "score": "number"
    }
  ]
}
```

### 16.3. Lấy kết quả kiểm duyệt

- **Method**: GET
- **Endpoint**: `/moderation/results/{id}`
- **Tham số**:
- **Path**: id - ID kết quả kiểm duyệt
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "requestId": "string",
  "contentType": "string",
  "entityId": "string",
  "isApproved": "boolean",
  "score": "number",
  "categories": [
    {
      "name": "string",
      "score": "number"
    }
  ],
  "flaggedContent": [
    {
      "content": "string",
      "category": "string",
      "score": "number"
    }
  ],
  "createdAt": "timestamp"
}
```

### 16.4. Lấy quy tắc kiểm duyệt

- **Method**: GET
- **Endpoint**: `/moderation/rules`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Query**:
- contextType - Loại ngữ cảnh (tùy chọn)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "contextType": "string",
    "thresholds": {
      "categoryName": "number"
    },
    "isActive": "boolean"
  }
]
```

### 16.5. Cập nhật quy tắc kiểm duyệt

- **Method**: PUT
- **Endpoint**: `/moderation/rules/{id}`
- **Tham số**:
- **Path**: id - ID quy tắc
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "description": "string",
  "thresholds": {
    "categoryName": "number"
  },
  "isActive": "boolean"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "contextType": "string",
  "thresholds": {
    "categoryName": "number"
  },
  "isActive": "boolean",
  "updatedAt": "timestamp"
}
```

## 17. Scheduler Service (Dịch vụ Lịch trình)

**Trách nhiệm**: Lên lịch và thực hiện các tác vụ tự động như huỷ tài khoản, gửi email nhắc nhở.

**Bảng dữ liệu**:

- `scheduled_tasks`
- `task_executions`

**APIs**:

### 17.1. Tạo tác vụ lịch trình

- **Method**: POST
- **Endpoint**: `/scheduler/tasks`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "taskType": "string",
  "scheduledTime": "timestamp",
  "recurrence": "string",
  "data": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "taskType": "string",
  "scheduledTime": "timestamp",
  "recurrence": "string",
  "status": "pending",
  "createdAt": "timestamp"
}
```

### 17.2. Lấy danh sách tác vụ lịch trình

- **Method**: GET
- **Endpoint**: `/scheduler/tasks`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Query**:
- status - Trạng thái tác vụ (tùy chọn)
- taskType - Loại tác vụ (tùy chọn)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "taskType": "string",
      "scheduledTime": "timestamp",
      "recurrence": "string",
      "status": "string",
      "createdAt": "timestamp",
      "lastExecutedAt": "timestamp"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

### 17.3. Lấy chi tiết tác vụ lịch trình

- **Method**: GET
- **Endpoint**: `/scheduler/tasks/{id}`
- **Tham số**:
- **Path**: id - ID tác vụ
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "taskType": "string",
  "scheduledTime": "timestamp",
  "recurrence": "string",
  "status": "string",
  "data": {
    "key1": "value1",
    "key2": "value2"
  },
  "createdAt": "timestamp",
  "lastExecutedAt": "timestamp",
  "executions": [
    {
      "id": "string",
      "status": "string",
      "startedAt": "timestamp",
      "completedAt": "timestamp",
      "result": "string"
    }
  ]
}
```

### 17.4. Cập nhật tác vụ lịch trình

- **Method**: PUT
- **Endpoint**: `/scheduler/tasks/{id}`
- **Tham số**:
- **Path**: id - ID tác vụ
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "scheduledTime": "timestamp",
  "recurrence": "string",
  "status": "string",
  "data": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "scheduledTime": "timestamp",
  "recurrence": "string",
  "status": "string",
  "updatedAt": "timestamp"
}
```

### 17.5. Xóa tác vụ lịch trình

- **Method**: DELETE
- **Endpoint**: `/scheduler/tasks/{id}`
- **Tham số**:
- **Path**: id - ID tác vụ
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 17.6. Thực thi tác vụ ngay lập tức

- **Method**: POST
- **Endpoint**: `/scheduler/tasks/{id}/execute`
- **Tham số**:
- **Path**: id - ID tác vụ
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 202 Accepted
- **Response**:

```json
{
  "id": "string",
  "taskId": "string",
  "status": "processing",
  "startedAt": "timestamp"
}
```

## 18. Internationalization Service (Dịch vụ Đa ngôn ngữ)

**Trách nhiệm**: Hỗ trợ nhiều ngôn ngữ khác nhau cho nền tảng.

**Bảng dữ liệu**:

- `languages`
- `translations`

**APIs**:

### 18.1. Lấy danh sách ngôn ngữ

- **Method**: GET
- **Endpoint**: `/languages`
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "code": "string",
    "name": "string",
    "isActive": "boolean"
  }
]
```

### 18.2. Lấy bản dịch

- **Method**: GET
- **Endpoint**: `/translations/{languageId}/{entityType}/{entityId}`
- **Tham số**:
- **Path**:
- languageId - ID ngôn ngữ
- entityType - Loại thực thể (product, category, etc.)
- entityId - ID thực thể
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "fieldName": "string",
    "translatedText": "string"
  }
]
```

### 18.3. Thêm bản dịch

- **Method**: POST
- **Endpoint**: `/translations`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "languageId": "string",
  "entityType": "string",
  "entityId": "string",
  "fieldName": "string",
  "translatedText": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "languageId": "string",
  "entityType": "string",
  "entityId": "string",
  "fieldName": "string",
  "translatedText": "string"
}
```

### 18.4. Cập nhật bản dịch

- **Method**: PUT
- **Endpoint**: `/translations/{id}`
- **Tham số**:
- **Path**: id - ID bản dịch
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "translatedText": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "translatedText": "string"
}
```

## 19. Referral Service (Dịch vụ Giới thiệu)

**Trách nhiệm**: Quản lý chương trình giới thiệu bạn bè và phần thưởng.

**Bảng dữ liệu**:

- `referrals`

**APIs**:

### 19.1. Tạo giới thiệu mới

- **Method**: POST
- **Endpoint**: `/referrals`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "referrerId": "string",
  "referredId": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "referrerId": "string",
  "referredId": "string",
  "status": "pending",
  "createdAt": "timestamp"
}
```

### 19.2. Lấy giới thiệu của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/referrals`
- **Tham số**:
- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:
- status - Trạng thái giới thiệu (tùy chọn)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "referredId": "string",
      "status": "string",
      "createdAt": "timestamp",
      "convertedAt": "timestamp",
      "rewardAmount": "number",
      "rewardStatus": "string",
      "referredUser": {
        "id": "string",
        "fullName": "string",
        "email": "string"
      }
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number",
  "summary": {
    "totalReferrals": "number",
    "convertedReferrals": "number",
    "totalRewards": "number"
  }
}
```

### 19.3. Cập nhật trạng thái giới thiệu

- **Method**: PUT
- **Endpoint**: `/referrals/{id}/status`
- **Tham số**:
- **Path**: id - ID giới thiệu
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "status": "string",
  "convertedAt": "timestamp"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "status": "string",
  "convertedAt": "timestamp"
}
```

### 19.4. Xử lý phần thưởng giới thiệu

- **Method**: POST
- **Endpoint**: `/referrals/{id}/reward`
- **Tham số**:
- **Path**: id - ID giới thiệu
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "rewardAmount": "number",
  "rewardStatus": "string"
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "rewardAmount": "number",
  "rewardStatus": "string"
}
```

## 20. Media Service (Dịch vụ Media)

**Trách nhiệm**: Quản lý các tài nguyên đa phương tiện như ảnh, video và tài liệu.

**Bảng dữ liệu**:

- `media_files`
- `media_folders`

**APIs**:

### 20.1. Tải lên tệp media

- **Method**: POST
- **Endpoint**: `/media/upload`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**: Form-data với các trường:
- file - Tệp cần tải lên
- folderId - ID thư mục (tùy chọn)
- description - Mô tả (tùy chọn)
- tags - Thẻ (tùy chọn)
- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "fileName": "string",
  "fileType": "string",
  "fileSize": "number",
  "url": "string",
  "thumbnailUrl": "string",
  "folderId": "string",
  "description": "string",
  "tags": ["string"],
  "uploadedAt": "timestamp",
  "dimensions": {
    "width": "number",
    "height": "number"
  }
}
```

### 20.2. Lấy danh sách tệp media

- **Method**: GET
- **Endpoint**: `/media/files`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Query**:
- folderId - ID thư mục (tùy chọn)
- fileType - Loại tệp (tùy chọn)
- search - Từ khóa tìm kiếm (tùy chọn)
- page - Số trang (mặc định: 1)
- limit - Số lượng mỗi trang (mặc định: 20)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "items": [
    {
      "id": "string",
      "fileName": "string",
      "fileType": "string",
      "fileSize": "number",
      "url": "string",
      "thumbnailUrl": "string",
      "folderId": "string",
      "uploadedAt": "timestamp"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

### 20.3. Lấy chi tiết tệp media

- **Method**: GET
- **Endpoint**: `/media/files/{id}`
- **Tham số**:
- **Path**: id - ID tệp
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "fileName": "string",
  "fileType": "string",
  "fileSize": "number",
  "url": "string",
  "thumbnailUrl": "string",
  "folderId": "string",
  "description": "string",
  "tags": ["string"],
  "uploadedAt": "timestamp",
  "dimensions": {
    "width": "number",
    "height": "number"
  },
  "metadata": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

### 20.4. Cập nhật thông tin tệp media

- **Method**: PUT
- **Endpoint**: `/media/files/{id}`
- **Tham số**:
- **Path**: id - ID tệp
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "fileName": "string",
  "folderId": "string",
  "description": "string",
  "tags": ["string"]
}
```

- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "fileName": "string",
  "folderId": "string",
  "description": "string",
  "tags": ["string"],
  "updatedAt": "timestamp"
}
```

### 20.5. Xóa tệp media

- **Method**: DELETE
- **Endpoint**: `/media/files/{id}`
- **Tham số**:
- **Path**: id - ID tệp
- **Header**: Authorization: Bearer accessToken
- **Output thành công**:
- **Status**: 204 No Content

### 20.6. Tạo thư mục media

- **Method**: POST
- **Endpoint**: `/media/folders`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "name": "string",
  "parentId": "string",
  "description": "string"
}
```

- **Output thành công**:
- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "name": "string",
  "parentId": "string",
  "description": "string",
  "createdAt": "timestamp"
}
```

### 20.7. Lấy danh sách thư mục media

- **Method**: GET
- **Endpoint**: `/media/folders`
- **Tham số**:
- **Header**: Authorization: Bearer accessToken
- **Query**:
- parentId - ID thư mục cha (tùy chọn)
- **Output thành công**:
- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "parentId": "string",
    "description": "string",
    "createdAt": "timestamp",
    "fileCount": "number"
  }
]
```
