import wollok.game.*
import hector.*
import granja.*


class Maiz {

	var property image = self.bebe()
	var property position = null 
    var esAdulto = false

	method serRegada() {
        image = self.adulto()
        esAdulto = true
    }
    
    method bebe() {
      return "corn_baby.png"
    }

    method adulto() {
      return "corn_adult.png"
    }

    method serCosechada() {
      game.removeVisual(self)
      granja.sacarPlanta(self)
    }

    method estaListaParaCosechar() {
      return esAdulto
    }

    method valor(){
        return 150
    }
}

class Trigo {
    
	var property image = "wheat_0.png"
	var property position = null
	var property etapa = 0
    
    method serRegada() {
        etapa = (etapa + 1) % 4
        self.image("wheat_" + etapa + ".png")
    }

    method estaListaParaCosechar() {
      return etapa >= 1
    }

    method serCosechada() {
      game.removeVisual(self)
      granja.sacarPlanta(self)
    }

    method valor() {
      return (etapa - 1) * 100
    }
}

class Tomaco {

	var property image = "tomaco.png"
    var property position = null

    method serRegada() {
        var posicionNueva = position.up(1)

        if (granja.estaDentro(posicionNueva) and not granja.hayUnaPlantaEn(posicionNueva)) {
            position = posicionNueva
        }
    }

    method estaListaParaCosechar() {
      return true
    }

    method serCosechada() {
      game.removeVisual(self)
      granja.sacarPlanta(self)
    }

    method valor() {
      return 80
    }

    
}