import wollok.game.*
import animations.*
import elements.*
import movements.*
import Escenarios.*

class Personaje {

	var property position
	var nombre
	var property movimiento

	method image() {
		return movimiento.image()
	}

	method nombre() {
		return nombre
	}

	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			movimiento.direccion(direccion)
			movimiento.avanzarAnimaciones()
			self.position(movimiento.siguientePosicion())
		}
	}


	method esAtravesable(personaje) {
		return false
	}

	method puedeMover(direccion)
}

class Enemigo inherits Personaje {

	override method initialize() {
		movimiento = new Movimiento(direccion = derecha, fotogramas = 4, personaje = self)
		position = game.at(7, 5)
		nombre = "enemy"
	}

	override method puedeMover(direccion) {
		const direccionAEvaluar = game.getObjectsIn(direccion.posicion(self).down(1))
		return not direccionAEvaluar.isEmpty()
	}

	override method mover(direccion) {
		if (self.puedeMover(direccion)) {
			movimiento.direccion(direccion)
		} else {
			movimiento.direccion(direccion.direccionOpuesta())
		}
		movimiento.avanzarAnimaciones()
		self.position(movimiento.siguientePosicion())
	}
		method atacar(personaje){
			personaje.perderVida()
		}

}

object aang inherits Personaje {

	const pelea = new Hit(direccion = hitDerecha, fotogramas = 5, personaje = self)
	const salto = new Salto(direccion = saltoDesdeDerecha, fotogramas = 4, personaje = self)
	var movimientoAnterior = null
	var property vida = 6
	var property energia = 7

	override method initialize() {
		nombre = "aang"
		movimiento = new Movimiento(direccion = derecha, fotogramas = 4, personaje = self)
		position = game.at(1, 5)
	}

	method saltar(){
		movimientoAnterior = movimiento
		salto.direccion(movimiento.salto())
		movimiento = salto
	  	game.onTick(100, "salt", {animacion.dePersonaje(self, movimiento)})
	  	self.position(self.position().up(1))
	  	//game.onTick(500, "saltar", {self.caer()})
	 }
//	method saltar(){
//		const direccionPreviaAlSalto = direccionActual 
//		self.direccionActual(direccionActual.salto()) 
//		game.onTick(10, "salto", {direccionActual.avanzarAnimaciones()})
//		self.position(arriba.position())
//		game.onTick(500, "saltar", {self.caer()})
//		direccionActual = direccionPreviaAlSalto
//	}
	method guardar(elemento) {
		scoreUnidad.aumentar()
		game.removeVisual(elemento)
	}

	method estaSobreEscalera() {
		return game.getObjectsIn(self.position()).any({ i => i.image() == "Stage/Escalera.png" or i.image() == "Stage/Escalera-Base.png" })
	}

	method abajoHayEscalera() {
		return game.getObjectsIn(self.position().down(1)).any({ i => i.image() == "Stage/Escalera.png" or i.image() == "Stage/Escalera-Base.png" })
	}

	method caer() {
		self.volverAlMovimientoAnterior()
		self.gravedad()
		//game.removeTickEvent("saltar")
		game.removeTickEvent("salt")
		
	}

	method gravedad() {
		if (self.puedeMover(abajo) and !self.abajoHayEscalera()) {
			self.position(self.position().down(1))
		}
	}

	method perderEnergia(energiaAPerder) {
		if (self.energia() > 0) {
			energia -= energiaAPerder
			barraMana.descontarBarra(energiaAPerder)
		}
	}

	method aumentarEnergia() {
		if (self.energia() < 7) {
			energia += 1
			barraMana.aumentarBarra()
		}
	}

	method volverAlMovimientoAnterior() {
		movimiento = movimientoAnterior
	}

	method perderVida() {
		if (self.vida() > 0) {
			vida -= 1
			barraVida.descontarBarra()
		} else {
			game.stop()
		}
	}

	method aumentarVida() {
		if (self.vida() < 6) {
			vida += 1
			barraVida.aumentarBarra()
		}
	}

	method figth() {
		if (not movimiento.esDePelea()) {
			movimientoAnterior = movimiento
			self.perderEnergia(pelea.energiaAPerder())
			pelea.direccion(movimiento.hit())
			movimiento = pelea
			game.onTick(100, "golpe", { animacion.dePersonaje(self, movimiento)})
		}
	}
	
	override method puedeMover(direccion) {
		const objeto = game.getObjectsIn(direccion.posicion(self))
		return (objeto.isEmpty() or objeto.head().esAtravesable(self)) and not movimiento.esDePelea()
	}


}

