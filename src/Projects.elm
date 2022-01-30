module Projects exposing (isRoute, projectsSection)

import Bootstrap.Grid exposing (col, row)
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row
import Html exposing (Html, a, dd, dl, dt, h3, text, ul)
import Html.Attributes exposing (class, href)
import Url exposing (Url)


type Route
    = Home
    | Blog Blogs
    | External String


type Blogs
    = Lightning


toRoute : String -> Route
toRoute path =
    case path of
        "/" ->
            Home

        "/lightning/" ->
            Blog Lightning

        s ->
            External s


isRoute : Url -> Bool
isRoute url =
    case toRoute url.path of
        External _ ->
            False

        _ ->
            True


toFragment : Route -> String
toFragment route =
    case route of
        Home ->
            "/"

        Blog Lightning ->
            "/lightning/"

        External url ->
            url


type alias Project =
    { title : String
    , links : List Link
    , description : String
    }


type alias Link =
    { label : String
    , url : String
    }


project : Project -> Html msg
project projectData =
    dl [ class "list-group-item" ]
        [ dt [] [ text projectData.title ]
        , dd [] [ text projectData.description ]
        , displayLinks projectData.links
        ]


projectsDefinitions : List Project
projectsDefinitions =
    [ { title = "Armor Comparator"
      , links = [ appLink "/armout/", sourceLink "https://github.com/dyercode/armor-comparator" ]
      , description =
            """
            An application to compare costs and bonuses of various armor configurations for flying in Pathfinder.
            Originally written in raw html/css/javascript + knockout.  Rewritten in Elm.
            """
      }
    , { title = "pong?", description = "", links = [] }
    , { title = "Potato Clicker"
      , links = [ appLink "/potato/" ]
      , description = "Start of a clicker game. To learn React. React + Redux + Typescript"
      }
    , { title = "This site"
      , description = "Written in Elm. Previously continuously build and deployed, currently only tested via CI."
      , links = []
      }
    , { title = "Poketypes"
      , description = """
App for visualizing Pokemon type weaknesses and advantage for competitive team building.
Other equivalent apps exist, but this utilizes a public API to stay up to date with the
latest games. Unfortunately, the only public api I was able to find is extremely out of date."""
      , links = [ appLink "https://dyercode.github.io/poketypes/" ]
      }
    , { title = "Lightning Dodger"
      , description = "Auto-dodger for Final Fantasy X"
      , links = [ blogLink Lightning ]
      }
    , { title = "Game of Life"
      , description = """
      Game of life implementation based on an approach I found interesting at a Global Day of
      Coderetreat where the board state is stored by nesting closures. 
      """
      , links =
            [ appLink "https://dyercode.github.io/gol/"
            , sourceLink "https://github.com/dyercode/gol/"
            ]
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
            [ h3 [ class "text-center" ] [ text "Projects" ]
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
