-- VIEW


module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "br3 light-grey-background vh-50 shadow-1-ns overflow-auto-ns min-height", id "chat" ]
        [ div [ class "fixed w416 tc gray bg-white pa3 br3 br--top-m grey-font b f4" ] [ text "Unlock Chat" ]
        , div [ class "mt5 mb2" ] []
        , div []
            [ ul [ class "list pa3 ma0" ]
                (model.conversation
                    |> List.map eachLine
                )
            ]
        , options model
        ]


options : Model -> Html Msg
options model =
    div [ class "w5" ]
        [ div [ class "br2 fl mw5 ml3 w-auto flex justify-around" ] [ ul [ class "pa0" ] (model.options |> List.map eachOption) ]
        ]


eachOption : Option -> Html Msg
eachOption option =
    div [ class "grow grow_bot_speech inline-flex flex-wrap" ]
        [ button [ class "purple-background white bn br-50 pa3 ma1 fw1", onClick (SendOption option) ] [ text option.line.text ] ]


eachLine : Line -> Html Msg
eachLine line =
    div [ class "" ]
        [ div [ class "" ]
            [ li [ class ("" ++ line.sideClass) ] [ text line.text ]
            ]
        , if List.length line.links > 0 then
            div [ class ("wrap mt2 " ++ line.sideClass) ]
                (line.links
                    |> List.map linksList
                )
          else
            div [] []
        ]


linksList : String -> Html Msg
linksList link =
    a [ class "grow_bot_speech", href link, target "_blank" ] [ text link ]


textInput : Model -> Html Msg
textInput model =
    Html.form
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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
