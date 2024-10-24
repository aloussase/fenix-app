module Types exposing (..)


type alias HorarioCorte =
    { fechaCorte : String
    , horaDesde : String
    , horaHasta : String
    }


type alias InformacionCorteLuz =
    { alimentador : String
    , cuentaContrato : String
    , cuenta : String
    , direccion : String
    , horarios : List HorarioCorte
    }
