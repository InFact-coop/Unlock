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


state0 =
    State
        0
        (Line "Hi! How are you?" "tl")
        [ { text = "Good", newState = 1, sideClass = "tr" }
        , { text = "Not good", newState = 2, sideClass = "tr" }
        ]


state1 =
    State
        1
        (Line "Good that you are good." "tl")
        [ { text = "How are you", newState = 3, sideClass = "tr" }
        , { text = "Actually, I am not good", newState = 2, sideClass = "tr" }
        ]


state2 =
    State
        2
        (Line "Bad that you are not good. Start again?" "tl")
        [ { text = "Yeah", newState = 0, sideClass = "tr" }
        , { text = "No, how are you?", newState = 3, sideClass = "tr" }
        ]


state3 =
    State
        3
        (Line "I'm great thanks!" "tl")
        [ { text = "Cool. Lets start again", newState = 0, sideClass = "tr" } ]
