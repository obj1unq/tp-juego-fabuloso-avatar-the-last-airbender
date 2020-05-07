import wollok.game.*
import movements.*
import elementosYBarra.*

object aang{
	var property energia = 5
	var property position = game.at(1,1)
	var property image = "aang__movement/toBottom/stopped--1.png"
	
	method mover(direccion){
		self.position(direccion.position())
		direccion.avanzarAnimacion(1)
		self.image(direccion.image())
	}
	method perderEnergia(){
		if (energia>0) {
		energia -= 1
		barraMana.descontarBarra()}
	}
	method aumentarEnergia(){
		if (energia<5){
		energia += 1
		barraMana.aumentarBarra()}
	}
}

