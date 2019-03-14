const { User } = require('../../models');
const bcrypt = require('bcrypt');
const jsonWebToken = require('jsonwebtoken');
require('dotenv').config();

const resolvers = {
    Query: {
        // fetch the profile of current user
        async me (_, args, {user}, info) {
            // make sure user is logged in
            if (!user) {
                throw new Error('You are not authenticated');
            }

            return await User.findByPk(user.id);
        }
    },

    Mutation: {
        // Sign UP
        async signup (_, { username, email, password}, { req, res }, info) {
            const existingUser = await User.findOne({ where: { email }});
            if(existingUser) {
                return res.status(409).send('A user with that email already exists.');
            }

            const user = await User.create({
                username,
                email,
                password: await bcrypt.hash(password, 10)
            });

            const signedToken = jsonWebToken.sign(
                {id: user.id, email: user.email },
                process.env.JWT_SECRET,
                { expiresIn: '1y' }
            );

            res.status(201).cookie('Authorization', signedToken);
        },

        // LOGIN
        async login (_, {email, password}, { req, res }) {
            const user = await User.findOne({ where: { email }});

            if (!user) {
                throw new Error('User with that email could not be found');
            }

            const valid = await bcrypt.compare(password, user.password);

            if (!valid) {
                throw new Error('Incorrect Password');
            }

            const signedToken = jsonWebToken.sign(
                {id: user.id, email: user.email},
                process.env.JWT_SECRET,
                { expiresIn: '1d'}
            );

            res.status(200).cookie('Authorization', signedToken);
        }
    }
}

module.exports = resolvers;