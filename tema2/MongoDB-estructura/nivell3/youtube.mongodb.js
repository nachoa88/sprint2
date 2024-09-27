// Database name, it will create the database if it doesn't exist
const database = 'youtube';
// Use the database
use(database);

// USERS COLLECTION
db.createCollection('users', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'users',
            required: ['email', 'password', 'username', 'birth_date', 'gender', 'country', 'zip_code'],
            properties: {
                email: {
                    bsonType: 'string'
                },
                password: {
                    bsonType: 'string'
                },
                username: {
                    bsonType: 'string'
                },
                birth_date: {
                    bsonType: 'date'
                },
                gender: {
                    enum: ['Female', 'Male', 'Non-binary', 'Other']
                },
                country: {
                    bsonType: 'string'
                },
                zip_code: {
                    bsonType: 'int'
                }
            }
        }
    },
    autoIndexId: true
});

// Insert User Data
db.users.insertMany([
    {
        email: "user1@example.com",
        password: "password1",
        username: "user1",
        birth_date: new Date("1990-01-01"),
        gender: "Female",
        country: "USA",
        zip_code: 12345
    },
    {
        email: "user2@example.com",
        password: "password2",
        username: "user2",
        birth_date: new Date("1992-02-02"),
        gender: "Male",
        country: "Canada",
        zip_code: 23456
    },
    {
        email: "user3@example.com",
        password: "password3",
        username: "user3",
        birth_date: new Date("1994-03-03"),
        gender: "Non-binary",
        country: "UK",
        zip_code: 34567
    },
    {
        email: "user4@example.com",
        password: "password4",
        username: "user4",
        birth_date: new Date("1996-04-04"),
        gender: "Other",
        country: "Australia",
        zip_code: 45678
    }
]);

// Get the _id of the users
let user1Id = db.users.findOne({ email: "user1@example.com" })._id;
let user2Id = db.users.findOne({ email: "user2@example.com" })._id;
let user3Id = db.users.findOne({ email: "user3@example.com" })._id;
let user4Id = db.users.findOne({ email: "user4@example.com" })._id;


// VIDEOS COLLECTION
db.createCollection('videos', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'videos',
            required: ['title', 'description', 'file_size', 'file_name', 'duration', 'thumbnail', 'state', 'published_date', 'user_id'],
            properties: {
                title: {
                    bsonType: 'string'
                },
                description: {
                    bsonType: 'string'
                },
                file_size: {
                    bsonType: 'string'
                },
                file_name: {
                    bsonType: 'string'
                },
                duration: {
                    bsonType: 'string'
                },
                thumbnail: {
                    bsonType: 'string'
                },
                num_reproductions: {
                    bsonType: 'int'
                },
                state: {
                    enum: ['públic', 'ocult', 'privat']
                },
                published_date: {
                    bsonType: 'date'
                },
                user_id: {
                    bsonType: 'objectId'
                },
                like_dislike: {
                    bsonType: 'array',
                    items: {
                        bsonType: 'object',
                        required: ['type', 'user_id', 'date'],
                        properties: {
                            type: {
                                enum: ['like', 'dislike']
                            },
                            user_id: {
                                bsonType: 'objectId'
                            },
                            date: {
                                bsonType: 'date'
                            }
                        }
                    }
                },
                tags: {
                    bsonType: 'array'
                }
            }
        }
    },
    autoIndexId: true
});


// Insert the video documents
db.videos.insertMany([
    {
        title: "Video 1",
        description: "This is video 1",
        file_size: "100MB",
        file_name: "video1.mp4",
        duration: "10:00",
        thumbnail: "thumbnail1.jpg",
        state: "públic",
        published_date: new Date(),
        user_id: user1Id,
        like_dislike: [
            {
                type: "like",
                user_id: user4Id,
                date: new Date()
            }
        ]
    },
    {
        title: "Video 2",
        description: "This is video 2",
        file_size: "200MB",
        file_name: "video2.mp4",
        duration: "20:00",
        thumbnail: "thumbnail2.jpg",
        state: "públic",
        published_date: new Date(),
        user_id: user1Id,
        like_dislike: [
            {
                type: "like",
                user_id: user4Id,
                date: new Date()
            }
        ]
    },
    {
        title: "Video 3",
        description: "This is video 3",
        file_size: "300MB",
        file_name: "video3.mp4",
        duration: "30:00",
        thumbnail: "thumbnail3.jpg",
        state: "públic",
        published_date: new Date(),
        user_id: user2Id,
        like_dislike: [
            {
                type: "dislike",
                user_id: user4Id,
                date: new Date()
            }
        ]
    },
    {
        title: "Video 4",
        description: "This is video 4",
        file_size: "400MB",
        file_name: "video4.mp4",
        duration: "40:00",
        thumbnail: "thumbnail4.jpg",
        state: "públic",
        published_date: new Date(),
        user_id: user3Id,
        like_dislike: [
            {
                type: "dislike",
                user_id: user4Id,
                date: new Date()
            }
        ]
    }
]);

// Get the _id of the videos
let video1Id = db.videos.findOne({ title: "Video 1" })._id;
let video2Id = db.videos.findOne({ title: "Video 2" })._id;
let video3Id = db.videos.findOne({ title: "Video 3" })._id;
let video4Id = db.videos.findOne({ title: "Video 4" })._id;


//  PLAYLISTS COLLECTION
db.createCollection('playlists', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'playlists',
            required: ['name', 'creation_date', 'state', 'user_id'],
            properties: {
                name: {
                    bsonType: 'string'
                },
                creation_date: {
                    bsonType: 'date'
                },
                state: {
                    enum: ['pública', 'privada']
                },
                user_id: {
                    bsonType: 'objectId'
                }
            }
        }
    },
    autoIndexId: true
});


// Insert the playlist document
db.playlists.insertOne({
    name: "User 1's Playlist",
    creation_date: new Date(),
    state: "pública",
    user_id: user1Id,
    videos: [video1Id, video2Id]
});


// CHANNELS COLLECTION
db.createCollection('channels', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'channels',
            required: ['name', 'description', 'creation_date', 'user_id', 'video_id'],
            properties: {
                name: {
                    bsonType: 'string'
                },
                description: {
                    bsonType: 'string'
                },
                creation_date: {
                    bsonType: 'date'
                },
                user_id: {
                    bsonType: 'objectId'
                },
                video_id: {
                    bsonType: 'objectId'
                }
            }
        }
    },
    autoIndexId: true
});

// Get the _id of the video published by user2
let user2VideoId = db.videos.findOne({ user_id: user2Id })._id;

// Insert the channel document
db.channels.insertOne({
    name: "User 2's Channel",
    description: "This is user 2's channel",
    creation_date: new Date(),
    user_id: user2Id,
    video_id: user2VideoId
});


// CHANNEL SUBSCRIPTIONS COLLECTION
db.createCollection('channel_subscriptions', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'channel_subscriptions',
            required: ['user_id', 'channel_id'],
            properties: {
                user_id: {
                    bsonType: 'objectId'
                },
                channel_id: {
                    bsonType: 'objectId'
                }
            }
        }
    }
});

// Get the _id of the channel
let channelId = db.channels.findOne({ name: "User 2's Channel" })._id;

// Insert the channel subscription document
db.channel_subscriptions.insertOne({
    user_id: user3Id,
    channel_id: channelId
});


// COMMENTS COLLECTION
db.createCollection('comments', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            title: 'comments',
            required: ['text', 'date_time', 'user_id', 'video_id'],
            properties: {
                text: {
                    bsonType: 'string'
                },
                date_time: {
                    bsonType: 'date'
                },
                user_id: {
                    bsonType: 'objectId'
                },
                video_id: {
                    bsonType: 'objectId'
                }
            }
        }
    },
    autoIndexId: true
});

// Insert the comment documents
db.comments.insertMany([
    {
        text: "This is a comment from user 4 on video 1",
        date_time: new Date(),
        user_id: user4Id,
        video_id: video1Id
    },
    {
        text: "This is another comment from user 4 on video 1",
        date_time: new Date(),
        user_id: user4Id,
        video_id: video1Id
    },
    {
        text: "This is a comment from user 4 on video 3",
        date_time: new Date(),
        user_id: user4Id,
        video_id: video3Id
    },
    {
        text: "This is another comment from user 4 on video 3",
        date_time: new Date(),
        user_id: user4Id,
        video_id: video3Id
    }
]);