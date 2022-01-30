module Route exposing (Blogs(..), Route(..), isRoute, toFragment)

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
