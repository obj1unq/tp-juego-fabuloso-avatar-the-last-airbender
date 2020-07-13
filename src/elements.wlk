import wollok.game.*
import characters.*

// <-- Elemento -->

class Elemento {

	const elemento
	const fotogramas = 12
	var animacion = 1
	const property position

	method image() = "elements/" + elemento + "/" + animacion + ".png"

	method avanzarAnimaciones() {
		animacion++
		if (animacion > fotogramas) {
			animacion = 1
		}
	}

	method esAtravesable(personaje) {
		return true
	}

	method atacar(personaje) {
	}

}

// <-- Barras de vida y maná -->

class Barra {

	const property personaje

	method position() = game.at(1, 8)

	method image() = "vida/" + personaje.nombre() + "/" + personaje.vida() + ".png"

	method guardar(elemento) {
	}

	method atacar(_personaje) {
	}

}

class BarraMovil inherits Barra {

	override method position() = personaje.position()

}

class Mana inherits Barra {

	override method image() = "barraMana/" + personaje.energia() + ".png"

}

// <-- Score -->

class Score {

	var score = 0

	method image() {
		return "score/" + self.nombre() + "/" + score + ".png"
	}

	method aumentar() {
		score++
		if (score > 9) {
			self.siguiente().aumentar()
		}
	}

	method nombre()

	method siguiente()

}

object scoreUnidad inherits Score {

	method position() = game.at(19, 9)

	override method nombre() = "unidad"

	override method siguiente() = scoreDecena

}

object scoreDecena inherits Score {

	method position() = game.at(18,9)

	override method nombre() = "decena"

	override method siguiente() = scoreCentena

}

object scoreCentena inherits Score {

	method position() = game.at(17, 9)

	override method nombre() = "centena"

	override method siguiente() = scoreUnidad

}

