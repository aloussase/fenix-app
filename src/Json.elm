module Json exposing (..)

import Json.Decode exposing (Decoder, field, list, map3, map5, string)
import Types exposing (HorarioCorte, InformacionCorteLuz)


decodeHorarioCorte : Decoder HorarioCorte
decodeHorarioCorte =
    map3 HorarioCorte
        (field "fechaCorte" string)
        (field "horaDesde" string)
        (field "horaHasta" string)


decodeInformacionCorteLuz : Decoder InformacionCorteLuz
decodeInformacionCorteLuz =
    map5 InformacionCorteLuz
        (field "alimentador" string)
        (field "cuentaContrato" string)
        (field "cuen" string)
        (field "direccion" string)
        (list <| field "detallePlanificacion" decodeHorarioCorte)
