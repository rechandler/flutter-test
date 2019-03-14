const express = require('express');
var bodyParser = require('body-parser')
const jwt = require('express-jwt')
const { ApolloServer } = require('apollo-server-express');
const typeDefs = require('./data/schema');
const resolvers = require('./data/resolvers');
require('dotenv').config()

const path = '/graphql';

// auth middleware
const auth = jwt({
  secret: process.env.JWT_SECRET,
  credentialsRequired: false,
  getToken: (req) => {
    const headers = req.headers;
    const cookie = headers.cookie;
    if (!cookie) return null;

    // .slice removes the trailing ;
    // TODO: figure out where that is coming from
    return cookie.split("Authorization=")[1].slice(0, -1);
  }
});

const server = new ApolloServer({
    typeDefs,
    resolvers,
    context: ({ req, res }) => ({
        user: req.user, //our auth middleware is injecting the decoded token on the request
        req,
        res
    })
});

//start the express app
const app = express();
console.log('test');

// Inject our token auth on our path;
app.use(path, auth, (err, req, res, next) => {
  if (err.name === 'UnauthorizedError') {
    res.status(401).send('invalid token...');
  }
});

// Parse body as json
app.use(bodyParser.json());

// set up headers
app.use(function(req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type, Authorization');
    next();
});

// Apply the app and path as middleware to apollo
server.applyMiddleware({ app, path});
app.listen({ port: 3000 }, () =>
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
);