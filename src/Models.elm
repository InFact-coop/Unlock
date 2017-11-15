module Models exposing (..)


type alias Model =
    { input : String
    , conversation : List Line
    , placeHolder : String
    , options : List Option
    , currentStateNumber : Int
    , previousStateNumber : Int
    , states : List State
    , defState : State
    }


type alias State =
    { id : Int
    , response : Line
    , options : List Option
    }


type alias Option =
    { text : String
    , newState : Int
    , sideClass : String
    }


type Msg
    = ChangeInput String
    | SendText
    | SendOption Option
    | ChangeState Int


type alias Line =
    { text : String
    , sideClass : String
    }


model : Model
model =
    { input = ""
    , conversation = []
    , placeHolder = "Enter your questions here"
    , options = []
    , currentStateNumber = 0
    , previousStateNumber = -1
    , states = [ state0, state1, state2, state3 ]
    , defState = state0
    }


botStyle : String
botStyle =
    "bg-white fl br4 pr2 mw5 w5 mb3 pa3"


userStyle : String
userStyle =
    "bg-blue white fr br4 pr2 mw5 w5 mb3 pa3 w-100"


state0 =
    State
        0
        (Line "Hi! How are you?" botStyle)
        [ { text = "Good", newState = 1, sideClass = userStyle }
        , { text = "Not good", newState = 2, sideClass = userStyle }
        ]


state1 =
    State
        1
        (Line "Good that you are good." botStyle)
        [ { text = "How are you", newState = 3, sideClass = userStyle }
        , { text = "Actually, I am not good", newState = 2, sideClass = userStyle }
        ]


state2 =
    State
        2
        (Line "Bad that you are not good. Start again?" botStyle)
        [ { text = "Yeah", newState = 0, sideClass = userStyle }
        , { text = "No, how are you?", newState = 3, sideClass = userStyle }
        ]


state3 =
    State
        3
        (Line "I'm great thanks!" botStyle)
        [ { text = "Cool. Lets start again", newState = 0, sideClass = userStyle } ]
