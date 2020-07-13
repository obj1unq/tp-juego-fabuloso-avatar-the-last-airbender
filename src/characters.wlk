import wollok.game.*
import elements.*
import movements.*
import juego.*
import niveles.*

class Personaje {

	var property position
	var nombre
	var property movimiento
	var property vida

	method image() {
		return movimiento.image()
	}
	
	method guardar(elemento){}
	
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

	method perderVida(vidaAPerder) {
		if (self.vida() > 0) {
			vida -= vidaAPerder
			barraVida.descontarBarra(vidaAPerder)
		} else {
			self.morir()
		}
	}

	method esAtravesable(personaje) {
		return false
	}

	method puedeMover(direccion)

	method morir()

}

class Enemigo inherits Personaje {

	const danio = 1
	
	 
	override method initialize() {
		movimiento = new Movimiento(direccion = derecha, fotogramas = 4, personaje = self)
		nombre = "enemy"
		vida = 4
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

	method atacar(personaje) {
		personaje.perderVida(danio)
	}

	override method morir() {
		game.removeVisual(self)
	}

	method alLadoDeAang() {
		return self.aangALaDerecha() or self.aangALaIzquierda()
	}

	method aangALaDerecha() {
		return self.position().right(1) == aang.position()
	}

	method aangALaIzquierda() {
		return self.position().left(1) == aang.position()
	}

	override method perderVida(vidaAPerder) {
		if (self.vida() > 0) {
			vida -= vidaAPerder
		} else {
			self.morir()
		}
	}

}

object aang inherits Personaje {

	const ultimosMovimientos = []
	const pelea = new Hit(direccion = hitDerecha, fotogramas = 5, personaje = self)
	const salto = new Salto(direccion = saltoDesdeDerecha, fotogramas = 4, personaje = self)
	var movimientoAnterior = null
	var property energia = 7

	override method initialize() {
		nombre = "aang"
		movimiento = new Movimiento(direccion = derecha, fotogramas = 4, personaje = self)
		position = game.at(1, 1)
		vida = 6
	}

	method saltar() {
		ultimosMovimientos.add(movimiento)
		salto.direccion(ultimosMovimientos.head().salto())
		movimiento = salto
		game.onTick(100, "salt", { animacion.deElemento(movimiento)})
		self.position(self.position().up(1))
		game.onTick(500, "saltar", { self.caer()})
	}

	override method guardar(elemento) {
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
		game.removeTickEvent("salt")
		movimiento = ultimosMovimientos.head()
		self.gravedad()
		game.removeTickEvent("saltar")
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
			game.onTick(100, "golpe", { animacion.deElemento(movimiento)})
			self.atacar()
		}
	}

	override method puedeMover(direccion) {
		const objeto = game.getObjectsIn(direccion.posicion(self))
		return (objeto.isEmpty() or objeto.head().esAtravesable(self)) and not movimiento.esDePelea()
	}

	override method morir() {
		const boardMuerte = new BoardGround(image = "boardgrounds/aangMorido.jpg")
		game.clear()
		game.addVisual(boardMuerte)
	}

	method hayEnemigoAlLado() {
		return nivel1.enemigos().any({ enemy => enemy.alLadoDeAang() })
	}

	method enemigoAlLado() {
		return nivel1.enemigos().find({ enemy => enemy.alLadoDeAang() })
	}

	method atacar() {
		if (self.hayEnemigoAlLado()) {
			self.enemigoAlLado().perderVida(2)
		} else {
		}
	}

}

