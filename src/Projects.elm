module Projects exposing (projectsSection)

import Bootstrap.Grid exposing (col, row)
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row
import Html exposing (Html, a, dd, dl, dt, h2, p, text, ul)
import Html.Attributes exposing (class, href)
import Route exposing (Blogs(..), Route(..), toFragment)


type alias Project =
    { title : String
    , links : List Link
    , description : List String
    }


type alias Link =
    { label : String
    , url : String
    }


project : Project -> Html msg
project projectData =
    dl [ class "list-group-item" ]
        [ dt [] [ text projectData.title ]
        , dd [] <| List.map (\paragraph -> p [] [ text paragraph ]) projectData.description
        , displayLinks projectData.links
        ]


projectsDefinitions : List Project
projectsDefinitions =
    [ { title = "Kubernetes Cluster"
      , description = [ """
        This site the other apps hosted on this domain are running in Kubernetes (k3s).
        """ ]
      , links = []
      }
    , { title = "Game of Life"
      , description =
            [ """
      Game of life implementation based on an approach I found interesting at a Global Day of
      Coderetreat where the board state is stored by nesting closures."""
            , """Demo site runs a fixed starting pattern which continues indefinitely. The user cannot change the state of the board."""
            ]
      , links =
            [ appLink "https://dyercode.github.io/gol/"
            , sourceLink "https://github.com/dyercode/gol/"
            ]
      }
    , { title = "IOLights"
      , description = [ """
    Pi4j and Cats Effect app to toggle a lamp. Created to keep pet on a regular schedule. Has
    rudimentary scheduler and rest api. Also controlled by offline voice activation by a
    separate, private, project using a Google AIY Voice Kit.
    """ ]
      , links = []
      }
    , { title = "Armor Comparator"
      , links = [ appLink "/armor/", sourceLink "https://github.com/dyercode/armor-comparator" ]
      , description =
            [ """
            An application to compare costs and bonuses of various armor configurations for flying in some Tabletop RPG.
            Originally written in raw HTML/CSS/Javascript + Knockout.  Rewritten in Elm.
            """ ]
      }
    , { title = "Potato Clicker"
      , links = [ appLink "/potato/" ]
      , description = [ "Start of a clicker game. To learn React. React + Redux + Typescript" ]
      }
    , { title = "This site"
      , description = [ "Written in Elm. Running in Kubernetes." ]
      , links = [ sourceLink "https://github.com/dyercode/elm-ninja/" ]
      }
    , { title = "Poketypes"
      , description = [ """
App for visualizing Pokemon type weaknesses and advantage for competitive team building.
Other equivalent apps exist, but this utilizes a public API to stay up to date with the
latest games. Doesn't account natively for terastalizing.""" ]
      , links = [ appLink "https://dyercode.github.io/poketypes/" ]
      }
    , { title = "Lightning Dodger"
      , description = [ "Auto-dodger for Final Fantasy X" ]
      , links = [ blogLink Lightning ]
      }
    , { title = "(A)Chievos"
      , description =
            [ "Achievement tracker for a certain game. Not yet ready for prime time, but I want to talk about it."
            , """Built for Kubernetes with an Elm frontend and Scala backend REST API. Uses Http4s, Cats, and doobie.
                 Currently has user authentication and integration with third party APIs.
                 Achievements themselves are planned to be customizable. Adding additional API types is in consideration."""
            ]
      , links = []
      }
    ]


blogLink : Blogs -> Link
blogLink blog =
    { label = "Blog", url = toFragment (Blog blog) }


sourceLink : String -> Link
sourceLink url =
    { label = "Source", url = url }


appLink : String -> Link
appLink url =
    { label = "App", url = url }


projectsSection : Html msg
projectsSection =
    row [ Bootstrap.Grid.Row.attrs [ class "mt-4" ] ]
        [ col [ Col.topMd ]
            [ h2 [ class "text-center" ] [ text "Projects" ]
            , ul [ class "list-group list-group-flush" ] <|
                List.map project projectsDefinitions
            ]
        ]


displayLinks : List Link -> Html msg
displayLinks links =
    case links of
        [] ->
            htmlNil

        ls ->
            dl [ class "ms-3" ]
                (dt
                    []
                    [ text <|
                        "Link"
                            ++ (if List.length ls == 1 then
                                    ""

                                else
                                    "s"
                               )
                    ]
                    :: List.map projectLink ls
                )


projectLink : Link -> Html msg
projectLink link =
    dd []
        [ a [ href link.url ] [ text link.label ]
        ]


htmlNil : Html msg
htmlNil =
    Html.text ""
