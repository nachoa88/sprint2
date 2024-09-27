// This is the equivalent of "use mongoqueries" in the mongo shell.
db = db.getSiblingDB('mongoqueries');

/* The find() method in MongoDB takes two arguments:
1- A query object, which specifies the conditions that the documents need to meet to be included in the result. 
If you pass an empty object {}, all documents in the collection will be included in the result.
2- A projection object, which specifies the fields to include or exclude in the returned documents. 
*/

// Query 1: Tots els documents de la col·lecció restaurants.
db.restaurants.find({});

// Query 2: restaurant_id, name, borough i cuisine de tots els documents.
// db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 3: restaurant_id, name, borough i cuisine de tots els documents, excloent l'_id de cada document.
// db.restaurants.find({}, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 4: restaurant_id, name, borough i zip code de tots els documents.
// db.restaurants.find({}, { _id: 0, restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1 });

// Query 5: tots els restaurants que es troben al Bronx.
// db.restaurants.find({ borough: "Bronx" });

// Query 6: Els 5 primers restaurants que es troben al Bronx.
// db.restaurants.find({ borough: "Bronx" }).limit(5);

// Query 7: Els 5 seguents restaurants Bronx després de saltar els 5 primers.
// db.restaurants.find({ borough: "Bronx" }).skip(5).limit(5);

// Query 8: Restaurants que tenen un score superior a 90. --> $gt: greater than
// db.restaurants.find({ "grades.score": { $gt: 90 } });

// Query 9: Restaurants que tenen un score superior a 80 però inferior a 100. --> $elemMatch per a buscar dins d'un array, $lt: less than.
// db.restaurants.find({ "grades": { $elemMatch: { "score": { $gt: 80, $lt: 100 } } } });

// Query 10: Restaurants situats en una longitud inferior a -95.754168.
// db.restaurants.find({ "address.coord.0": { $lt: -95.754168 } });

// Query 11: Restaurants que no cuinen menjar 'American ' i tenen algun score superior a 70 i latitud inferior a -65.754168. $ne: not equal
// db.restaurants.find({ "address.coord.1": { $lt: -65.754168 }, cuisine: { $ne: "American " }, "grades.score": { $gt: 70 } });

// Query 12: Mateix que l'anterior però longitud i no es pot utilitzar l'operador $and.
// db.restaurants.find({ "address.coord.0": { $lt: -65.754168 }, cuisine: { $ne: "American " }, "grades.score": { $gt: 70 } });

// Query 13: Restaurants que no preparen menjar 'American ', tenen alguna nota 'A' i no pertanyen a Brooklyn. En ordre descendent segons la cuina.
// db.restaurants.find({ cuisine: { $ne: "American " }, "grades.grade": "A", borough: { $ne: "Brooklyn" } }).sort({ cuisine: -1 });

// Query 14: restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Wil' en les tres primeres lletres en el seu nom. 
// $regex: Selects documents where values match a specified regular expression. ^: Starts with.
// db.restaurants.find({ name: { $regex: "^Wil" } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 15: Mateix a l'anterior però restaurants que contenen 'ces' en les últimes tres lletres en el seu nom. $: Ends with.
// db.restaurants.find({ name: { $regex: "ces$" } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 16: Mateix que 14 i 15 però restaurants que contenen 'Reg' en el seu nom. $options: 'i' --> case insensitive.
// db.restaurants.find({ name: { $regex: "Reg", $options: 'i' } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 17: Restaurants que pertanyen al Bronx i preparen plats Americans o xinesos. $or: Logical OR, returns matching documents that satisfy at least one condition.
// db.restaurants.find({ borough: "Bronx", $or: [{ cuisine: "American " }, { cuisine: "Chinese" }] });

// Query 18 - Best Option: Restaurants que pertanyen a Staten Island, Queens, Bronx o Brooklyn. $in: Selects the documents where the value of a field equals any value in the specified array.
// db.restaurants.find({ borough: { $in: ["Staten Island", "Queens", "Bronx", "Brooklyn"] } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// Query 18 - Option 2
// db.restaurants.find({ $or: [{ borough: "Staten Island" }, { borough: "Queens" }, { borough: "Bronx" }, { borough: "Brooklyn" }] }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 19: Restaurants que NO pertanyen a Staten Island, Queens, Bronx o Brooklyn. $nin: Selects the documents where the value of a field is not in the specified array.
// db.restaurants.find({ borough: { $nin: ["Staten Island", "Queens", "Bronx", "Brooklyn"] } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 20: Restaurants que aconsegueixin una nota menor que 10.
// db.restaurants.find({ "grades.score": { $lt: 10 } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 21: Rrestaurants que preparen marisc ('seafood') excepte si són 'American ', 'Chinese' o el name del restaurant comença amb lletres 'Wil'.
// db.restaurants.find({ cuisine: "Seafood", $nor: [{ cuisine: "American " }, { cuisine: "Chinese" }, { name: { $regex: "^Wil" } }] }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// Query 22: restaurant_id, name i grades per a aquells restaurants que aconsegueixin un grade de "A" i un score d'11 amb un ISODate "2014-08-11T00:00:00Z".
// db.restaurants.find({ grades: { $elemMatch: { score: 11, grade: "A", date: new ISODate("2014-08-11T00:00:00Z") } } }, { _id: 0, restaurant_id: 1, name: 1, grades: 1 });

// Query 23: restaurant_id, name i grades per a aquells restaurants on el 2n element de l'array de graus conté un grade de "A" i un score 9 amb un ISODate "2014-08-11T00:00:00Z"
// El "grades.1" fa referència al segon element de l'array de grades, $elemMatch no és necessari quan es busca un element específic de l'array.
// db.restaurants.find({ "grades.1.score": 9, "grades.1.grade": "A", "grades.1.date": new ISODate("2014-08-11T00:00:00Z") }, { _id: 0, restaurant_id: 1, name: 1, grades: 1 });

// Query 24: restaurant_id, name, adreça i ubicació geogràfica per a aquells restaurants on el segon element de l'array coord conté un valor entre 42 i 52.
// db.restaurants.find({ "address.coord.1": { $gt: 42, $lt: 52 } }, { _id: 0, restaurant_id: 1, name: 1, address: 1 });

// Query 25: Restaurants per nom en ordre ascendent.
// db.restaurants.find({}).sort({ name: 1 });

// Query 26: Restaurants per nom en ordre descendent.
// db.restaurants.find({}).sort({ name: -1 });

// Query 27: Restaurants pel nom de la cuisine en ordre ascendent i pel barri en ordre descendent.
// db.restaurants.find({}).sort({ cuisine: 1, borough: -1 });

// Query 28: Saber si les direccions contenen el carrer. $exists: checks for the existence of a field.
// db.restaurants.find({ "address.street": { $exists: true } });

// Query 29: Tots els documents en la col·lecció de restaurants on els valors del camp coord és de tipus Double. 
// $type: Selects the documents where the value of the field is an instance of the specified BSON type.
// db.restaurants.find({ "address.coord": { $type: "double" } });

// Query 30: restaurant_id, name i grade per a aquells restaurants que retornen 0 com a residu després de dividir algun dels seus score per 7.
// $mod: takes an array of two numbers. The first number is the divisor, and the second number is the remainder.
// db.restaurants.find({ "grades.score": { $mod: [7, 0] } }, { _id: 0, restaurant_id: 1, name: 1, grades: 1 });

// Query 31: name de restaurant, borough, longitud, latitud i cuisine per a aquells restaurants que contenen 'mon' en algun lloc del seu name.
// db.restaurants.find({ name: { $regex: "mon", $options: 'i' } }, { _id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1 });

// Query 32: Mateix que l'anterior però que contenen 'Mad' com a primeres tres lletres del seu name.
// db.restaurants.find({ name: { $regex: "^Mad", $options: 'i' } }, { _id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1 });
