module Main exposing (Model, Msg, jumbotron, main)

import Bootstrap.Grid exposing (col, container, row)
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Coverage
import Html exposing (Html, h1, header, p, text)
import Html.Attributes exposing (attribute, class)
import Lightning exposing (writeup)
import Projects exposing (projectsSection)
import Random
import Random.List exposing (choose)
import Route exposing (isRoute)
import Task
import Url


main : Program () Model Msg
main =
    let
        _ =
            Coverage.track "Main" 1
    in
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions =
            \_ ->
                let
                    _ =
                        Coverage.track "Main" 0
                in
                Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        _ =
            Coverage.track "Main" 2
    in
    ( { title = "Jon Dyer"
      , subTitle = ""
      , key = key
      , url = url
      }
    , randomString subtitles
    )


subtitles : List String
subtitles =
    let
        _ =
            Coverage.track "Main" 3
    in
    [ "(A reasonable subtitle) => text"
    , "(idea) => code"
    , "ninja : idea -> code -> product"
    , "@wip"
    ]


type Msg
    = Subtitle String
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        _ =
            Coverage.track "Main" 13
    in
    case msg of
        Subtitle string ->
            let
                _ =
                    Coverage.track "Main" 4
            in
            ( { model | subTitle = string }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            let
                _ =
                    Coverage.track "Main" 10
            in
            case urlRequest of
                Browser.Internal url ->
                    let
                        _ =
                            Coverage.track "Main" 8
                    in
                    if isRoute url then
                        let
                            _ =
                                Coverage.track "Main" 6
                        in
                        ( model
                        , Cmd.batch
                            [ Nav.pushUrl model.key (Url.toString url)
                            , Task.perform
                                (\_ ->
                                    let
                                        _ =
                                            Coverage.track "Main" 5
                                    in
                                    NoOp
                                )
                                (Dom.setViewport 0 0)
                            ]
                        )

                    else
                        let
                            _ =
                                Coverage.track "Main" 7
                        in
                        ( model, Nav.load (Url.toString url) )

                Browser.External href ->
                    let
                        _ =
                            Coverage.track "Main" 9
                    in
                    ( model, Nav.load href )

        UrlChanged url ->
            let
                _ =
                    Coverage.track "Main" 11
            in
            ( { model | url = url }, Cmd.none )

        NoOp ->
            let
                _ =
                    Coverage.track "Main" 12
            in
            ( model, Cmd.none )


randomString : List String -> Cmd Msg
randomString l =
    let
        _ =
            Coverage.track "Main" 14
    in
    Random.generate myGeneration (choose l)


myGeneration : ( Maybe String, List String ) -> Msg
myGeneration tup =
    let
        _ =
            Coverage.track "Main" 17
    in
    case Tuple.first tup of
        Just str ->
            let
                _ =
                    Coverage.track "Main" 15
            in
            Subtitle str

        Nothing ->
            let
                _ =
                    Coverage.track "Main" 16
            in
            Subtitle ""


view : Model -> Browser.Document msg
view model =
    let
        _ =
            Coverage.track "Main" 21

        page : Model -> Html msg
        page =
            let
                _ =
                    Coverage.track "Main" 20
            in
            case urlToPage model.url of
                Main ->
                    let
                        _ =
                            Coverage.track "Main" 18
                    in
                    projectsPage

                Lightning ->
                    let
                        _ =
                            Coverage.track "Main" 19
                    in
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
    let
        _ =
            Coverage.track "Main" 24
    in
    case url.path of
        "/lightning/" ->
            let
                _ =
                    Coverage.track "Main" 22
            in
            Lightning

        _ ->
            let
                _ =
                    Coverage.track "Main" 23
            in
            Main


sectionWithHeader : Model -> Html msg -> Html msg
sectionWithHeader model section =
    let
        _ =
            Coverage.track "Main" 25
    in
    container [ attribute "id" "container", class "col-lg-8" ]
        [ jumbotron model
        , section
        ]


projectsPage : Model -> Html msg
projectsPage model =
    let
        _ =
            Coverage.track "Main" 26
    in
    sectionWithHeader model projectsSection


lightningPage : Model -> Html msg
lightningPage model =
    let
        _ =
            Coverage.track "Main" 27
    in
    sectionWithHeader model writeup


type alias Model =
    { title : String
    , subTitle : String
    , key : Nav.Key
    , url : Url.Url
    }


jumbotron : { a | title : String, subTitle : String } -> Html msg
jumbotron titles =
    let
        _ =
            Coverage.track "Main" 28
    in
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
