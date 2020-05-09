import wollok.game.*
import movements.*
import elementosYBarra.*

object aang{
	var property vida = 6
	var property energia = 7
	var property position = game.at(1,1)
	var property image = "aang__movement/toBottom/stopped--1.png"
	
	method mover(direccion){
		self.position(direccion.position())
		direccion.avanzarAnimacion(1)
		self.image(direccion.image())
	}
	method perderEnergia(){
		if (self.energia() > 0) {
		energia -= 1
		barraMana.descontarBarra()}
	}
	method aumentarEnergia(){
		if (self.energia() < 7){
		energia += 1
		barraMana.aumentarBarra()}
	}
	method perderVida(){
		if(self.vida() > 0){
			vida -= 1
			barraVida.descontarBarra()
		}else {game.stop()}
	}
	method aumentarVida(){
		if(self.vida() < 6){
			vida += 1
			barraVida.aumentarBarra()
		}
	}
}

