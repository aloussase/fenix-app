module Util exposing (..)


isJust : Maybe a -> Bool
isJust m =
    case m of
        Just _ ->
            True

        _ ->
            False


listPutIfEmpty : a -> List a -> List a
listPutIfEmpty x xs =
    if List.isEmpty xs then
        [ x ]

    else
        xs
