module Route exposing (Blogs(..), Route(..), isRoute, toFragment)

import Coverage
import Url exposing (Url)


type Route
    = Home
    | Blog Blogs
    | External String


type Blogs
    = Lightning


toRoute : String -> Route
toRoute path =
    let
        _ =
            Coverage.track "Route" 3
    in
    case path of
        "/" ->
            let
                _ =
                    Coverage.track "Route" 0
            in
            Home

        "/lightning/" ->
            let
                _ =
                    Coverage.track "Route" 1
            in
            Blog Lightning

        s ->
            let
                _ =
                    Coverage.track "Route" 2
            in
            External s


isRoute : Url -> Bool
isRoute url =
    let
        _ =
            Coverage.track "Route" 6
    in
    case toRoute url.path of
        External _ ->
            let
                _ =
                    Coverage.track "Route" 4
            in
            False

        _ ->
            let
                _ =
                    Coverage.track "Route" 5
            in
            True


toFragment : Route -> String
toFragment route =
    let
        _ =
            Coverage.track "Route" 10
    in
    case route of
        Home ->
            let
                _ =
                    Coverage.track "Route" 7
            in
            "/"

        Blog Lightning ->
            let
                _ =
                    Coverage.track "Route" 8
            in
            "/lightning/"

        External url ->
            let
                _ =
                    Coverage.track "Route" 9
            in
            url
