-- UPDATE


module Update exposing (..)

import Delay
import Models exposing (..)
import Task
import Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeInput newInput ->
            ( { model | input = newInput }, Cmd.none )

        SendText ->
            ( { model
                | conversation = model.conversation ++ [ Line model.input userStyle ]
                , input = ""
              }
            , Cmd.none
            )

        SendOption option ->
            ( { model
                | conversation = model.conversation ++ [ Line option.text option.sideClass, Line "..." botStyle ]
                , options = []
              }
            , Delay.after 750 Time.millisecond (ChangeState option.newState)
            )

        ChangeState stateId ->
            let
                newState =
                    case stateToChangeTo stateId model of
                        Just state ->
                            state

                        Nothing ->
                            model.defState

                newListLength =
                    List.length model.conversation - 1

                newConversations =
                    List.take newListLength model.conversation ++ [ newState.response ]
            in
            ( { model
                | input = ""
                , conversation = newConversations
                , options = newState.options
                , currentStateNumber = newState.id
                , previousStateNumber = model.currentStateNumber
              }
            , Cmd.none
            )


stateToChangeTo : String -> Model -> Maybe State
stateToChangeTo newStateId model =
    model.states
        |> List.filter (\state -> state.id == newStateId)
        |> List.head
