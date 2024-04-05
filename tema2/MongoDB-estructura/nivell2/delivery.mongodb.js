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
            required: ['date_time', 'delivery_type', 'total', 'note', 'products_included', 'store_id'],
            properties: {
                date_time: {
                    bsonType: 'date'
                },
                delivery_type: {
                    enum: ['repartiment a domicili', 'recollir en botiga']
                },
                total: {
                    bsonType: 'decimal'
                },
                note: {
                    bsonType: 'string'
                },
                products_included: {
                    bsonType: 'array'
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

db.createCollection('confirmed_orders', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'confirmed_orders',
            required: ['name', 'price', 'total', 'state', 'client'],
            properties: {
                name: {
                    bsonType: 'string'
                },
                price: {
                    bsonType: 'decimal'
                },
                total: {
                    bsonType: 'decimal'
                },
                state: {
                    enum: ['delivered', 'paid']
                },
                client: {
                    bsonType: 'object',
                    title: 'object',
                    required: ['id', 'name'],
                    properties: {
                        id: {
                            bsonType: 'objectId'
                        },
                        name: {
                            bsonType: 'string'
                        }
                    }
                },
                deliver_in: {
                    bsonType: 'object',
                    title: 'object',
                    required: ['street', 'number', 'floor', 'contact_number'],
                    properties: {
                        street: {
                            bsonType: 'string'
                        },
                        number: {
                            bsonType: 'string'
                        },
                        floor: {
                            bsonType: 'string'
                        },
                        contact_number: {
                            bsonType: 'string'
                        },
                        note: {
                            bsonType: 'string'
                        }
                    }
                }
            }
        }
    },
    autoIndexId: true
});