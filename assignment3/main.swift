import Foundation

// Part 1: Product Models (35 points)
// 1.1 Product Struct

struct Product {
    let id: String
    let name: String
    let price: Double
    let category: Category
    let description: String
    
    enum Category {
        case electronics
        case books
        case clothing
        case food
    }
    
    var displayPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: price)) ?? "$\(price)"
    }
    
    
    init?(id: String, name: String, price: Double, category: Category, description: String) {
        guard price > 0 else {
            print("Price must be positive!!!")
            return nil
        }
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.description = description
    }
}

// 1.2 CartItem Struct

struct CartItem {
    let product: Product
    private(set) var quantity: Int
    
    var subtotal: Double {
        product.price * Double(quantity)
    }
    
    init?(product: Product, quantity: Int) {
            guard quantity > 0 else { return nil }
            self.product = product
            self.quantity = quantity
        }
    
    mutating func updateQuantity(_ newQuantity: Int) {
        guard newQuantity > 0 else { return }
        self.quantity = newQuantity
    }
    
    mutating func increaseQuantity(by amount: Int) {
        guard amount > 0 else { return }
        self.quantity += amount
    }
}

// Part 2: Shopping Cart Class (35 points)

// TODO: Implement ShoppingCart class
class ShoppingCart {
    private(set) var items: [CartItem] = []
    var discountCode: String?
    
    init() {
        self.items = []
    }
    
    func addItem(product: Product, quantity: Int = 1) {
        guard quantity > 0 else { return }
        
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].increaseQuantity(by: quantity)
        } else {
            if let newItem = CartItem(product: product, quantity: quantity) {
                items.append(newItem)
            }
        }
    }
    
    func removeItem(productId: String) {
        items.removeAll { $0.product.id == productId }
    }
    
    func updateItemQuantity(productId: String, quantity: Int) {
        if let index = items.firstIndex(where: { $0.product.id == productId }) {
            if quantity <= 0 {
                removeItem(productId: productId)
            } else {
                items[index].updateQuantity(quantity)
            }
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    var subtotal: Double {
        return items.reduce(0) { $0 + $1.subtotal }
    }
    
    var discountAmount: Double {
        guard let code = discountCode else { return 0 }
        switch code.uppercased() {
        case "SAVE10":
            return subtotal * 0.1
        case "SAVE20":
            return subtotal * 0.2
        default:
            return 0
        }
        
    }
    
    var total: Double {
        return max(0, subtotal - discountAmount)
    }
    
    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
}

// Part 3: Order & Address (20 points)
// 3.1 Address Struct

struct Address {
    let street: String
    let city: String
    let zipCode: String
    let country: String
    
    var formattedAddress: String {
        """
        \(street)
        \(city), \(zipCode)
        \(country)
        """
    }
}

// 3.2 Order Struct
// TODO: Implement Order struct
struct Order {
    let orderId: String
    let items: [CartItem]
    let subtotal: Double
    let discountAmount: Double
    let total: Double
    let timestamp: Date
    let shippingAddress: Address
    
    init(from cart: ShoppingCart, shippingAddress: Address) {
        self.orderId = UUID().uuidString
        self.items = cart.items.map { $0 } // snapshot copy of cart items
        self.subtotal = cart.subtotal
        self.discountAmount = cart.discountAmount
        self.total = cart.total
        self.timestamp = Date()
        self.shippingAddress = shippingAddress
    }
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
}

// Part 4: Testing & Demonstrations (10 points)
// 1. Create sample products
let laptop = Product(id: "p_laptop", name: "Laptop Pro", price: 1999.99, category: .electronics, description: "High-end laptop")!
let book = Product(id: "p_book", name: "Swift Programming", price: 39.99, category: .books, description: "Learn Swift")!
let headphones = Product(id: "p_headphones", name: "NoiseCancel 3000", price: 149.99, category: .electronics, description: "Wireless headphones")!

print("1) Created products:")
print("- \(laptop.name) \(laptop.displayPrice)")
print("- \(book.name) \(book.displayPrice)")
print("- \(headphones.name) \(headphones.displayPrice)\n")

// 2. Test adding items to cart
let cart = ShoppingCart()
cart.addItem(product: laptop, quantity: 1)
cart.addItem(product: book, quantity: 2)

print("2) After adding laptop x1 and book x2:")
for item in cart.items {
    print("- \(item.product.name) x \(item.quantity) -> subtotal: \(item.subtotal)")
}
print("Cart itemCount: \(cart.itemCount)\n")

// 3. Test adding same product twice (should update quantity)
cart.addItem(product: laptop, quantity: 1)
// Verify laptop quantity is now 2
if let laptopIndex = cart.items.firstIndex(where: { $0.product.id == laptop.id }) {
    print("3) Added laptop again. Laptop quantity now: \(cart.items[laptopIndex].quantity) (expected 2)\n")
} else {
    print("3) ERROR: laptop not found in cart after adding twice\n")
}

// 4. Test cart calculations
print("4) Cart calculations:")
print("Subtotal: \(cart.subtotal)") // laptop 2 * 1999.99 + book 2 * 39.99
print("Item count: \(cart.itemCount)\n")

// 5. Test discount code
cart.discountCode = "SAVE10"
print("5) Applied discount code SAVE10")
print("Subtotal: \(cart.subtotal)")
print("Discount amount: \(cart.discountAmount)")
print("Total with discount: \(cart.total)\n")

// 6. Test removing items
cart.removeItem(productId: book.id)
print("6) Removed book from cart.")
print("Cart items now:")
for item in cart.items {
    print("- \(item.product.name) x \(item.quantity)")
}
print("Item count: \(cart.itemCount)\n")

// 7. Demonstrate REFERENCE TYPE behavior
func modifyCart(_ cartParam: ShoppingCart) {
    cartParam.addItem(product: headphones, quantity: 1)
}
modifyCart(cart)
print("7) After modifyCart(cart) where function adds headphones:")
print("Cart items now:")
for item in cart.items {
    print("- \(item.product.name) x \(item.quantity)")
}
print("This shows ShoppingCart is a reference type (change visible outside function).\n")

// 8. Demonstrate VALUE TYPE behavior
var item1 = CartItem(product: laptop, quantity: 1)!
var item2 = item1
item2.updateQuantity(5)
print("8) Value-type behavior (CartItem is struct):")
print("item1 quantity: \(item1.quantity) (expected 1)")
print("item2 quantity: \(item2.quantity) (expected 5)\n")

// 9. Create order from cart
let address = Address(street: "123 Main St", city: "Springfield", zipCode: "12345", country: "USA")
let order = Order(from: cart, shippingAddress: address)
print("9) Created order from cart:")
print("Order ID: \(order.orderId)")
print("Order timestamp: \(order.timestamp)")
print("Order shipping address:\n\(order.shippingAddress.formattedAddress)")
print("Order items:")
for item in order.items {
    print("- \(item.product.name) x \(item.quantity) -> subtotal: \(item.subtotal)")
}
print("Order total: \(order.total)\n")

// 10. Modify cart after order creation
cart.clearCart()
print("10) Cleared the cart after creating order.")
print("Cart items count after clear: \(cart.itemCount) (expected 0)")
print("Order items count (should remain unchanged snapshot): \(order.itemCount) (expected > 0)\n")



