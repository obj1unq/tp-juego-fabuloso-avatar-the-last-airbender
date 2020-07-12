import wollok.game.*



class Floor {

	const property position

	method image() {
		return "Stage/Piso.png"
	}

	method esAtravesable(personaje) {
		return false
	}
	method atacar(personaje){}

}

class FloatingFloor {

	const property position

	method image() {
		return "Stage/Piso-Air.png"
	}

	method esAtravesable(personaje) {
		return false // self.position().y() > personaje.position().y()
	}

	method atacar(personaje) {
	}

}

class Escalera {

	const property position
	const images = [ "Stage/Escalera.png", "Stage/Escalera-Base.png" ]
	const indice = 0

	method image() {
		return images.get(indice)
	}

	method esAtravesable(personaje) {
		return true
	}

	method atacar(personaje) {
	}

}

class BloqueVacio {

	const property position

	method image() {
		return "Stage/Muro.png"
	}

	method esAtravesable(personaje) {
		return false
	}

	method atacar(personaje) {
	}

}

class MovibleFluido {

	var property fotograma = 1
	var property position = game.at(0, 0)

	method image() {
		return self.nombre() + "/" + self.fotograma() + ".png"
	}

	method fotogramas() {
		return 10
	}

	method nombre() // abstract

	method esAtravesable(personaje) {
		return true
	}

	method avanzarAnimaciones() {
		fotograma++
		if (fotograma > self.fotogramas()) {
			position = self.position().down(1)
			fotograma = 1
		}
	}

}

class Estalactita inherits MovibleFluido {

	var posicionInicial = game.at(0, 0)

	method recordarPosicionInicial() {
		posicionInicial = self.position()
	}

	method regenerar() {
		self.position(posicionInicial)
	}

	override method nombre() {
		return "estalactita"
	}

}

class EstalactitaEsclava inherits Estalactita {

	const estalactitaMaster

	override method position() {
		return estalactitaMaster.position().down(1)
	}

	override method fotograma() {
		return if (estalactitaMaster.fotograma() < 6) 0 else estalactitaMaster.fotograma() * 10
	}

	method atacar(personaje) {
		personaje.perderVida(1)
	}

}

