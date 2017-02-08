# Sockets

Basic Phoenix & Elm (client side) sockets example


Check
- `web/channels/room_channel` for the socket 'routes'
- `web/elm/Main.elm` for the elm application

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`
  * In `web/elm` run `elm package install`
Now you can visit [`localhost:4000`](http://localhost:4000) and start chatting (to yourself).

# Useful Resources
- [Sockets with elm](https://www.dailydrip.com/topics/elm/drips/elm-phoenix-socket) (using elm-phoenix-socket library)
- [Second elm-phoenix sockets example](http://simonh1000.github.io/2016/05/elm-phoenix-channels/)
- [Adding an elm app to your phoenix backend](https://medium.com/@diamondgfx/writing-a-full-site-in-phoenix-and-elm-a100804c9499#.556qzy7u3)
