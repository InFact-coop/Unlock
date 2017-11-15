-- VIEW


module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "br3 light-grey-background vh-50 shadow-1-ns overflow-auto-ns" ]
        [ div [ class "tc gray bg-white pa3 br3 br--top-m grey-font b f4" ] [ text "Unlock Chat" ]
        , div []
            [ ul [ class "list pa3 ma0" ]
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
                "clip"
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
        , div [ class "bg-white br2 fl br4 ml3 pa2 mw5 w-auto flex justify-around" ] [ ul [ class "pa0" ] (model.options |> List.map eachOption) ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


eachLine : { text : String, sideClass : String } -> Html Msg
eachLine line =
    div [ class "" ]
        [ div [ class "" ]
            [ li [ class ("" ++ line.sideClass) ] [ text line.text ]
            ]
        ]


eachOption : Option -> Html Msg
eachOption option =
    div [ class "inline-flex flex-wrap" ]
        [ button [ class "purple-background white bn br-50 pa3 ma1 fw1", onClick (SendOption option) ] [ text option.text ] ]
