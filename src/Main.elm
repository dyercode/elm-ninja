module Main exposing (main)

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


type alias Model =
    { title : String
    , subTitle : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { title = "Jon Dyer"
      , subTitle = ""
      }
    , rlist subtitles
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


rlist : List String -> Cmd Msg
rlist l =
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
                [ lgli []
                    [ dt []
                        [ a [ href "armout/" ]
                            [ text "Armor Comparator" ]
                        ]
                    , dd []
                        [ text """
                        An application to compare costs and bonuses of various armor configurations for flying in Pathfinder.
                        Originally written in raw html/css/javascript + knockout.  Currently largely the same but put together with
                        webpack.
                        """
                        ]
                    ]
                , lgli [] [ text "pong?" ]
                , lgli []
                    [ dt [] [ a [ href "potato/" ] [ text "Potato Clicker" ] ]
                    , dd [] [ text "Start of a clicker game. To learn React. React + Redux + Typescript" ]
                    ]
                , lgli []
                    [ dt [] [ text "This site" ]
                    , dd [] [ text "Elmerific. Continuously integrated" ]
                    ]
                ]
            ]
        ]


view : Model -> Html msg
view model =
    container [ attribute "id" "container" ]
        --        [ CDN.stylesheet
        [ row []
            [ col []
                [ header [ class "jumbotron" ]
                    [ h1 [ class "display-4" ] [ text model.title ]
                    , p [ class "lead" ] [ text model.subTitle ]
                    ]
                ]
            ]
        , projects
        ]
