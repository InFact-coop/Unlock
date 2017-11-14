module Models exposing (..)


type alias Model =
    { input : String
    , conversation : List String
    , placeHolder : String
    , options : List String
    }


model : Model
model =
    { input = ""
    , conversation = []
    , placeHolder = "Enter your questions here"
    , options = [ "Option 1", "Option 2" ]
    }


type Msg
    = ChangeInput String
    | SendText
    | SendOption String
