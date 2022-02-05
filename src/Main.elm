port module Main exposing (jumbotron, main)

import Bootstrap.Grid exposing (col, container, row)
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Html exposing (Html, h1, header, p, text)
import Html.Attributes exposing (attribute, class)
import Lightning exposing (writeup)
import Projects exposing (projectsSection)
import Random
import Random.List exposing (choose)
import Route exposing (isRoute)
import Task
import Url


type alias Flags =
    { basePath : String }


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init { basePath } url key =
    ( { title = "Jon Dyer"
      , subTitle = ""
      , key = key
      , url = url
      , basePath = basePath
      }
    , randomString subtitles
    )


subtitles : List String
subtitles =
    [ "(A reasonable subtitle) => text"
    , "(idea) => code"
    , "ninja : idea -> code -> product"
    , "@wip"
    , "this is random, reroll coming soon to this option"
    ]


type Msg
    = Subtitle String
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOp


port consoleLog : String -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Subtitle string ->
            ( { model | subTitle = string }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    if isRoute url model.basePath then
                        ( model
                        , Cmd.batch
                            [ consoleLog ("internal url: \"" ++ Url.toString url ++ "\"")
                            , Nav.pushUrl model.key (Url.toString url)
                            , Task.perform (\_ -> NoOp) (Dom.setViewport 0 0)
                            ]
                        )

                    else
                        ( model
                        , Cmd.batch
                            [ consoleLog ("external url: \"" ++ Url.toString url ++ "\"")
                            , Nav.load (Url.toString url)
                            ]
                        )

                Browser.External href ->
                    ( model
                    , Cmd.batch
                        [ consoleLog ("naturally external url: \"" ++ href ++ "\"")
                        , Nav.load href
                        ]
                    )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


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


view : Model -> Browser.Document msg
view model =
    let
        page =
            case urlToPage model.url of
                Main ->
                    projectsPage

                Lightning ->
                    lightningPage
    in
    { title = model.title
    , body =
        [ page model
        ]
    }


type Page
    = Main
    | Lightning


urlToPage : Url.Url -> Page
urlToPage url =
    case url.path of
        "/lightning/" ->
            Lightning

        _ ->
            Main


sectionWithHeader : Model -> Html msg -> Html msg
sectionWithHeader model section =
    container [ attribute "id" "container", class "col-lg-8" ]
        [ jumbotron model
        , section
        ]


projectsPage : Model -> Html msg
projectsPage model =
    sectionWithHeader model (projectsSection model.basePath)


lightningPage : Model -> Html msg
lightningPage model =
    sectionWithHeader model writeup


type alias Model =
    { title : String
    , subTitle : String
    , key : Nav.Key
    , url : Url.Url
    , basePath : String
    }


jumbotron : { a | title : String, subTitle : String } -> Html msg
jumbotron titles =
    row []
        [ col []
            [ header
                [ class "p-5"
                , class "mb-4"
                , class "mt-4"
                , class "border"
                , class "border-1"
                , class "border-dark"
                , class "rounded-3"
                , class "jumbotron"
                , class "shadow-sm"
                ]
                [ h1 [ class "display-4" ] [ text titles.title ]
                , p [ class "lead" ] [ text titles.subTitle ]
                ]
            ]
        ]
