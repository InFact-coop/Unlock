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


state_greeting =
    State
        "greeting"
        (Line "Hi! Are you looking for advice on travelling abroad?" "tl")
        [ { text = "Yes!", newState = "travelling-where", sideClass = "tr" }
        , { text = "No!", newState = "not-travelling", sideClass = "tr" }
        ]


state_travelling_where =
    State
        "travelling-where"
        (Line "Where are you travelling to?" "tl")
        [ { text = "America", newState = "america", sideClass = "tr" }
        , { text = "Australia", newState = "australia", sideClass = "tr" }
        , { text = "Canada", newState = "canada", sideClass = "tr" }
        , { text = "Other", newState = "other", sideClass = "tr" }
        ]


state_not_travelling =
    State
        "not-travelling"
        (Line "OK! I'm afraid I can't be much help with that! Try having a look at our website for more information (hub.unlock.org.uk)" "tl")
        []


state_aus =
    State
        "australia"
        (Line "Great, you can find more information about travelling to Australia here:" "tl")
        []


state_can =
    State
        "canada"
        (Line "Great, you can find more information about travelling to Canada here:" "tl")
        []


state_other_travelling =
    State
        "other"
        (Line "OK! Find out more information about travelling abroad here:" "tl")
        []


state_america =
    State
        "america"
        (Line "Are you travelling to live, work or just visit" "tl")
        [ { text = "Live/Work", newState = "america-live", sideClass = "tr" }
        , { text = "Just Visit!", newState = "america-travel", sideClass = "tr" }
        ]


state_america_live =
    State
        "america-live"
        (Line "Cool! You can find more information about that here:" "tl")
        []


state_america_travel =
    State
        "america-travel"
        (Line "OK, great! Have you ever been arrested or convicted for a crime that resulted in serious damage to property or serious harm to another person or government authority?" "tl")
        [ { text = "Yes", newState = "greeting", sideClass = "tr" }
        , { text = "No", newState = "greeting", sideClass = "tr" }
        , { text = "Can you give me some examples?", newState = "greeting", sideClass = "tr" }
        ]
