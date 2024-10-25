module Util exposing (..)


isJust : Maybe a -> Bool
isJust m =
    case m of
        Just _ ->
            True

        _ ->
            False
