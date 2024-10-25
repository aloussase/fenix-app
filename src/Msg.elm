module Msg exposing (..)

import Http
import Types exposing (ApiResponse, Criterio)


type Msg
    = GotApiResponse (Result Http.Error ApiResponse)
    | Submit
    | UpdateDocumento String
    | UpdateCriterio Criterio
    | ToggleLight
