## JSON API with Hanami 🌸

The goal of this project is to provide an example of a JSON API web application built with [Hanami](http://hanamirb.org/) that exposes JWT-protected enpoints.

Main features:

- return a JSON representation of resources
- store encrypted password in the db with [BCrypt](https://github.com/codahale/bcrypt-ruby)
- implement a token based authentication strategy using [Warden Middleware](https://github.com/hassox/warden) and [JWT gem](https://github.com/jwt/ruby-jwt)
- handle [preflight CORS requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
- use [Hanami framework](http://hanamirb.org/)

Developed and tested with:

- Ruby v2.3.1
- Hanami v1.0.0beta2

## Try it yourself

```bash
git clone https://github.com/nickgnd/hanami-jwt-example
cd hanami-jwt-example
bundle install
```

then edit `.env.*` files to fit your environment and create the development and test databases

```bash
bundle exec hanami db create
bundle exec hanami db migrate
HANAMI_ENV=test bundle exec db create
HANAMI_ENV=test bundle exec hanami db migrate
```

finally, run tests to check if everything is ok

```bash
rake test
```

The web application exposes an API which allows authenticated users to retrieve a collection of items.
The requests to this endpoint will be authenticated through a token based authentication strategy, passing a custom header `Authorization` containing the user's JWT.


Let's start.

```bash
bundle exec hanami server
```

By default it launches the development server at `http://localhost:2300`

1) **Before we need to register a new user**

To do this, we have to make a `POST` request against `/registration` endpoint passing the required informations in the payload.

_request_:`POST /registration`

_payload_:

```bash
{ user: { email: "hanami@exmaple.com", password: "cherryblossom", password_confirmation: "cherryblossom" } }
```

_with curl_:
```bash
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{ "user": { "email": "hanami@exmaple.com", "password": "cherryblossom", "password_confirmation": "cherryblossom" } }' "http://localhost:2300/registration"
```

2) **Retrive user's jwt**

For retrieving the JWT, we have to make a `POST` request to `/sessions` path passing user's email and password in the payload.

_request_: `POST /sessions`

_payload_:
```bash
{ user: { email: "hanami@exmaple.com", password: "cherryblossom" } }
```

The response body will contain the JWT under the key `auth_token`, save it for the next step (retrieving item collections).

_with curl_:
```bash
curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{ "user": { "email": "hanami@exmaple.com", "password": "cherryblossom" } }' "http://localhost:2300/sessions"
```

Response example:

```bash
{"auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNCwiaXNzIjoiaHR0cDovL2ludmVudG9yeS5jb20iLCJleHAiOjE0ODkwNDUxNDB9.RI2F5-6rsIU02yXa158iocRP2qKQoR-mi8jbsRM0mDo"}
```

3) **Retrieving items**

Finally, for retrieving the items we have to make a `GET` request against `/items` endpoint including the user's jwt in the headers.

_request_: `GET /items`

_headers_:
`"Authentication": "Bearer <YOUR_JWT>"`

_with curl_:
```bash
curl -X GET -H "Content-Type: application/json" -H "Accept: application/json" -H "Authorization: Bearer <YOUR_JWT>" "http://localhost:2300/items"
```

The response body will be an empty array because there are not items in the database, let's create a new one through the Hanami console:

```bash
bundle exec hanami console
```

```bash
item = Item.new(code: 'alfa', available: true)
=> #<Item:0x007fa66b2da7d0 @attributes={:code=>"alfa", :available=>true}>

ItemRepository.new.create(item)
=> #<Item:0x007fa66e040e18 @attributes={:id=>1, :code=>"alfa", :available=>true, :created_at=>2017-03-08 23:00:11 UTC, :updated_at=>2017-03-08 23:00:11 UTC}>
```

Now the next request will return the item just created

```bash
[
  { "id":1,"code":"alfa","available":true,"created_at":"2017-03-08 23:00:11 UTC","updated_at":"2017-03-08 23:00:11 UTC" }
]
```

et voilà!

## Contributing

Feel free to submit issues for questions, bugs and enhancements.

and as usual...

1. Fork the repo
2. Create your feature branch
3. Commit changes to your own branch
4. Push it
5. Submit a Pull Request

## Credits

This project is inspired by this tutorial [Using rails-api to build an authenticated JSON API with warden](http://lucatironi.net/tutorial/2015/08/23/rails_api_authentication_warden/)
