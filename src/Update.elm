-- UPDATE


module Update exposing (..)

import Models exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeInput newInput ->
            ( { model | input = newInput }, Cmd.none )

        SendText ->
            ( { model
                | conversation = model.conversation ++ [ model.input ]
                , input = ""
              }
            , Cmd.none
            )

        SendOption option ->
            ( { model
                | conversation = model.conversation ++ [ option ]
                , input = ""
              }
            , Cmd.none
            )
