import wollok.game.*
import animations.*
import elements.*
import movements.*

object aang{
	var property vida = 6
	var property energia = 7
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
	method perderEnergia(energiaAPerder){
		if (self.energia() > 0) {
		energia -= energiaAPerder
		barraMana.descontarBarra(energiaAPerder)}
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
	method figth(tipoDePelea){
		self.perderEnergia(tipoDePelea.energiaAPerder())
		game.onTick(500,"golpe",{tipoDePelea.avanzarAnimacion(1)})
		
	}
}	
