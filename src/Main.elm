module Main exposing (..)

import Delay
import Html exposing (..)
import Models exposing (..)
import Task
import Time
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
    ( model, Delay.after 500 Time.millisecond (ChangeState model.currentStateNumber) )
