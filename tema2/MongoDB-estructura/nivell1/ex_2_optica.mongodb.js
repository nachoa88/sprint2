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
          required: ['street', 'number', 'floor', 'door', 'city', 'zip_code', 'country'],
          properties: {
            street: {
              bsonType: 'string'
            },
            number: {
              bsonType: 'double'
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
              bsonType: 'double'
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
  validationLevel: 'off',
  validationAction: 'warn'
});

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
  validationLevel: 'off',
  validationAction: 'warn'
});


// GLASSES DATABASE
db.createCollection('glasses', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'glasses',
      required: ['brand', 'frame_type', 'provider', 'price', 'bought_by', 'graduation', 'glass_color', 'sale_details'],
      properties: {
        brand: {
          bsonType: 'string'
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
        provider: {
          bsonType: 'string'
        },
        price: {
          bsonType: 'decimal'
        },
        bought_by: {
          bsonType: 'array',
          items: {
            bsonType: 'objectId'
          }
        },
        graduation: {
          bsonType: 'object',
          title: 'object',
          required: ['left_glass', 'right_glass'],
          properties: {
            left_glass: {
              bsonType: 'decimal'
            },
            right_glass: {
              bsonType: 'string'
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


// CLIENTS DATABASE
db.createCollection('clients', {
  validator: {
    $jsonSchema: {
      bsonType: 'object',
      title: 'clients',
      required: ['name', 'data', 'zip_code'],
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
        recommended_by_client: {
          bsonType: 'objectId'
        }
      }
    }
  }
});
