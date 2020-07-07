import wollok.game.*
import characters.*

class Movimiento {

	var animacion = 1
	var property direccion
	const fotogramas
	const personaje

	method siguientePosicion(){
		return direccion.posicion(personaje)
	}

	method hit() = direccion.hit()

	method salto() = direccion.salto()

	method image() {
		return personaje.nombre() + "__movement/" + direccion.nombre() + "/" + animacion + ".png"
	}

	method avanzarAnimaciones() {
		animacion++
		if (animacion > fotogramas) {
			animacion = 1
		}
	}

}

object derecha {
	
	method posicion(personaje) = personaje.position().right(1)

	method nombre() = "toRight"

	method direccionOpuesta() = izquierda

	method hit() = hitDerecha

	method salto() = saltoDesdeIzquierda

}

object izquierda {

	method posicion(personaje) = personaje.position().left(1)
	
	method nombre() = "toLeft"

	method direccionOpuesta() = derecha

	method hit() = hitIzquierda

	method salto() = saltoDesdeDerecha

}

object arribaEnEscalera {
	
	method posicion(personaje){
		return if (personaje.estaSobreEscalera()) {
			personaje.position().up(1)
		} else {
			personaje.position().up(0)
		}
	}
	
	method nombre() = "toTop"
	
	method direccionOpuesta() = abajoEnEscalera

	method hit() = hitIzquierda

	method salto() = saltoDesdeDerecha	
	
}

object abajoEnEscalera {
	
	method posicion(personaje){
		return if (personaje.estaSobreEscalera() or personaje.abajoHayEscalera()) {
			personaje.position().down(1)
		} else {
			personaje.position().down(0)
		}
	}
	
	method nombre() = "toBottom"

	method direccionOpuesta() = arribaEnEscalera

	method hit() = hitIzquierda

	method salto() = saltoDesdeDerecha	
	
}

object hitIzquierda {

	var property animacion = 1
	const property danio = 2
	const property energiaAPerder = 1

	method image() {
		return "fight/toLeft/" + animacion.toString() + ".png" //aang__movement/fight/toLeft/
	}

	method avanzarAnimaciones() {
		if (animacion < 6) {
			animacion++
			1
		} else {
			game.removeTickEvent("golpe")
			animacion = 1
		}
	}

	method imagenSiguiente() {
		return self.image()
	}

}

object hitDerecha {

	const property danio = 2
	var property animacion = 1
	const property energiaAPerder = 1

	method image() {
		return "fight/toRight/" + animacion.toString() + ".png"
	}

	method avanzarAnimaciones() {
		if (animacion < 6) {
			animacion++
			1
		} else {
			game.removeTickEvent("golpe")
			animacion = 1
		}
	}

	method imagenSiguiente() {
		return self.image()
	}

}

object saltoDesdeDerecha {

	var property animacion = 1

	method image() {
		return "aang__movement/jump/fromLeft/" + animacion.toString() + ".png"
	}

	method avanzarAnimaciones() {
		animacion++
		if (animacion > 4) {
			animacion = 1
		}
	}

	method imagenSiguiente() {
		return self.image()
	}

}

object saltoDesdeIzquierda {

	var property animacion = 1

	method image() {
		return "aang__movement/jump/fromRight/" + animacion.toString() + ".png"
	}

	method avanzarAnimaciones() {
		animacion++
		if (animacion > 4) {
			animacion = 1
		}
	}

	method imagenSiguiente() {
		return self.image()
	}

}
