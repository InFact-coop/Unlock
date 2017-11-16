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
    | NoOp
    | AddThinking Option


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
    , state_prop_examples
    , state_drug
    , state_terror
    , state_fraud
    , state_esta
    , state_visa
    , state_more_than_6
    , state_less_than_6
    , state_visa_help
    , state_lying
    , state_thanks
    ]


botStyle : String
botStyle =
    "bg-white fl br4 pr2 mw5 w5 pa3"


userStyle : String
userStyle =
    "blue-background white fr br4 pr2 mw5 w5 mb3 pa3 w-100 mt3"


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
        [ { line = Line "Thanks" userStyle [], newState = "thanks" } ]


state_america_travel =
    State
        "america-travel"
        (Line "OK, great! Have you ever been arrested or convicted for a crime that resulted in serious damage to property or serious harm to another person or government authority?" botStyle [])
        [ { line = Line "Yes" userStyle [], newState = "visa" }
        , { line = Line "No" userStyle [], newState = "drug-crimes" }
        , { line = Line "Can you give me some examples?" userStyle [], newState = "prop-examples" }
        ]


state_prop_examples =
    State
        "prop-examples"
        (Line "Some examples are: \n Blackmail Burglary Arson Counterfieting, Tax Evasion Adultery Gross Indecency and Mayhem \n A comprehensive list can be found here:" botStyle [ "https://hub.unlock.org.uk/wp-content/uploads/Annex-A-Crimes-involving-moral-turpitude.pdf" ])
        [ { line = Line "Yes" userStyle [], newState = "visa" }
        , { line = Line "No" userStyle [], newState = "drug-crimes" }
        ]


state_drug =
    State
        "drug-crimes"
        (Line "Have you ever violated any law relating to possesing, using or distributing illegal drugs?" botStyle [])
        [ { line = Line "Yes" userStyle [], newState = "visa" }
        , { line = Line "No" userStyle [], newState = "terrorist-crimes" }
        ]


state_terror =
    State
        "terrorist-crimes"
        (Line "Do you seek to engage in or have you ever engaged in terrorist activitiess espionage, sabotage or genocide?" botStyle [])
        [ { line = Line "Yes" userStyle [], newState = "visa" }
        , { line = Line "No" userStyle [], newState = "fraud-crimes" }
        ]


state_fraud =
    State
        "fraud-crimes"
        (Line "Have you ever committed fraud or misrepresented yourself to obtain, or assisted others to obtain, a visa or entry into the USA" botStyle [])
        [ { line = Line "Yes" userStyle [], newState = "visa" }
        , { line = Line "No" userStyle [], newState = "esta" }
        ]


state_esta =
    State
        "esta"
        (Line "Great news, you can travel on an ESTA! Learn more about how to apply for one here: " botStyle [ "http://hub.unlock.org.uk/knowledgebase/travelling-to-the-usa-the-esta-form-and-moral-turpitude/" ])
        [ { line = Line "Thanks" userStyle [], newState = "thanks" }
        ]


state_visa =
    State
        "visa"
        (Line "OK, you'll probably need to apply for a visa - this can take some time, when are you planning to travel?" botStyle [])
        [ { line = Line "In less than 6 months time" userStyle [], newState = "less-than-6" }
        , { line = Line "In more than 6 months time" userStyle [], newState = "more-than-6" }
        ]


state_more_than_6 =
    State
        "more-than-6"
        (Line "OK, that should be fine, you should apply to the US Embassy for a visa. You can find out more about how to do that here: " botStyle [ "http://hub.unlock.org.uk/knowledgebase/travelling-us-need-visa/" ])
        []


state_less_than_6 =
    State
        "less-than-6"
        (Line "OK, applying for a visa to the US can take any time between 12 weeks and 6 months, and sometimes even longer than that" botStyle [ "http://hub.unlock.org.uk/knowledgebase/travelling-us-need-visa/" ])
        [ { line = Line "So what can I do?" userStyle [], newState = "visa-help" } ]


state_visa_help =
    State
        "visa-help"
        (Line "We would strongly recommended not booking a holiday or postponing a current holiday until you are certain you have your visa." botStyle [])
        [ { line = Line "If I don’t declare my conviction, is there any way they can find out?" userStyle [], newState = "lying" } ]


state_lying =
    State
        "lying"
        (Line "The answer is probably 'no' but there are obviously some risks involved. You can see more information about what happens if you lie on the ESTA form here on this page: " botStyle [ "http://hub.unlock.org.uk/knowledgebase/travelling-to-the-usa-the-esta-form-and-moral-turpitude/#vwp" ])
        [ { line = Line "Thanks" userStyle [], newState = "thanks" } ]


state_thanks =
    State
        "thanks"
        (Line "No problem! Thanks for chatting with me, I hope I've helped. If not, I'm very sorry, if you still require more information on travel, have a look here: " botStyle [ "https://hub.unlock.org.uk/information/travelling-abroad" ])
        []
