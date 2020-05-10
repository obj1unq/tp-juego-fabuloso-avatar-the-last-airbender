import wollok.game.*
import animations.*
import movements.*

object aang{
	var property direccionActual = derecha
	var property position = game.at(1,1)
	var property image = "aang__movement/toBottom/stopped--1.png"
	
	
	method saltar(){
		game.onTick(100, "salto", {animacion.dePersonaje(self, direccionActual.salto())})
		self.position(arriba.position())
		game.onTick(500, "saltar", {self.caer()})
	}
	
	method caer(){
		self.position(abajo.position())
		game.removeTickEvent("saltar")
		game.removeTickEvent("salto")
		self.image(direccionActual.image())
	}
	
	/*method colisionarPared(){
		self.position(direccionActual.direccionOpuesta().position())
		game.removeTickEvent("saltar")
	}*/
	
	method mover(direccion){
		direccionActual = direccion
		self.position(direccion.position())
		direccion.avanzarAnimaciones()
		self.image(direccion.image())
	}
	
}