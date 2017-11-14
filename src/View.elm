-- VIEW


module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "" ]
        [ div []
            [ ul [ class "" ]
                (model.conversation
                    |> List.map eachLine
                )
            ]
        , askInput model
        ]


askInput : Model -> Html Msg
askInput model =
    div [ class "" ]
        [ Html.form
            [ class
                ""
            , onWithOptions "submit" { stopPropagation = False, preventDefault = True } (Json.succeed SendText)
            ]
            [ fieldset [ class "" ]
                [ div [ class "" ]
                    [ label [ class "", for "user-input" ] []
                    , input [ class "w-30", placeholder model.placeHolder, onInput ChangeInput, value model.input ] []
                    , input [ class "ma2", type_ "submit", value "Ask away!" ] []
                    ]
                ]
            ]
        , ul [] (model.options |> List.map eachOption)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


eachLine : String -> Html Msg
eachLine line =
    li [ class "" ]
        [ text line ]


eachOption : String -> Html Msg
eachOption option =
    button [ onClick (SendOption option) ] [ text option ]
