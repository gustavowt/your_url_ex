# UrlShortner

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Shortening a url
```bash
$ curl -H "Content-Type: application/json" -X POST -d '{"url": {"original_url":"http://google.com"}}' http://localhost:4000/api/urls
{"data":{"short_url":"http://short_url/4771adae6f3","original_url":"http://google.com"}}
```

## Retrieving url information
```bash
$ curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/urls/4771adae6f3
{"data":{"short_url":"http://short_url/4771adae6f3","original_url":"http://google.com","clicks":4}}
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
