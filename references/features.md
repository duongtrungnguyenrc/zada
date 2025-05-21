### Kiến Trúc Microservices Chi Tiết cho Nền Tảng Thương Mại Điện Tử

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

- **Status**: 400 Bad Request (email đã tồn tại)

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

**Trách nhiệm**: Quản lý giỏ hàng và các mặt hàng trong giỏ hàng.

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

**Trách nhiệm**: Quản lý đơn hàng và các mặt hàng trong đơn hàng.

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

- status - Tr���ng thái đơn hàng (tùy chọn)
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

**Trách nhiệm**: Xử lý thanh toán và theo dõi trạng thái thanh toán.

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

**Trách nhiệm**: Quản lý vận chuyển và theo dõi trạng thái giao hàng.

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

**Trách nhiệm**: Quản lý đánh giá sản phẩm và hình ảnh đánh giá.

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

**Trách nhiệm**: Quản lý khuyến mãi, mã giảm giá, và flash sale.

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

**Trách nhiệm**: Quản lý thông báo cho người dùng.

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

**Trách nhiệm**: Quản lý danh sách yêu thích của người dùng.

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

**Trách nhiệm**: Quản lý tin nhắn giữa người dùng và người bán.

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

## 15. Return & Refund Service (Dịch vụ Trả hàng & Hoàn tiền)

**Trách nhiệm**: Quản lý yêu cầu trả hàng và hoàn tiền.

**Bảng dữ liệu**:

- `returns`
- `return_items`

**APIs**:

### 15.1. Tạo yêu cầu trả hàng

- **Method**: POST
- **Endpoint**: `/returns`
- **Tham số**:

- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "orderId": "string",
  "userId": "string",
  "reason": "string",
  "items": [
    {
      "orderItemId": "string",
      "quantity": "number",
      "condition": "string",
      "reasonDetails": "string"
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
  "orderId": "string",
  "userId": "string",
  "reason": "string",
  "status": "pending",
  "createdAt": "timestamp",
  "items": [
    {
      "id": "string",
      "orderItemId": "string",
      "quantity": "number",
      "condition": "string",
      "reasonDetails": "string"
    }
  ]
}
```

### 15.2. Lấy chi tiết yêu cầu trả hàng

- **Method**: GET
- **Endpoint**: `/returns/{id}`
- **Tham số**:

- **Path**: id - ID yêu cầu trả hàng
- **Header**: Authorization: Bearer accessToken

- **Output thành công**:

- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "orderId": "string",
  "userId": "string",
  "reason": "string",
  "status": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "refundAmount": "number",
  "items": [
    {
      "id": "string",
      "orderItemId": "string",
      "quantity": "number",
      "condition": "string",
      "reasonDetails": "string",
      "product": {
        "id": "string",
        "name": "string",
        "imageUrl": "string"
      }
    }
  ],
  "order": {
    "id": "string",
    "createdAt": "timestamp",
    "total": "number"
  }
}
```

### 15.3. Cập nhật trạng thái yêu cầu trả hàng

- **Method**: PUT
- **Endpoint**: `/returns/{id}/status`
- **Tham số**:

- **Path**: id - ID yêu cầu trả hàng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "status": "string",
  "refundAmount": "number"
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
  "refundAmount": "number"
}
```

### 15.4. Lấy yêu cầu trả hàng của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/returns`
- **Tham số**:

- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:

- status - Trạng thái yêu cầu (tùy chọn)
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
      "orderId": "string",
      "reason": "string",
      "status": "string",
      "createdAt": "timestamp",
      "refundAmount": "number",
      "itemCount": "number"
    }
  ],
  "total": "number",
  "page": "number",
  "limit": "number",
  "totalPages": "number"
}
```

### 15.5. Lấy yêu cầu trả hàng của người bán

- **Method**: GET
- **Endpoint**: `/sellers/{sellerId}/returns`
- **Tham số**:

- **Path**: sellerId - ID người bán
- **Header**: Authorization: Bearer accessToken
- **Query**:

- status - Trạng thái yêu cầu (tùy chọn)
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
      "orderId": "string",
      "userId": "string",
      "reason": "string",
      "status": "string",
      "createdAt": "timestamp",
      "refundAmount": "number",
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

## 16. Dispute Resolution Service (Dịch vụ Giải quyết Tranh chấp)

**Trách nhiệm**: Quản lý tranh chấp giữa người dùng và người bán.

**Bảng dữ liệu**:

- `disputes`
- `dispute_messages`

**APIs**:

### 16.1. Tạo tranh chấp mới

- **Method**: POST
- **Endpoint**: `/disputes`
- **Tham số**:

- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "orderId": "string",
  "userId": "string",
  "sellerId": "string",
  "issueType": "string",
  "message": "string"
}
```

- **Output thành công**:

- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "orderId": "string",
  "userId": "string",
  "sellerId": "string",
  "issueType": "string",
  "status": "open",
  "createdAt": "timestamp",
  "firstMessage": {
    "id": "string",
    "senderId": "string",
    "senderType": "user",
    "message": "string",
    "createdAt": "timestamp"
  }
}
```

### 16.2. Lấy chi tiết tranh chấp

- **Method**: GET
- **Endpoint**: `/disputes/{id}`
- **Tham số**:

- **Path**: id - ID tranh chấp
- **Header**: Authorization: Bearer accessToken

- **Output thành công**:

- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "orderId": "string",
  "userId": "string",
  "sellerId": "string",
  "issueType": "string",
  "status": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "resolution": "string",
  "resolvedAt": "timestamp",
  "order": {
    "id": "string",
    "createdAt": "timestamp",
    "total": "number"
  },
  "user": {
    "id": "string",
    "fullName": "string"
  },
  "seller": {
    "id": "string",
    "sellerName": "string"
  },
  "messages": [
    {
      "id": "string",
      "senderId": "string",
      "senderType": "string",
      "message": "string",
      "createdAt": "timestamp",
      "attachmentUrl": "string"
    }
  ]
}
```

### 16.3. Cập nhật trạng thái tranh chấp

- **Method**: PUT
- **Endpoint**: `/disputes/{id}/status`
- **Tham số**:

- **Path**: id - ID tranh chấp
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "status": "string",
  "resolution": "string"
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
  "resolution": "string",
  "resolvedAt": "timestamp"
}
```

### 16.4. Lấy tranh chấp của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/disputes`
- **Tham số**:

- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Query**:

- status - Trạng thái tranh chấp (tùy chọn)
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
      "orderId": "string",
      "sellerId": "string",
      "issueType": "string",
      "status": "string",
      "createdAt": "timestamp",
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

### 16.5. Lấy tranh chấp của người bán

- **Method**: GET
- **Endpoint**: `/sellers/{sellerId}/disputes`
- **Tham số**:

- **Path**: sellerId - ID người bán
- **Header**: Authorization: Bearer accessToken
- **Query**:

- status - Trạng thái tranh chấp (tùy chọn)
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
      "orderId": "string",
      "userId": "string",
      "issueType": "string",
      "status": "string",
      "createdAt": "timestamp",
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

### 16.6. Thêm tin nhắn vào tranh chấp

- **Method**: POST
- **Endpoint**: `/disputes/{id}/messages`
- **Tham số**:

- **Path**: id - ID tranh chấp
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "senderId": "string",
  "senderType": "string",
  "message": "string",
  "attachmentUrl": "string"
}
```

- **Output thành công**:

- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "disputeId": "string",
  "senderId": "string",
  "senderType": "string",
  "message": "string",
  "createdAt": "timestamp",
  "attachmentUrl": "string"
}
```

## 17. Analytics Service (Dịch vụ Phân tích)

**Trách nhiệm**: Thu thập và phân tích dữ liệu người dùng và sản phẩm.

**Bảng dữ liệu**:

- `search_logs`
- `product_views`
- `user_activities`

**APIs**:

### 17.1. Ghi lại truy vấn tìm kiếm

- **Method**: POST
- **Endpoint**: `/analytics/search`
- **Tham số**:

- **Body**:

```json
{
  "userId": "string",
  "query": "string"
}
```

- **Output thành công**:

- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "query": "string",
  "createdAt": "timestamp"
}
```

### 17.2. Ghi lại lượt xem sản phẩm

- **Method**: POST
- **Endpoint**: `/analytics/product-view`
- **Tham số**:

- **Body**:

```json
{
  "userId": "string",
  "productId": "string",
  "durationSeconds": "number"
}
```

- **Output thành công**:

- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "productId": "string",
  "viewCount": "number",
  "lastViewed": "timestamp",
  "durationSeconds": "number"
}
```

### 17.3. Lấy sản phẩm thịnh hành

- **Method**: GET
- **Endpoint**: `/analytics/trending-products`
- **Tham số**:

- **Query**:

- categoryId - ID danh mục (tùy chọn)
- limit - Số lượng (mặc định: 10)
- period - Khoảng thời gian (day, week, month)

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
    "viewCount": "number",
    "soldCount": "number",
    "category": {
      "id": "string",
      "name": "string"
    },
    "seller": {
      "id": "string",
      "sellerName": "string"
    }
  }
]
```

### 17.4. Lấy từ khóa tìm kiếm phổ biến

- **Method**: GET
- **Endpoint**: `/analytics/popular-searches`
- **Tham số**:

- **Query**:

- limit - Số lượng (mặc định: 10)
- period - Khoảng thời gian (day, week, month)

- **Output thành công**:

- **Status**: 200 OK
- **Response**:

```json
[
  {
    "query": "string",
    "count": "number"
  }
]
```

## 18. Internationalization Service (Dịch vụ Đa ngôn ngữ)

**Trách nhiệm**: Quản lý bản dịch và hỗ trợ đa ngôn ngữ.

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

**Trách nhiệm**: Quản lý chương trình giới thiệu và phần thưởng.

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

## 20. Subscription Service (Dịch vụ Đăng ký)

**Trách nhiệm**: Quản lý gói đăng ký và thanh toán định kỳ.

**Bảng dữ liệu**:

- `subscription_plans`
- `user_subscriptions`

**APIs**:

### 20.1. Lấy danh sách gói đăng ký

- **Method**: GET
- **Endpoint**: `/subscription-plans`
- **Output thành công**:

- **Status**: 200 OK
- **Response**:

```json
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "price": "number",
    "durationDays": "number",
    "features": "string",
    "isActive": "boolean"
  }
]
```

### 20.2. Đăng ký gói cho người dùng

- **Method**: POST
- **Endpoint**: `/users/{userId}/subscriptions`
- **Tham số**:

- **Path**: userId - ID người dùng
- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "planId": "string",
  "paymentMethod": "string",
  "autoRenew": "boolean"
}
```

- **Output thành công**:

- **Status**: 201 Created
- **Response**:

```json
{
  "id": "string",
  "userId": "string",
  "planId": "string",
  "startDate": "timestamp",
  "endDate": "timestamp",
  "status": "active",
  "autoRenew": "boolean",
  "paymentMethod": "string",
  "plan": {
    "name": "string",
    "price": "number",
    "features": "string"
  }
}
```

### 20.3. Lấy đăng ký của người dùng

- **Method**: GET
- **Endpoint**: `/users/{userId}/subscriptions`
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
    "planId": "string",
    "startDate": "timestamp",
    "endDate": "timestamp",
    "status": "string",
    "autoRenew": "boolean",
    "paymentMethod": "string",
    "plan": {
      "id": "string",
      "name": "string",
      "price": "number",
      "features": "string"
    }
  }
]
```

### 20.4. Cập nhật đăng ký

- **Method**: PUT
- **Endpoint**: `/users/{userId}/subscriptions/{subscriptionId}`
- **Tham số**:

- **Path**:

- userId - ID người dùng
- subscriptionId - ID đăng ký

- **Header**: Authorization: Bearer accessToken
- **Body**:

```json
{
  "autoRenew": "boolean",
  "paymentMethod": "string"
}
```

- **Output thành công**:

- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "autoRenew": "boolean",
  "paymentMethod": "string"
}
```

### 20.5. Hủy đăng ký

- **Method**: DELETE
- **Endpoint**: `/users/{userId}/subscriptions/{subscriptionId}`
- **Tham số**:

- **Path**:

- userId - ID người dùng
- subscriptionId - ID đăng ký

- **Header**: Authorization: Bearer accessToken

- **Output thành công**:

- **Status**: 200 OK
- **Response**:

```json
{
  "id": "string",
  "status": "cancelled",
  "endDate": "timestamp"
}
```
