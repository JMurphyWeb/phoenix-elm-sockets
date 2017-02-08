module Main exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket
import Json.Encode as E
import Json.Decode as D

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

echoServer : String
echoServer =
  "ws://localhost:4000/socket/websocket"

-- MODEL

type alias Model =
  { input : String
  , messages : List String
  }

init : (Model, Cmd Msg)
init =
  (Model "" [], Cmd.none)


-- UPDATE


type alias SendMsg =
    { topic : String
    , event: String
    , payload : String
    , ref : String
    }

encoder : SendMsg -> String
encoder m =
    E.object
        [ ("topic", E.string m.topic)
        , ("event", E.string m.event)
        , ("payload", payloadEncoder m.payload)
        , ("ref", E.string m.ref)
        ]
    |> E.encode 0

payloadEncoder : String -> E.Value
payloadEncoder p = E.object [("body", E.string p)]


decodeObj : List String -> String -> Result String String
decodeObj path =
  D.decodeString (D.at path D.string )


payloadDecoder : String -> String
payloadDecoder p =
  case decodeObj ["topic"] p of
    Err msg ->
      msg
    Ok topic ->
        case decodeObj ["payload", "body"] p of
          Ok body ->
            "new message: " ++ body
          Err msg1 ->
            msg1

type Msg
  = Input String
  | Send
  | NewMessage String
  | Join

update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messages} =
  case msg of
    Input newInput ->
      (Model newInput messages, Cmd.none)
    Send ->
      let sendMessage = SendMsg "room:lobby" "new:msg" input "3"
      in
        ( Model "" messages
        , WebSocket.send echoServer (encoder sendMessage)
        )
    NewMessage newMessage ->
      let decoded = payloadDecoder newMessage
      in
        ( Model input (decoded :: messages)
        , Cmd.none
        )
    Join ->
      let joinMsg = SendMsg  "room:lobby" "phx_join" "join request" "1"
      in
        ( Model input messages
        , WebSocket.send echoServer (encoder joinMsg)
        )



-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen echoServer NewMessage


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] (List.map viewMessage model.messages)
    , button [ onClick Send ] [ text "Send" ]
    , button [ onClick Join ] [ text "Join" ]
    , input [ onInput Input, value model.input ] []
    ]


viewMessage : String -> Html Msg
viewMessage message =
  div [] [text message]
