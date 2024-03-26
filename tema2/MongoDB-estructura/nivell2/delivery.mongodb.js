// Database name, it will create the database if it doesn't exist
const database = 'delivery';
// Use the database
use(database);

db.createCollection('clients', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'clients',
            required: ['name', 'surname', 'address', 'zip_code', 'city', 'province', 'phone_number'],
            properties: {
                name: {
                    bsonType: 'string'
                },
                surname: {
                    bsonType: 'string'
                },
                address: {
                    bsonType: 'string'
                },
                zip_code: {
                    bsonType: 'int'
                },
                city: {
                    bsonType: 'string'
                },
                province: {
                    bsonType: 'string'
                },
                phone_number: {
                    bsonType: 'string'
                }
            }
        }
    },
    autoIndexId: true
});
db.createCollection('orders', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'orders',
            required: ['date_time', 'delivery_type', 'total_price', 'extra_information', 'products_included', 'client_id', 'store_id'],
            properties: {
                date_time: {
                    bsonType: 'date'
                },
                delivery_type: {
                    enum: ['repartiment a domicili', 'recollir en botiga']
                },
                total_price: {
                    bsonType: 'decimal'
                },
                extra_information: {
                    bsonType: 'string'
                },
                products_included: {
                    bsonType: 'array'
                },
                client_id: {
                    bsonType: 'objectId'
                },
                store_id: {
                    bsonType: 'objectId'
                }
            }
        }
    },
    autoIndexId: true
});
db.createCollection('products', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'products',
            required: ['type', 'pizza_category', 'name', 'description', 'image', 'price'],
            properties: {
                type: {
                    enum: ['pizza', 'hamburguesa', 'beguda']
                },
                pizza_category: {
                    bsonType: 'string'
                },
                name: {
                    bsonType: 'string'
                },
                description: {
                    bsonType: 'string'
                },
                image: {
                    bsonType: 'string'
                },
                price: {
                    bsonType: 'decimal'
                }
            }
        }
    },
    autoIndexId: true
});
db.createCollection('stores', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'stores',
            required: ['address', 'zip_code', 'city', 'province'],
            properties: {
                address: {
                    bsonType: 'string'
                },
                zip_code: {
                    bsonType: 'int'
                },
                city: {
                    bsonType: 'string'
                },
                province: {
                    bsonType: 'string'
                }
            }
        }
    }
});
db.createCollection('employees', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'employees',
            required: ['name', 'surname', 'NIF', 'phone_number', 'role', 'store_id'],
            properties: {
                name: {
                    bsonType: 'string'
                },
                surname: {
                    bsonType: 'string'
                },
                NIF: {
                    bsonType: 'string'
                },
                phone_number: {
                    bsonType: 'string'
                },
                role: {
                    enum: ['cuiner/a', 'repartidor/a']
                },
                store_id: {
                    bsonType: 'objectId'
                }
            }
        }
    }
});
db.createCollection('delivery_orders', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'delivery_orders',
            required: ['order_id', 'employee_id', 'date_time_delivered'],
            properties: {
                order_id: {
                    bsonType: 'objectId'
                },
                employee_id: {
                    bsonType: 'objectId'
                },
                date_time_delivered: {
                    bsonType: 'date'
                }
            }
        }
    }
});


// Insert into clients
db.clients.insertOne({
    name: 'John',
    surname: 'Doe',
    address: '123 Main St',
    zip_code: 12345,
    city: 'Barcelona',
    province: 'Barcelona',
    phone_number: '123-456-7890'
});

// Insert into stores
let storeId = db.stores.insertOne({
    address: '456 Market St',
    zip_code: 67890,
    city: 'Barcelona',
    province: 'Barcelona'
}).insertedId;

// Insert into employees
let employeeId = db.employees.insertOne({
    name: 'Jane',
    surname: 'Doe',
    NIF: 'XYZ123',
    phone_number: '098-765-4321',
    role: 'repartidor/a',
    store_id: storeId
}).insertedId;

// Insert into products
let productId = db.products.insertOne({
    type: 'pizza',
    pizza_category: 'Vegetarian',
    name: 'Veggie Delight',
    description: 'A delicious vegetarian pizza',
    image: 'http://example.com/veggie-delight.jpg',
    price: NumberDecimal("9.99")
}).insertedId;

// Insert into orders
let clientId = db.clients.findOne()._id;
let orderId = db.orders.insertOne({
    date_time: new Date(),
    delivery_type: 'repartiment a domicili',
    total_price: NumberDecimal("9.99"),
    extra_information: 'No cheese',
    products_included: [productId],
    client_id: clientId,
    store_id: storeId
}).insertedId;

// Insert into delivery_orders
db.delivery_orders.insertOne({
    order_id: orderId,
    employee_id: employeeId,
    date_time_delivered: new Date()
});