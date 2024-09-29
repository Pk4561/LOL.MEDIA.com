const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const User = require('./models/User'); // Create a User model file for MongoDB
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 5000;

mongoose.connect('your_mongodb_connection_string_here', { useNewUrlParser: true, useUnifiedTopology: true });

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// User registration
app.post('/signup', async (req, res) => {
    const { username, email, password } = req.body;
    const newUser = new User({ username, email, password });
    await newUser.save();
    res.status(201).send('User created successfully!');
});

// User login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    const user = await User.findOne({ email, password });
    if (user) {
        res.status(200).json({ message: 'Login successful!', user });
    } else {
        res.status(401).send('Invalid credentials');
    }
});

// Media upload endpoint (pseudo-code)
app.post('/upload-media', async (req, res) => {
    // Handle media upload logic here
    // Save media URL and description to the database
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
