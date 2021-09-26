module Projects exposing (projectsSection)

import Bootstrap.Grid exposing (col, row)
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row
import Html exposing (Attribute, Html, a, dd, dt, h3, li, text, ul)
import Html.Attributes exposing (class, href)


type alias Project =
    { title : String
    , link : Maybe String
    , description : String
    }


lgli : List (Attribute msg) -> List (Html msg) -> Html msg
lgli attr value =
    li (class "list-group-item" :: attr) value


project : Project -> Html msg
project projectData =
    lgli []
        [ dt []
            (case projectData.link of
                Just url ->
                    [ a [ href url ] [ text projectData.title ] ]

                Nothing ->
                    [ text projectData.title ]
            )
        , dd [] [ text projectData.description ]
        ]


projectsDefinitions : List Project
projectsDefinitions =
    [ { title = "Armor Comparator"
      , link = Just "/armout/"
      , description =
            """
            An application to compare costs and bonuses of various armor configurations for flying in Pathfinder.
            Originally written in raw html/css/javascript + knockout.  Rewritten in Elm.
            """
      }
    , { title = "pong?", description = "", link = Nothing }
    , { title = "Potato Clicker"
      , link = Just "/potato/"
      , description = "Start of a clicker game. To learn React. React + Redux + Typescript"
      }
    , { title = "This site"
      , description = "Written in Elm. Previously continuously build and deployed, currently only tested via CI."
      , link = Nothing
      }
    , { title = "Poketypes"
      , description = "App for visualising Pokemon type weaknesses and advantage for competetive team building. Other equivalent apps exist, but this utilizes a public API to stay up to date with the latest games. Unfortunately, the only public api I was able to find is extremely out of date."
      , link = Just "https://dyercode.github.io/poketypes/"
      }
    , { title = "Lightning Dodger"
      , description = "Auto-dodger for Final Fantasy X"
      , link = Just "/lightning/"
      }
    ]


projectsSection : Html msg
projectsSection =
    row [ Bootstrap.Grid.Row.attrs [ class "mt-4" ] ]
        [ col [ Col.topMd ]
            [ h3 [ class "text-center" ] [ text "Projects" ]
            , ul [ class "list-group list-group-flush" ]
                (List.map project projectsDefinitions)
            ]
        ]
