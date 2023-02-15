# AUTHENTICATION API

*Work in progress*

## Introduction
The purpose of this API is to provide an internal authentication service. It is incomplete.  
What you can do so far is:
1. Create a user with a password by posting 
``` 
{
   "username": "<username>",
   "password": "<valid password>"
}
```
to the `http://localhost:3000/users` endpoint.
The password must be at least 12 characters including at least one uppercase, lowercase, numeral, and special character.

2. Update the password by posting
```
{
   "username": "<username>",
   "password": "<valid password>"
}
to the `http://localhost:3000/users/<username>` endpoint

3. Delete the user by using a DELETE action on the username endpoint.

### Work to do:

1. Create sessions controller and endpoints to allow login and logout of existing users.  Login creates a jwt token for an authenticated user, with a timeout.  Logout expires the jwt.
2. Add sessions endpoint to check whether a valid session exists for a logged in user.

### Suggested changes and future work:

* Redis is not a default db for rails; consequently one cannot simply use ActiveRecord ORM when using it as the primary datasource for a Rails application. A decision was made to use `bcrypt` gem instead of using the authentication that comes with `devise` and `devise-jwt` gems, because Devise uses ActiveRecord by default.  However, Devise controllers can be overridden to use the Redis-ruby gems and ActiveModel to store user and session data in Redis instead of a SQL database.

## Requirements

Ruby version: 3.0.x
Rails version 7.0.x
Redis version 6.2.8 (423c78f4/0) 64 bit

This authentication api requires Redis be installed and running  on the local system. If you are using
a redis installation on a different server please change the configuration in `config/initializers/redis.rb` to point to your redis instance.  This app is using the default Redis database, and
is persisting all data to the redis instance once every second. No sql db needs to be installed!

## Install:

```
$ bundle install
```
then
```
rails s
```

## Run Automated Tests:
```
rails test
```

