module Main exposing (..)

import Html exposing (..)
import Models exposing (..)
import Update exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )
