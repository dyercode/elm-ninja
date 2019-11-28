module Main exposing (jumbotron, main)

import Bootstrap.Grid exposing (col, container, row)
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row
import Browser
import Html exposing (Attribute, Html, a, dd, dt, h1, h3, header, li, p, text, ul)
import Html.Attributes exposing (attribute, class, href)
import Random
import Random.List exposing (choose)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { title = "Jon Dyer"
      , subTitle = ""
      }
    , randomString subtitles
    )


subtitles : List String
subtitles =
    [ "(A reasonable subtitle) => text"
    , "(idea) => code"
    , "ninja : idea -> code -> product"
    ]


type Msg
    = Subtitle String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Subtitle string ->
            ( { model | subTitle = string }
            , Cmd.none
            )


randomString : List String -> Cmd Msg
randomString l =
    Random.generate myGeneration (choose l)


myGeneration : ( Maybe String, List String ) -> Msg
myGeneration tup =
    case Tuple.first tup of
        Just str ->
            Subtitle str

        Nothing ->
            Subtitle ""


lgli : List (Attribute msg) -> List (Html msg) -> Html msg
lgli attr value =
    li (class "list-group-item" :: attr) value


projects : Html msg
projects =
    row [ Bootstrap.Grid.Row.attrs [ class "mt-4" ] ]
        [ col [ Col.topMd ]
            [ h3 [ class "text-center" ] [ text "Projects" ]
            , ul [ class "list-group list-group-flush" ]
                (List.map project
                    [ { title = "Armor Comparator"
                      , link = Just "armout/"
                      , description =
                            """
                        An application to compare costs and bonuses of various armor configurations for flying in Pathfinder.
                        Originally written in raw html/css/javascript + knockout.  Currently largely the same but put together with
                        webpack.
                        """
                      }
                    , { title = "pong?", description = "", link = Nothing }
                    , { title = "Potato Clicker"
                      , link = Just "potato/"
                      , description = "Start of a clicker game. To learn React. React + Redux + Typescript"
                      }
                    , { title = "This site"
                      , description = "Elmerific. Continuously integrated"
                      , link = Nothing
                      }
                    ]
                )
            ]
        ]


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


view : Model -> Html msg
view model =
    container [ attribute "id" "container" ]
        [ row []
            [ col []
                [ jumbotron model
                ]
            ]
        , projects
        ]


type alias Model =
    { title : String
    , subTitle : String
    }


type alias Project =
    { title : String
    , link : Maybe String
    , description : String
    }


jumbotron : Model -> Html msg
jumbotron model =
    header [ class "jumbotron" ]
        [ h1 [ class "display-4" ] [ text model.title ]
        , p [ class "lead" ] [ text model.subTitle ]
        ]
