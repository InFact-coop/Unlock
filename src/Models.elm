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
    { newState : String
    , line : Line
    }


type Msg
    = ChangeInput String
    | SendText
    | SendOption Option
    | ChangeState String


type alias Line =
    { text : String
    , sideClass : String
    , links : List String
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
    "blue-background white fr br4 pr2 mw5 w5 mb3 pa3 w-100"


state_greeting =
    State
        "greeting"
        (Line
            "Hi! Are you looking for advice on travelling abroad?"
            botStyle
            []
        )
        [ { line = { text = "Yes!", sideClass = userStyle, links = [] }, newState = "travelling-where" }
        , { line = { text = "No!", sideClass = userStyle, links = [] }, newState = "not-travelling" }
        ]


state_travelling_where =
    State
        "travelling-where"
        (Line "Where are you travelling to?" botStyle [])
        [ { line = Line "America" userStyle [], newState = "america" }
        , { line = Line "Australia" userStyle [], newState = "australia" }
        , { line = Line "Canada" userStyle [], newState = "canada" }
        , { line = Line "Other" userStyle [], newState = "other" }
        ]


state_not_travelling =
    State
        "not-travelling"
        (Line "OK! I'm afraid I can't be much help with that! Try having a look at our website for more information:" botStyle [ "https://hub.unlock.org.uk" ])
        []


state_aus =
    State
        "australia"
        (Line "Great, you can find more information about travelling to Australia here:" botStyle [ "https://hub.unlock.org.uk/knowledgebase/travelling-australia" ])
        []


state_can =
    State
        "canada"
        (Line "Great, you can find more information about travelling to Canada here:" botStyle [ "https://hub.unlock.org.uk/knowledgebase/travelling-canada" ])
        []


state_other_travelling =
    State
        "other"
        (Line "OK! Find out more information about travelling abroad here:"
            botStyle
            [ "https://hub.unlock.org.uk/information/travelling-abroad" ]
        )
        []


state_america =
    State
        "america"
        (Line "Are you travelling to live, work or just visit" botStyle [])
        [ { line = Line "Live/Work" userStyle [], newState = "america-live" }
        , { line = Line "Just Visit!" userStyle [], newState = "america-travel" }
        ]


state_america_live =
    State
        "america-live"
        (Line "Cool! You can find more information about that here:"
            botStyle
            [ "https://uk.usembassy.gov/visas/visa-information-services/" ]
        )
        []


state_america_travel =
    State
        "america-travel"
        (Line "OK, great! Have you ever been arrested or convicted for a crime that resulted in serious damage to property or serious harm to another person or government authority?" botStyle [])
        [ { line = Line "Yes" userStyle [], newState = "greeting" }
        , { line = Line "No" userStyle [], newState = "greeting" }
        , { line = Line "Can you give me some examples?" userStyle [], newState = "greeting" }
        ]
