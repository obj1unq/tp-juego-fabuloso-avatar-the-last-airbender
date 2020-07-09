import wollok.game.*
import characters.*

class Movimiento {

	var animacion = 1
	var property direccion
	var fotogramas
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
	
	method esDePelea(){
		return direccion == hitIzquierda or direccion == hitDerecha
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

object abajo {
	
	method posicion(personaje){
		return personaje.position().down(1)
	}
	
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

class Hit inherits Movimiento{
	
	const property danio = 2
	
	const property energiaAPerder = 1
	
	override method avanzarAnimaciones(){
		animacion++
		if (animacion > fotogramas) {
			animacion = 1
			personaje.volverAlMovimientoAnterior()
			game.removeTickEvent("golpe")
		}
	}
	
}

object hitIzquierda inherits Hit {
	
	method nombre() = "fight/toLeft"
	
}

object hitDerecha inherits Hit {
	
	method nombre() = "fight/toRight"
	
}

class Salto inherits Movimiento {
 
	override method avanzarAnimaciones(){
		animacion++
		if (animacion > fotogramas) {
			animacion = 1
			personaje.caer()
		}
	}
	
}

object saltoDesdeDerecha {
		
		method nombre() = "jump/fromLeft"
		method salto() = self
}

object saltoDesdeIzquierda {
	
		method nombre() = "jump/fromRight"
		method salto() = self
	
}
