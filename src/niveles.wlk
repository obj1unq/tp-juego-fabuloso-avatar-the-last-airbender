import wollok.game.*
import juego.*
import characters.*
import movements.*
import elements.*
import Escenarios.*
import wollok.game.Position

object nivel1 {
	
	// <-- Instancia -->
	const board = new BoardGround(image = "Stage/Background-Stage1.jpg")
	const enemigardo = new Enemigo(position = game.at(7, 5), vida = 4, nombre = "enemy", movimiento = (new Movimiento(direccion = derecha, fotogramas = 4, personaje = self)))
	const enemigardo2 = new Enemigo(position = game.at(19, 1), vida = 4, nombre = "enemy", movimiento = (new Movimiento(direccion = derecha, fotogramas = 4, personaje = self)))
	const estalactita = new Estalactita(position = game.at(4, 4))
	const estalactita2 = new EstalactitaEsclava(estalactitaMaster = estalactita)
	// <--------------->
	
	var property enemigos = #{}

	method empezar() {
		self.agregarVisuales()
		self.configurarTeclado()
		elementos.agregarElementos()
		
		// <-- Tick Events -->
		game.onTick(1 * 500, "gravedad", { aang.gravedad()})
		game.onTick(3 * 1000, "regeneracionMana", { aang.aumentarEnergia()})
		game.onTick(1 * 500, "gravedad", { aang.gravedad()})
		// <----------------->
	}

	//<-- Enemigos -->
	method agregarEnemigo(enemigo) {
		enemigos.add(enemigo)
		game.addVisual(enemigo)
		game.addVisual(enemigo.barraDeVida())
		game.onTick(300, "enemigo", { enemigo.mover(enemigo.movimiento().direccion())})
	}

	method eliminarEnemigo(enemigo) {
		enemigos.remove(enemigo)
		game.removeVisual(enemigo.barraDeVida())
		game.removeVisual(enemigo)
		game.removeTickEvent("enemigo")
	}
	
	//<-- Visuales -->
	
	method agregarVisuales() {
		//Tablero
		game.addVisual(board)
		self.limitarMapa()
		self.dibujarPisos()
		self.dibujarPlataformas()
		self.dibujarEscalera()
		
		// Estalactita
		estalactita.recordarPosicionInicial()
		game.addVisual(estalactita)
		game.addVisual(estalactita2)
		if (game.hasVisual(estalactita)) {
			game.onTick(5, "avanzarEstalac", { animacion.deElemento(estalactita)})}
		game.onCollideDo(estalactita, { otraCosa => estalactita.regenerar()})
		
		//Aang
		game.addVisual(aang)
		
		//Enemigos
		self.agregarEnemigo(enemigardo)
		self.agregarEnemigo(enemigardo2)
		
		//Colisión
		game.onCollideDo(aang, { personaje => personaje.atacar(aang)})
		
		//Barras
		game.addVisual(new Barra(personaje = aang))
		game.addVisual(new Mana(personaje = aang))
		
		//Score
		game.addVisual(scoreUnidad)
		game.addVisual(scoreDecena)
		game.addVisual(scoreCentena)
	}

	// <-- Teclado -->
	
	method configurarTeclado() {
		keyboard.c().onPressDo({ aang.figth()})
		keyboard.up().onPressDo({ aang.mover(arribaEnEscalera)})
		keyboard.space().onPressDo({ aang.saltar()})
		keyboard.down().onPressDo({ aang.mover(abajoEnEscalera)})
		keyboard.right().onPressDo({ aang.mover(derecha)})
		keyboard.left().onPressDo({ aang.mover(izquierda)})
	}
	
	// <-- Tablero -->
	
	method dibujarPisos() {
		const pisosBase = [ 0, 1, 2, 3, 5, 6, 7, 8, 9, 11, 13, 14, 16, 17, 18, 19 ]
		pisosBase.forEach({ x => game.addVisual(new Floor(position = game.at(x, 0)))})
	}

	method dibujarEscalera() {
		game.addVisual(new Escalera(position = game.at(5, 1), indice = 1))
		game.addVisual(new Escalera(position = game.at(5, 2), indice = 0))
		game.addVisual(new Escalera(position = game.at(14, 3), indice = 1))
		game.addVisual(new Escalera(position = game.at(14, 4), indice = 0))
	}

	method dibujarPlataformas() {
		const plataforma1 = [ 0, 1, 2, 6, 7, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19 ]
		const plataforma2 = [ 0, 1, 2, 3, 4, 7, 8, 9, 10, 11, 13, 15, 16, 17, 18, 19 ]
		self.dibujarPlataformasEn(2, plataforma1)
		self.dibujarPlataformasEn(4, plataforma2)
	}

	method dibujarPlataformasEn(y, plataforma) {
		plataforma.forEach({ x => game.addVisual(new FloatingFloor(position = game.at(x, y)))})
	}

	method dibujarBloqueVacioEn(posicion) {
		game.addVisual(new BloqueVacio(position = posicion))
	}

	method limitarMapa() {
		const ancho = game.width()
		const alto = game.height()
		const posicionesParaGenerarMuros = []
		(0 .. ancho).forEach{ num => posicionesParaGenerarMuros.add(new Position(x = num, y = alto))} // lado superior
		(0 .. ancho).forEach{ num => posicionesParaGenerarMuros.add(new Position(x = num, y = -1))} // lado inferior
		(0 .. alto).forEach{ num => posicionesParaGenerarMuros.add(new Position(x = ancho, y = num))} // lado derecho
		(0 .. alto).forEach{ num => posicionesParaGenerarMuros.add(new Position(x = -1, y = num))} // lado izquierdo
		posicionesParaGenerarMuros.forEach({ posicion => self.dibujarBloqueVacioEn(posicion)})
	}


}

// <-- Elementos -->

object elementos {

	const elementos = [ game.at(1,3), game.at(11,1), game.at(8,5), game.at(19,1), game.at(17,5) ]

	method agregarElemento(elemento) {
		game.addVisual(elemento)
		game.onCollideDo(elemento, { personaje => personaje.guardar(elemento)})
		game.onTick(130, "avanzarAang", { animacion.deElemento(elemento)})
	}

	method agregarElementos() {
		elementos.forEach({ posicion => self.agregarElemento(new Elemento(elemento = "water", position = posicion))})
	}

}