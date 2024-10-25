module Api exposing (..)

import Http
import Json exposing (decodeApiResponse)
import Msg exposing (Msg(..))
import Types exposing (Criterio, getCriterioValue)


type alias Documento =
    String


getHorariosCortes : Documento -> Criterio -> Cmd Msg
getHorariosCortes documento criterio =
    let
        c =
            getCriterioValue criterio

        url =
            "https://api.cnelep.gob.ec/servicios-linea/v1/notificaciones/consultar/" ++ documento ++ "/" ++ c
    in
    Http.get
        { url = url
        , expect = Http.expectJson GotApiResponse decodeApiResponse
        }
