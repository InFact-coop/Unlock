-- UPDATE


module Update exposing (..)

import Models exposing (..)
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeInput newInput ->
            ( { model | input = newInput }, Cmd.none )

        SendText ->
            ( { model
                | conversation = model.conversation ++ [ Line model.input "tr" ]
                , input = ""
              }
            , Cmd.none
            )

        SendOption option ->
            ( { model
                | conversation = model.conversation ++ [ Line option.text option.sideClass ]
              }
            , Task.perform ChangeState (Task.succeed option.newState)
            )

        ChangeState stateId ->
            let
                newState =
                    case stateToChangeTo stateId model of
                        Just state ->
                            state

                        Nothing ->
                            model.defState
            in
            ( { model
                | input = ""
                , conversation = model.conversation ++ [ newState.response ]
                , options = newState.options
                , currentStateNumber = newState.id
                , previousStateNumber = model.currentStateNumber
              }
            , Cmd.none
            )


stateToChangeTo : Int -> Model -> Maybe State
stateToChangeTo newStateId model =
    model.states
        |> List.filter (\state -> state.id == newStateId)
        |> List.head
