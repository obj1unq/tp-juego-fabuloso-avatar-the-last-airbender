import wollok.game.*
import animations.*
import elements.*
import movements.*
import Escenarios.*

object aang{
	var property vida = 6
	var property energia = 7
	var property direccionActual = derecha
	var property position = game.at(1,5)
	var property image = direccionActual.image() //"aang__movement/toBottom/stopped--1.png"
	
	method saltar(){
		game.onTick(100, "salto", {animacion.dePersonaje(self, direccionActual.salto())})
		self.position(arriba.position())
		game.onTick(500, "saltar", {self.caer()})
	}
	
	method guardar(elemento){
		scoreUnidad.aumentar()
		game.removeVisual(elemento)
	}
	method estaSobreEscalera(){
		return game.getObjectsIn(self.position()).any({i => i.image() == "Stage/Escalera.png"or i.image()=="Stage/Escalera-Base.png"})
	}
	
	method abajoHayEscalera(){
		return game.getObjectsIn(self.position().down(1)).any({i => i.image() == "Stage/Escalera.png"or i.image()=="Stage/Escalera-Base.png"})
	}
	method caer(){
		if (self.puedeMover(abajo)){
		self.position(abajo.position())
		}
		game.removeTickEvent("saltar")
		game.removeTickEvent("salto")
		self.image(direccionActual.image())
	}
	
	method gravedad(){
		if (self.puedeMover(abajo) and !self.abajoHayEscalera()){
		self.position(abajo.position())
		}
		self.image(direccionActual.image())
	}
	
	method mover(direccion){
		if (self.puedeMover(direccion)){
			direccionActual = direccion
			self.position(direccion.position())
			direccion.avanzarAnimaciones()
			self.image(direccion.image())}
			
	}
	
	method puedeMover(direccion){
		const objeto = game.getObjectsIn(direccion.position())
		return  objeto.isEmpty() or objeto.head().esAtravesable(self)
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
	method perderVida(vidaAPerder){
		if(self.vida() > 0){
			vida -= vidaAPerder
			barraVida.descontarBarra(vidaAPerder)
		}else {game.stop()}
	}
	method aumentarVida(){
		if(self.vida() < 6){
			vida += 1
			barraVida.aumentarBarra()
		}
	}
	
	method esAtravesable(personaje){
		return false
	}
	method figth(tipoDePelea){
		self.perderEnergia(tipoDePelea.energiaAPerder())
		game.onTick(100,"golpe",{animacion.dePersonaje(self, direccionActual.hit())})
		
	}
}	
