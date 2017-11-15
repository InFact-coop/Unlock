module Models exposing (..)


type alias Model =
    { input : String
    , conversation : List Line
    , placeHolder : String
    , options : List Option
    , currentStateNumber : String
    , previousStateNumber : String
    , states : List State
    , defState : State
    }


type alias State =
    { id : String
    , response : Line
    , options : List Option
    }


type alias Option =
    { text : String
    , newState : String
    , sideClass : String
    }


type Msg
    = ChangeInput String
    | SendText
    | SendOption Option
    | ChangeState String


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
    , currentStateNumber = "greeting"
    , previousStateNumber = "greeting"
    , states = states
    , defState = state_greeting
    }


states =
    [ state_greeting
    , state_travelling_where
    , state_not_travelling
    , state_aus
    , state_can
    , state_other_travelling
    , state_america
    , state_america_live
    , state_america_travel
    ]


botStyle : String
botStyle =
    "bg-white fl br4 pr2 mw5 w5 mb3 pa3"


userStyle : String
userStyle =
    "bg-blue white fr br4 pr2 mw5 w5 mb3 pa3 w-100"


state_greeting =
    State
        "greeting"
        (Line "Hi! Are you looking for advice on travelling abroad?" botStyle)
        [ { text = "Yes!", newState = "travelling-where", sideClass = userStyle }
        , { text = "No!", newState = "not-travelling", sideClass = userStyle }
        ]


state_travelling_where =
    State
        "travelling-where"
        (Line "Where are you travelling to?" botStyle)
        [ { text = "America", newState = "america", sideClass = userStyle }
        , { text = "Australia", newState = "australia", sideClass = userStyle }
        , { text = "Canada", newState = "canada", sideClass = userStyle }
        , { text = "Other", newState = "other", sideClass = userStyle }
        ]


state_not_travelling =
    State
        "not-travelling"
        (Line "OK! I'm afraid I can't be much help with that! Try having a look at our website for more information (hub.unlock.org.uk)" botStyle)
        []


state_aus =
    State
        "australia"
        (Line "Great, you can find more information about travelling to Australia here:" botStyle)
        []


state_can =
    State
        "canada"
        (Line "Great, you can find more information about travelling to Canada here:" botStyle)
        []


state_other_travelling =
    State
        "other"
        (Line "OK! Find out more information about travelling abroad here:" botStyle)
        []


state_america =
    State
        "america"
        (Line "Are you travelling to live, work or just visit" botStyle)
        [ { text = "Live/Work", newState = "america-live", sideClass = userStyle }
        , { text = "Just Visit!", newState = "america-travel", sideClass = userStyle }
        ]


state_america_live =
    State
        "america-live"
        (Line "Cool! You can find more information about that here:" botStyle)
        []


state_america_travel =
    State
        "america-travel"
        (Line "OK, great! Have you ever been arrested or convicted for a crime that resulted in serious damage to property or serious harm to another person or government authority?" botStyle)
        [ { text = "Yes", newState = "greeting", sideClass = userStyle }
        , { text = "No", newState = "greeting", sideClass = userStyle }
        , { text = "Can you give me some examples?", newState = "greeting", sideClass = userStyle }
        ]
