import wollok.game.*
import cultivos.*
import granja.*
import posiciones.*

object hector {

	var property position = game.center()
	const property image = "player.png"
	const property plantasCosechadas = []
	var property oro = 0
	
	method sembrarMaiz() {
		granja.validarSiSePuedePlantarEn(self.position())
		const cultivo = new Maiz(position = self.position())
		granja.agregarPlanta(cultivo)
		game.addVisual(cultivo)
	}
	
	method sembrarTrigo() {
		granja.validarSiSePuedePlantarEn(self.position())
		const cultivo = new Trigo(position = self.position())
		granja.agregarPlanta(cultivo)
		game.addVisual(cultivo)
	}
	
	method sembrarTomaco() {
		granja.validarSiSePuedePlantarEn(self.position())
		const cultivo = new Tomaco(position = self.position())
		granja.agregarPlanta(cultivo)
		game.addVisual(cultivo)
	}
	
	method mover(direccion) {
		granja.validarDentro(direccion.siguiente(position))
		position = direccion.siguiente(position)
	}

	method regar() {
		granja.regarPlanta(self.position())
	}

	method agregarPlanta(planta) {
	  plantasCosechadas.add(planta)
	}

	method cosechar() {
	  self.validarSiSePuedeCosechar()
	  const planta =  granja.plantaActual(self.position())
	  self.agregarPlanta(planta)
	  planta.serCosechada()
	}

	method validarSiSePuedeCosechar() { 
	  self.validarSiHayUnaPlantaAca()
	  self.validarSiLaPlantaEstaLista()
	}

	method validarSiHayUnaPlantaAca() {
	  if (not granja.hayUnaPlantaEn(self.position()) ){
		self.error("NO HAY UNA PLANTA ACA PARA COSECHAR")
	  }
	}

	method validarSiLaPlantaEstaLista() {
	  if (not granja.plantaActual(self.position()).estaListaParaCosechar()){
		self.error("NO ESTA LISTA PARA COSECHAR")
	  }
	}

	method vender() {
	  oro = oro + self.ventaTotal()
	  plantasCosechadas.clear()
	}

	method infoDeVentasYOro() {
	   game.say(self, "Tengo " + self.cuantasPlantasTieneParaVender() + " planta/s para vender y " + oro + " moneda/s de oro")

	}

	method ventaTotal() {
	  return plantasCosechadas.sum({planta => planta.valor()})
	}

	method cuantasPlantasTieneParaVender() {
	  return plantasCosechadas.size()
	}
}