module Main exposing (main)

import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup
import Bootstrap.Grid exposing (..)
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row
import Bootstrap.ListGroup as ListGroup
import Browser
import Html exposing (Html, a, dd, dt, h1, h3, header, li, p, text, ul)
import Html.Attributes exposing (attribute, class, classList, href)
import Html.Events exposing (onClick)
import Random exposing (Generator)
import Random.List exposing (choose)


type alias Model =
    { count : Int
    , title : String
    , subTitle : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { count = 0
      , title = "Jon Dyer"
      , subTitle = ""
      }
    , rlist subtitles
    )


subtitles =
    [ "(A reasonable subtitle) => text"
    , "(idea) => code"
    , "ninja : idea -> code -> product"
    ]


type Msg
    = Increment
    | Decrement
    | MyString String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Decrement ->
            ( { model | count = model.count - 1 }
            , Cmd.none
            )

        MyString string ->
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
            MyString str

        Nothing ->
            MyString ""


lgli attr value =
    li (class "list-group-item" :: attr) value


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
                    [ dt [] [ text "Potato Clicker" ]
                    , dd [] [ text "Start of a clicker game. To learn React. React + Redux + Typescript" ]
                    ]
                , lgli []
                    [ dt [] [ text "This site" ]
                    , dd [] [ text "Elmerific. Continuously integrated" ]
                    ]
                ]
            ]
        ]


counter model =
    row []
        [ col []
            [ ButtonGroup.buttonGroup []
                [ ButtonGroup.button [ Button.primary, Button.attrs [ onClick Increment ] ] [ text "+1" ]
                , ButtonGroup.button [] [ text <| String.fromInt model.count ]
                , ButtonGroup.button [ Button.danger, Button.attrs [ onClick Decrement ] ] [ text "-1" ]
                ]
            ]
        ]


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
        , counter model
        , projects
        ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
