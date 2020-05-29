import wollok.game.*
import juego.*
import characters.*
import movements.*
import elements.*
import animations.*

object nivel1 {
	const board = new BoardGround(image="Stage/mapa2.jpg")
	
	method empezar(){
		self.agregarVisuales()
		self.configurarTeclado()
		self.elementos()
		
		//TODO: Buscarle lugar a las colisiones
		game.onCollideDo(aang,{elemento => aang.guardar(elemento)})	
		game.onTick(3*1000, "regeneracionMana",{ aang.aumentarEnergia()})
	}
	
	method elementos(){
		const awita = new Elemento(elemento="water")
		game.onTick(130, "avanzarAang", {animacion.deElemento(awita)})
		game.addVisualIn(awita, game.at(3,1))
	}
	
	method agregarVisuales(){
		game.addVisual(board)
		game.addVisual(aang)
		game.addVisual(aire)
		game.addVisual(barraVida)
		game.addVisual(barraMana)
		game.addVisual(scoreUnidad)
		game.addVisual(scoreDecena)
		game.addVisual(scoreCentena)
	}
	
	method configurarTeclado(){
		keyboard.c().onPressDo({aang.figth(hitDerecha)})
		keyboard.up().onPressDo({aang.mover(arriba)})
		keyboard.space().onPressDo({aang.saltar()})
		keyboard.down().onPressDo({aang.mover(abajo)})	
		keyboard.right().onPressDo({aang.mover(derecha)})	
		keyboard.left().onPressDo({aang.mover(izquierda)})
	}
}