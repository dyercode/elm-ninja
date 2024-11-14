module Projects exposing (projectsSection)

import Bootstrap.Grid exposing (col, row)
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row
import Html exposing (Html, a, dd, dl, dt, h2, p, text, ul)
import Html.Attributes exposing (class, href)
import ProjectData exposing (Link(..), Project)


project : Project -> Html msg
project projectData =
    dl [ class "list-group-item" ]
        [ dt [] [ text projectData.title ]
        , dd [] <| List.map (\paragraph -> p [] [ text paragraph ]) projectData.description
        , displayLinks projectData.links
        ]


linkLabel : Link -> String
linkLabel l =
    case l of
        BlogLink _ ->
            "Blog"

        App _ ->
            "App"

        Source _ ->
            "Source"


projectsSection : List Project -> Html msg
projectsSection ps =
    row [ Bootstrap.Grid.Row.attrs [ class "mt-4" ] ]
        [ col [ Col.topMd ]
            [ h2 [ class "text-center" ] [ text "Projects" ]
            , ul [ class "list-group list-group-flush" ] <|
                List.map project ps
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
        [ a [ href (ProjectData.url link) ] [ text <| linkLabel link ]
        ]


htmlNil : Html msg
htmlNil =
    Html.text ""
