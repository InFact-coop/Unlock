module Models exposing (..)


type alias Model =
    { input : String
    , conversation : List { text : String, sideClass : String }
    , placeHolder : String
    , options : List Option
    , currentStateNumber : Int
    , previousStateNumber : Int
    , states : List State
    , defState : State
    }


model : Model
model =
    { input = ""
    , conversation = []
    , placeHolder = "Enter your questions here"
    , options = []
    , currentStateNumber = 0
    , previousStateNumber = -1
    , states = states
    , defState = State 0 { text = "Hi! How are you?", sideClass = "tl" } [ { text = "Good", newState = 1, sideClass = "tr" }, { text = "Not good", newState = 2, sideClass = "tr" } ]
    }


type alias State =
    { id : Int
    , response : { text : String, sideClass : String }
    , options : List Option
    }


type alias Option =
    { text : String
    , newState : Int
    , sideClass : String
    }


states : List State
states =
    let
        state0 =
            State 0 { text = "Hi! How are you?", sideClass = "tl" } [ { text = "Good", newState = 1, sideClass = "tr" }, { text = "Not good", newState = 2, sideClass = "tr" } ]

        state1 =
            State 1 { text = "Good that you are good.", sideClass = "tl" } [ { text = "How are you", newState = 3, sideClass = "tr" }, { text = "Actually, I am not good", newState = 2, sideClass = "tr" } ]

        state2 =
            State 2 { text = "Bad that you are not good. Start again?", sideClass = "tl" } [ { text = "Yeah", newState = 0, sideClass = "tr" }, { text = "No, how are you?", newState = 3, sideClass = "tr" } ]

        state3 =
            State 3 { text = "I'm great thanks!", sideClass = "tl" } [ { text = "Cool. Lets start again", newState = 0, sideClass = "tr" } ]
    in
    [ state0, state1, state2, state3 ]


type Msg
    = ChangeInput String
    | SendText
    | SendOption Option
    | ChangeState Int
