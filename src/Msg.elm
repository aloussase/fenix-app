module Msg exposing (..)

import Http
import Types exposing (ApiResponse, Criterio, HorarioCorte)


type Msg
    = GotApiResponse (Result Http.Error ApiResponse)
    | GotCachedDocumentNumber String
    | GetCachedDocumentNumber
    | Submit
    | ShareHorario HorarioCorte
    | CopyHorario HorarioCorte
    | UpdateDocumento String
    | UpdateCriterio Criterio
    | ToggleLight
