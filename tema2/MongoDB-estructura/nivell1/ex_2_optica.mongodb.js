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
      required: ['left_glass', 'right_glass', 'frame', 'price', 'brand_id'],
      properties: {
        left_glass: {
          bsonType: 'object',
          title: 'object',
          required: ['graduation', 'color'],
          properties: {
            graduation: {
              bsonType: 'decimal'
            },
            color: {
              bsonType: 'string'
            }
          }
        },
        right_glass: {
          bsonType: 'object',
          title: 'object',
          required: ['graduation', 'color'],
          properties: {
            graduation: {
              bsonType: 'decimal'
            },
            color: {
              bsonType: 'string'
            }
          }
        },
        frame: {
          bsonType: 'object',
          title: 'object',
          required: ['type', 'color'],
          properties: {
            type: {
              bsonType: 'string',
              enum: ['flotant', 'pasta', 'metàl·lica']
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
          required: ['date', 'worker_nif'],
          properties: {
            date: {
              bsonType: 'date'
            },
            worker_nif: {
              bsonType: 'string'
            }
          }
        },
        bought_by_client: {
          bsonType: 'array',
          items: {
            bsonType: 'objectId'
          }
        }
      }
    }
  },
  autoIndexId: true
});

// Insert into glasses
var brand1 = db.brands.findOne({ name: "Brand 1" });
db.glasses.insertMany([
  {
    "left_glass": {
      "graduation": NumberDecimal("1.0"),
      "color": "blue"
    },
    "right_glass": {
      "graduation": NumberDecimal("1.5"),
      "color": "blue"
    },
    "frame": {
      "type": "flotant",
      "color": "black"
    },
    "price": NumberDecimal("99.99"),
    "brand_id": brand1._id,
    "sale_details": {
      "date": new ISODate(),
      "worker_nif": "12345678A"
    },
    "bought_by_client": []
  },
  {
    "left_glass": {
      "graduation": NumberDecimal("2.0"),
      "color": "green"
    },
    "right_glass": {
      "graduation": NumberDecimal("2.0"),
      "color": "green"
    },
    "frame": {
      "type": "pasta",
      "color": "white"
    },
    "price": NumberDecimal("199.99"),
    "brand_id": brand1._id,
    "sale_details": {
      "date": new ISODate(),
      "worker_nif": "23456789B"
    },
    "bought_by_client": []
  }
]);

// CLIENTS DATABASE
db.createCollection('clients', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'clients',
      required: ['name', 'client_data', 'zip_code'],
      properties: {
        name: {
          bsonType: 'string'
        },
        client_data: {
          bsonType: 'object',
          title: 'object',
          required: ['address', 'phone_number', 'email', 'registration_date'],
          properties: {
            address: {
              bsonType: 'string'
            },
            phone_number: {
              bsonType: 'string'
            },
            email: {
              bsonType: 'string'
            },
            registration_date: {
              bsonType: 'date'
            }
          }
        },
        zip_code: {
          bsonType: 'int'
        },
        recommended_by_client: {
          bsonType: 'objectId'
        },
      }
    }
  },
  autoIndexId: true
});

// Insert into clients
db.clients.insertMany([
  {
    "name": "Client 1",
    "client_data": {
      "address": "789 Test St",
      "phone_number": "345-678-9012",
      "email": "client1@test.com",
      "registration_date": new ISODate()
    },
    "zip_code": 34567
  },
  {
    "name": "Client 2",
    "client_data": {
      "address": "012 Test St",
      "phone_number": "456-789-0123",
      "email": "client2@test.com",
      "registration_date": new ISODate()
    },
    "zip_code": 45678
  }
]);

// THESE ARE FOR ADDING THE RECOMMENDATION TO CLIENTS COLLECTION AND BOUGHT BY TO THE GLASSES COLLECTION
// Get the _id of the client
var client = db.clients.findOne({ name: "Client 1" });

// Get the _id of the new purchase
var purchase = db.glasses.findOne({ "left_glass.color": "blue" });

// Add the new purchase to the client's last_purchases
db.glasses.update(
  { _id: purchase._id },
  { $push: { bought_by_client: client._id } }
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
