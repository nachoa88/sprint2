// First, let's drop the database to start fresh.
// db.dropDatabase();

// Database name, it will create the database if it doesn't exist
const database = 'optica';
// Use the database
use(database);

// SUPPLIERS DATABASE
db.createCollection('suppliers', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'suppliers',
      required: ['name', 'address', 'phone_number', 'fax', 'NIF'],
      properties: {
        name: {
          bsonType: 'string'
        },
        address: {
          bsonType: 'object',
          title: 'object',
          properties: {
            street: {
              bsonType: 'string'
            },
            number: {
              bsonType: 'int'
            },
            floor: {
              bsonType: 'string'
            },
            door: {
              bsonType: 'string'
            },
            city: {
              bsonType: 'string'
            },
            zip_code: {
              bsonType: 'int'
            },
            country: {
              bsonType: 'string'
            }
          }
        },
        phone_number: {
          bsonType: 'string'
        },
        fax: {
          bsonType: 'string'
        },
        NIF: {
          bsonType: 'string'
        }
      }
    }
  },
  autoIndexId: true,
  validationLevel: 'off',
  validationAction: 'warn'
});

// Data for the suppliers collection in the optica database
db.suppliers.insertMany([
  {
    "name": "Supplier 1",
    "address": {
      "street": "123 Test St",
      "number": 1,
      "floor": "1A",
      "door": "1",
      "city": "Test City",
      "zip_code": 12345,
      "country": "Test Country"
    },
    "phone_number": "123-456-7890",
    "fax": "123-456-7890",
    "NIF": "12345678A"
  },
  {
    "name": "Supplier 2",
    "address": {
      "street": "456 Test St",
      "number": 2,
      "floor": "2B",
      "door": "2",
      "city": "Test City",
      "zip_code": 23456,
      "country": "Test Country"
    },
    "phone_number": "234-567-8901",
    "fax": "234-567-8901",
    "NIF": "23456789B"
  }
]);


// BRANDS DATABASE
db.createCollection('brands', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'brands',
      required: ['name', 'supplier_id'],
      properties: {
        name: {
          bsonType: 'string'
        },
        supplier_id: {
          bsonType: 'objectId'
        }
      }
    }
  },
  autoIndexId: true,
  validationLevel: 'off',
  validationAction: 'warn'
});


// Data for the brands collection in the optica database, first we need to get a supplier id
var supplier1 = db.suppliers.findOne({ name: "Supplier 1" });
var supplier2 = db.suppliers.findOne({ name: "Supplier 2" });
db.brands.insertMany([
  {
    "name": "Brand 1",
    "supplier_id": supplier1._id
  },
  {
    "name": "Brand 2",
    "supplier_id": supplier2._id
  }
]);



// GLASSES DATABASE
db.createCollection('glasses', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'glasses',
      required: ['graduation', 'glass_color', 'frame_type', 'price', 'brand_id', 'sale_details'],
      properties: {
        graduation: {
          bsonType: 'object',
          title: 'object',
          required: ['left_glass', 'right_glass'],
          properties: {
            left_glass: {
              bsonType: 'decimal'
            },
            right_glass: {
              bsonType: 'decimal'
            }
          }
        },
        glass_color: {
          bsonType: 'object',
          title: 'object',
          required: ['left_glass', 'right_glass'],
          properties: {
            left_glass: {
              bsonType: 'string'
            },
            right_glass: {
              bsonType: 'string'
            }
          }
        },
        frame_type: {
          bsonType: 'object',
          title: 'object',
          required: ['type', 'color'],
          properties: {
            type: {
              bsonType: 'string'
            },
            color: {
              bsonType: 'string'
            }
          }
        },
        price: {
          bsonType: 'decimal'
        },
        brand_id: {
          bsonType: 'objectId'
        },
        sale_details: {
          bsonType: 'object',
          title: 'object',
          required: ['date', 'worker_nif'],
          properties: {
            date: {
              bsonType: 'date'
            },
            worker_nif: {
              bsonType: 'string'
            }
          }
        }
      }
    }
  }
});

// Insert into glasses
var brand1 = db.brands.findOne({ name: "Brand 1" });
db.glasses.insertMany([
  {
    "graduation": {
      "left_glass": NumberDecimal("1.0"),
      "right_glass": NumberDecimal("1.5")

    },
    "glass_color": {
      "left_glass": "blue",
      "right_glass": "blue"
    },
    "frame_type": {
      "type": "flotant",
      "color": "black"
    },
    "price": NumberDecimal("99.99"),
    "brand_id": brand1._id,
    "sale_details": {
      "date": new ISODate(),
      "worker_nif": "12345678A"
    }
  },
  {
    "graduation": {
      "left_glass": NumberDecimal("2.0"),
      "right_glass": NumberDecimal("2.0")
    },
    "glass_color": {
      "left_glass": "green",
      "right_glass": "green"
    },
    "frame_type": {
      "type": "pasta",
      "color": "white"
    },
    "price": NumberDecimal("199.99"),
    "brand_id": brand1._id,
    "sale_details": {
      "date": new ISODate(),
      "worker_nif": "23456789B"
    }
  }
]);

// CLIENTS DATABASE
db.createCollection('clients', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'clients',
      required: ['name', 'data', 'zip_code', 'last_shoppings'],
      properties: {
        name: {
          bsonType: 'string'
        },
        data: {
          bsonType: 'object',
          title: 'object',
          required: ['address', 'telephone', 'email', 'register_date'],
          properties: {
            address: {
              bsonType: 'string'
            },
            telephone: {
              bsonType: 'string'
            },
            email: {
              bsonType: 'string'
            },
            register_date: {
              bsonType: 'date'
            }
          }
        },
        zip_code: {
          bsonType: 'double'
        },
        last_shoppings: {
          bsonType: 'array',
          items: {
            bsonType: 'objectId'
          }
        },
        recommended_by_client: {
          bsonType: 'objectId'
        }
      }
    }
  }
});

// Insert into clients
db.clients.insertMany([
  {
    "name": "Client 1",
    "data": {
      "address": "789 Test St",
      "telephone": "345-678-9012",
      "email": "client1@test.com",
      "register_date": new ISODate()
    },
    "zip_code": 34567,
    "last_shoppings": []
  },
  {
    "name": "Client 2",
    "data": {
      "address": "012 Test St",
      "telephone": "456-789-0123",
      "email": "client2@test.com",
      "register_date": new ISODate()
    },
    "zip_code": 45678,
    "last_shoppings": []
  }
]);

// THESE ARE FOR ADDING THE RECOMMENDATION AND LAST PURCHASE TO THE CLIENTS COLLECTION
// Get the _id of the client
var client = db.clients.findOne({ name: "Client 1" });

// Get the _id of the new purchase
var purchase = db.glasses.findOne({ "glass_color.left_glass": "blue" });

// Add the new purchase to the client's last_shoppings
db.clients.update(
  { _id: client._id },
  { $push: { last_shoppings: purchase._id } }
);

// Get the _id of the client who made the recommendation
var recommendingClient = db.clients.findOne({ name: "Client 2" });

// Set the recommended_by_client field of the client
db.clients.update(
  { _id: client._id },
  { $set: { recommended_by_client: recommendingClient._id } }
);


// More information on the `createCollection` command can be found at:
// https://www.mongodb.com/docs/manual/reference/method/db.createCollection/
