// data/schema.js

const { gql } = require('apollo-server-express')

// Define our schema using the GraphQL schema language
const typeDefs = gql`
  type User {
    id: Int!
    username: String!
    email: String!
  }

  type Query {
    me: User
  }

  type Mutation {
    signup (username: String!, email: String!, password: String!): String
    login (email: String!, password: String!): String
  }
`;
module.exports = typeDefs;