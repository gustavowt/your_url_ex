# YourUrlEx

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Creating a token
First of all you need to move the `.env_example` to `.env` and them load it in to your environment variables (feel free to change those values, mainly in produciton)

```bash
$ cp .env_example .env
$ source .env
```

With you environment ready, open your elixir console and type:
```exs
Phoenix.Token.sign(YourUrlEx.Endpoint, System.get_env("AUTHORIZATION_TOKEN_SALT"), "DarthVader")
```
which "DarthVader" is the identification of token.

## Shortening an url
```bash
$ curl -H "Content-Type: application/json" -H "token: {YourTokenHere}" -X POST -d '{"url": {"original_url":"http://google.com"}}' http://localhost:4000/api/urls
{"data":{"short_url":"http://short_url/4771adae6f3","original_url":"http://google.com"}}
```

## Retrieving the url information
```bash
$ curl -H "Content-Type: application/json" -H "token: {YourTokenHere}" -X GET http://localhost:4000/api/urls/4771adae6f3
{"data":{"short_url":"http://short_url/4771adae6f3","original_url":"http://google.com","clicks":4}}
```

## Retrieving a click history of an url
```bash
$ curl -H "Content-Type: application/json" -H "token: {YourTokenHere}" -X GET http://localhost:4000/api/click_histories/43b02683026
{"data":[{"platform":"MacOS 10.13.2 High Sierra","inserted_at":"2018-01-20 19:30:25.442475","device":"desktop","browser_version":"63.0.3239.132","browser_name":"Chrome"},
         {"platform":"MacOS 10.13.2 High Sierra","inserted_at":"2018-01-20 19:30:09.079919","device":"desktop","browser_version":"63.0.3239.132","browser_name":"Chrome"},
         {"platform":"MacOS 10.13.2 High Sierra","inserted_at":"2018-01-20 19:22:34.586385","device":"desktop","browser_version":"63.0.3239.132","browser_name":"Chrome"}]}
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
