import wollok.game.*
import movements.*

object aang{
	var property position = game.at(1,1)
	var property image = "aang__movement/toBottom/stopped--1.png"
	
	method mover(direccion){
		self.position(direccion.position())
		direccion.avanzarAnimacion(1)
		self.image(direccion.image())
	}
}

