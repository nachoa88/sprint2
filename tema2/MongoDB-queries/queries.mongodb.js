// db = db.getSiblingDB('mongoqueries');

// /*Query 1*/ db.restaurants.find({});
// /*Query 2*/ db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 3*/ db.restaurants.find({}, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 4*/ db.restaurants.find({}, { _id: 0, restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1 });
// /*Query 5*/ db.restaurants.find({ borough: "Bronx" });
// /*Query 6*/ db.restaurants.find({ borough: "Bronx" }).limit(5);
// /*Query 7*/ db.restaurants.find({ borough: "Bronx" }).skip(5).limit(5);
// /*Query 8*/ db.restaurants.find({ "grades.score": { $gt: 90 } });
// /*Query 9*/ db.restaurants.find({ "grades": { $elemMatch: { "score": { $gt: 80, $lt: 100 } } } });
// /*Query 10*/ db.restaurants.find({ "address.coord.0": { $lt: -95.754168 } });
// /*Query 11*/ db.restaurants.find({ "address.coord.1": { $lt: -65.754168 }, cuisine: { $ne: "American " }, "grades.score": { $gt: 70 } });
// /*Query 12*/ db.restaurants.find({ "address.coord.0": { $lt: -65.754168 }, cuisine: { $ne: "American " }, "grades.score": { $gt: 70 } });
// /*Query 13*/ db.restaurants.find({ cuisine: { $ne: "American " }, "grades.grade": "A", borough: { $ne: "Brooklyn" } }).sort({ cuisine: -1 });
// /*Query 14*/ db.restaurants.find({ name: { $regex: "^Wil" } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 15*/ db.restaurants.find({ name: { $regex: "ces$" } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 16*/ db.restaurants.find({ name: { $regex: "Reg", $options: 'i' } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 17*/ db.restaurants.find({ borough: "Bronx", $or: [{ cuisine: "American " }, { cuisine: "Chinese" }] });
// /*Query 18 - Best Option*/ db.restaurants.find({ borough: { $in: ["Staten Island", "Queens", "Bronx", "Brooklyn"] } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 18 - 2nd Option*/ db.restaurants.find({ $or: [{ borough: "Staten Island" }, { borough: "Queens" }, { borough: "Bronx" }, { borough: "Brooklyn" }] }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 19*/ db.restaurants.find({ borough: { $nin: ["Staten Island", "Queens", "Bronx", "Brooklyn"] } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 20*/ db.restaurants.find({ "grades.score": { $lt: 10 } }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 21*/ db.restaurants.find({ cuisine: "Seafood", $nor: [{ cuisine: "American " }, { cuisine: "Chinese" }, { name: { $regex: "^Wil" } }] }, { _id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
// /*Query 22*/ db.restaurants.find({ grades: { $elemMatch: { score: 11, grade: "A", date: new ISODate("2014-08-11T00:00:00Z") } } }, { _id: 0, restaurant_id: 1, name: 1, grades: 1 });
// /*Query 23*/ db.restaurants.find({ "grades.1.score": 9, "grades.1.grade": "A", "grades.1.date": new ISODate("2014-08-11T00:00:00Z") }, { _id: 0, restaurant_id: 1, name: 1, grades: 1 });
// /*Query 24*/ db.restaurants.find({ "address.coord.1": { $gt: 42, $lt: 52 } }, { _id: 0, restaurant_id: 1, name: 1, address: 1 });
// /*Query 25*/ db.restaurants.find({}).sort({ name: 1 });
// /*Query 26*/ db.restaurants.find({}).sort({ name: -1 });
// /*Query 27*/ db.restaurants.find({}).sort({ cuisine: 1, borough: -1 });
// /*Query 28*/ db.restaurants.find({ "address.street": { $exists: true } });
// /*Query 29*/ db.restaurants.find({ "address.coord": { $type: "double" } });
// /*Query 30*/ db.restaurants.find({ "grades.score": { $mod: [7, 0] } }, { _id: 0, restaurant_id: 1, name: 1, grades: 1 });
// /*Query 31*/ db.restaurants.find({ name: { $regex: "mon", $options: 'i' } }, { _id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1 });
// /*Query 32*/ db.restaurants.find({ name: { $regex: "^Mad", $options: 'i' } }, { _id: 0, name: 1, borough: 1, cuisine: 1, "address.coord": 1 });
