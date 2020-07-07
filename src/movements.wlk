import wollok.game.*
import characters.*

class Movimiento {

	var animacion = 1
	var property direccion
	const fotogramas
	const personaje

	method siguientePosicion(){
		return direccion.posicion(personaje.position())
	}

	method direccionOpuesta() = direccion.direccionOpuesta() //

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
	
	method posicion(posicion) = posicion.right(1)

	method nombre() = "toRight"

	method direccionOpuesta() = izquierda

	method hit() = hitDerecha

	method salto() = saltoDesdeIzquierda

}

object izquierda {

	method posicion(posicion) = posicion.left(1)
	
	method nombre() = "toLeft"

	method direccionOpuesta() = derecha

	method hit() = hitIzquierda

	method salto() = saltoDesdeDerecha

}

object abajo {

	method posicion(posicion) = posicion.down(1)
	
	method nombre() = "toBottom"

	method direccionOpuesta() = arriba

	method hit() = hitIzquierda

	method salto() = saltoDesdeDerecha	
	
	
}

object arriba {

	method posicion(posicion) = posicion.up(1)
	
	method nombre() = "toTop"

	method direccionOpuesta() = abajo

	method hit() = hitIzquierda

	method salto() = saltoDesdeDerecha	
	
}

object arribaEnEscalera {

	var animacion = 1
	const fotogramas = 9
	const reiniciar = 1

	method image() {
		return "aang__movement/toTop/" + animacion + ".png"
	}

	method position() {
		return if (aang.estaSobreEscalera()) {
			aang.position().up(1)
		} else {
			aang.position().up(0)
		}
	}

	method direccionOpuesta() {
		return abajo
	}

	method salto() {
		return saltoDesdeIzquierda
	}

	method hit() {
		return hitDerecha
	}

	method avanzarAnimaciones() {
		animacion++
		if (animacion > fotogramas) {
			animacion = reiniciar
		}
	}

}

object abajoEnEscalera {

	const property direccionOpuesta = arriba
	var property animacion = 1

	method image() {
		return "aang__movement/toBottom/" + animacion.toString() + ".png"
	}

	method position() {
		return if (aang.estaSobreEscalera() or aang.abajoHayEscalera()) {
			aang.position().down(1)
		} else {
			aang.position().down(0)
		}
	}

	method avanzarAnimaciones() {
		animacion++
		if (animacion > 9) {
			animacion = 1
		}
	}

	method imagenSiguiente() {
		return self.image()
	}

	method salto() {
		return saltoDesdeIzquierda
	}

	method hit() {
		return hitDerecha
	}

}

object hitIzquierda {

	var property animacion = 1
	const property danio = 2
	const property energiaAPerder = 1

	method image() {
		return "fight/toLeft/" + animacion.toString() + ".png"
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

/*object arriba {

 * 	var animacion = 1
 * 	const fotogramas = 9
 * 	const reiniciar = 1

 * 	method image() {
 * 		return "aang__movement/toTop/" + animacion + ".png"
 * 	}

 * 	method position() {
 * 		return aang.position().up(1)
 * 	}

 * 	method direccionOpuesta() {
 * 		return abajo
 * 	}

 * 	method salto() {
 * 		return saltoDesdeIzquierda
 * 	}

 * 	method hit() {
 * 		return hitDerecha
 * 	}

 * 	method avanzarAnimaciones() {
 * 		animacion++
 * 		if (animacion > fotogramas) {
 * 			animacion = reiniciar
 * 		}
 * 	}

 * }

 * object izquierda {

 * 	const property direccionOpuesta = derecha
 * 	var property animacion = 1

 * 	method image() {
 * 		return "aang__movement/toLeft/" + animacion.toString() + ".png"
 * 	}

 * 	method position() = aang.position().left(1)

 * 	method avanzarAnimaciones() {
 * 		animacion++
 * 		if (animacion > 4) {
 * 			animacion = 1
 * 		}
 * 	}

 * 	method imagenSiguiente() {
 * 		return self.image()
 * 	}

 * 	method salto() {
 * 		return saltoDesdeDerecha
 * 	}

 * 	method hit() {
 * 		return hitIzquierda
 * 	}

 * }

 * object abajo {

 * 	const property direccionOpuesta = arriba
 * 	var property animacion = 1

 * 	method image() {
 * 		return "aang__movement/toBottom/" + animacion.toString() + ".png"
 * 	}

 * 	method position() = aang.position().down(1)

 * 	method avanzarAnimaciones() {
 * 		animacion++
 * 		if (animacion > 9) {
 * 			animacion = 1
 * 		}
 * 	}

 * 	method imagenSiguiente() {
 * 		return self.image()
 * 	}

 * 	method salto() {
 * 		return saltoDesdeIzquierda
 * 	}

 * 	method hit() {
 * 		return hitDerecha
 * 	}

 * }

 * object derecha {

 * 	const property direccionOpuesta = izquierda
 * 	var property animacion = 1

 * 	method image() {
 * 		return "aang__movement/toRight/" + animacion + ".png"
 * 	}

 * 	method position() = aang.position().right(1)

 * 	method avanzarAnimaciones() {
 * 		animacion++
 * 		if (animacion > 4) {
 * 			animacion = 1
 * 		}
 * 	}

 * 	method imagenSiguiente() {
 * 		return self.image()
 * 	}

 * 	method salto() {
 * 		return saltoDesdeIzquierda
 * 	}

 * 	method hit() {
 * 		return hitDerecha
 * 	}

 * }

 */
