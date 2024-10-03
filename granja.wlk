import posiciones.*
import wollok.game.*
import hector.*


object granja { 

    const property plantasEnLaGranja = #{}

    method validarDentro(position) {
        if (not self.estaDentro(position)) {
            hector.error("No puedo salir fuera del tablero")
        }
    }

    method estaDentro(position) {
        return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
    }

    method agregarPlanta(planta) {
      plantasEnLaGranja.add(planta)
    }

    method validarSiSePuedePlantarEn(posicion) {
      if (self.hayUnaPlantaEn(posicion)){
        hector.error("hay una planta!, no puedo plantar")
      }
    }

    method hayUnaPlantaEn(posicion) {
      return plantasEnLaGranja.any({planta => planta.position() == posicion})
    }

    method regarPlanta(posicion) {
      self.validarQueSePuedeRegar(posicion)
      self.plantaActual(posicion).serRegada()
    }

    method plantaActual(posicion) {
      return plantasEnLaGranja.find({planta => planta.position() == posicion})
    }

    method validarQueSePuedeRegar(posicion) {
      if (not self.hayUnaPlantaEn(posicion)) {
        hector.error(" No hay ninguna planta aca, no puedo regar")
      }
    }

    method sacarPlanta(planta) {
      plantasEnLaGranja.remove(planta)
    }

}