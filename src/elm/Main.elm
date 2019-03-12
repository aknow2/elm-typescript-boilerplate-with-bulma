port module Main exposing (main)

import Browser
import Html exposing (Html, input, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, onInput)

port sendMsg : String -> Cmd msg

port recivedMsg : (String -> msg) -> Sub msg

type alias Model =
    { 
      input: String,
      recived: String
    }
type alias Flags =
    ()

init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { input = "",  recived = "" } , Cmd.none )

view : Model -> Browser.Document Msg
view model =
    { body =
        [
            div [ class "container is-fluid"] [ 
                input [ class "input", onInput UpdateMsg ] []
                , button [ class "button",  onClick SendMsg ] [ text "Send Msg" ]
                , div [] [ text model.recived ]
            ]
        ]
    , title = "TypeScript Interop Boilerplate"
    }

type Msg
    = SendMsg
    | UpdateMsg  String
    | RecivedMsg String
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendMsg -> 
            ( model, sendMsg model.input )
        UpdateMsg str -> 
            ( { model | input = str } , Cmd.none )
        RecivedMsg message ->
            let
                _ =
                    Debug.log message
            in
            ( { model | recived = message } , Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    recivedMsg RecivedMsg

main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
