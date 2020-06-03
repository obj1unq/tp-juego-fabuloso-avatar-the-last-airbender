import wollok.game.*
import juego.*
import characters.*
import movements.*
import elements.*
import animations.*
import Escenarios.*

object nivel1 {
	const board = new BoardGround(image="Stage/Background-Stage1.jpg")
	
	
	
	method empezar(){
		self.agregarVisuales()
		self.configurarTeclado()
		elementos.agregarElementos()
		
		//TODO: Buscarle lugar a las colisiones
		
		game.onTick(3*1000, "regeneracionMana",{ aang.aumentarEnergia()})
	}
	
	
		
		  
		/*const awita = new Elemento(elemento="water")
		game.onTick(130, "avanzarAang", {animacion.deElemento(awita)})
		game.addVisualIn(awita, game.at(3,1))
		game.onCollideDo(awita,{personaje =>personaje.guardar(awita)})*/
	
	
	method agregarVisuales(){
		game.addVisual(board)
		self.dibujarPisos()
		self.dibujarPlataformas()
		self.dibujarEscalera()
		game.addVisual(aang)
		game.addVisual(aire)
		game.addVisual(barraVida)
		game.addVisual(barraMana)
		game.addVisual(scoreUnidad)
		game.addVisual(scoreDecena)
		game.addVisual(scoreCentena)
		
	}
	
	method dibujarPisos(){
		const pisosBase =[0,1,2,3,5,6,7,8,9,11,13,14,16,17,18,19]
		pisosBase.forEach({x =>game.addVisual(new Floor(position= game.at(x,0)))})
		
		
		
		
	}
	method dibujarEscalera(){
		game.addVisual(new Escalera(position= game.at(1,5),indice=1))
		game.addVisual(new Escalera(position= game.at(1,6),indice=0))
	}
	
	method dibujarPlataformas(){
		const plataforma1 =[0,1,2,5,6,7,9,10,11,12,13,14,15,17,18,19]
		const plataforma2 =[0,1,2,3,4,7,8,9,10,11,13,14,15,16,17,18,19]
		
		self.dibujarPlataformasEn(2,plataforma1)
		self.dibujarPlataformasEn(4,plataforma2)
		
		}
		
	method dibujarPlataformasEn(y,plataforma){
		plataforma.forEach({x =>game.addVisual(new FloatingFloor(position= game.at(x,y)))})
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

object elementos {
	
	const elementos = [game.at(1,3),game.at(2,3),game.at(5,8),game.at(7,3)]  
	
	method agregarElemento(elemento){
			game.addVisual(elemento)
			game.onCollideDo(elemento,{personaje => personaje.guardar(elemento)})
			game.onTick(130, "avanzarAang", {animacion.deElemento(elemento)})
			}
	method agregarElementos(){
		
		elementos.forEach({posicion =>self.agregarElemento(new Elemento(elemento= "water", position=posicion ))})
	}
} 