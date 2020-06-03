import wollok.game.*
import juego.*
import niveles.*

object mainMenu {

	const board = new BoardGround(image = "menu/boardground.jpg")
	const property objetosEnElMenu = []
	
	method contieneMenu() = not objetosEnElMenu.isEmpty()
	
	method elementoDelMenu(indice) = objetosEnElMenu.get(indice).position().left(1)

	method validarSiHayObjetosEnElMenu(){
		if(not self.contieneMenu()){
			self.error("No existen items en el menú ¿Te aseguraste de poner los menúes antes que el cursor?")
		}
	}
	
	method agregarItem(unItem) {
		game.addVisual(unItem)
		objetosEnElMenu.add(unItem)
	}

	method mostrar() {
		game.addVisual(board)
		self.agregarItem(newGame)
		self.agregarItem(howTo)
		self.validarSiHayObjetosEnElMenu()
		game.addVisual(cursor)
		self.configurarTeclado()
	}

	method configurarTeclado() {
		keyboard.down().onPressDo({ cursor.bajar()})
		keyboard.up().onPressDo({ cursor.subir()})
		keyboard.enter().onPressDo({ cursor.seleccionActual().ejecutar()})
	}

}

object newGame {

	method image() = "menu/newGame.png"

	method position() = game.at(6, 7)

	method ejecutar() {
		game.clear()
		nivel1.empezar()
	}

}

object howTo {

	method image() = "menu/howTo.png"

	method position() = game.at(6, 4)

	method ejecutar() {
	}

}

object cursor {
	var index = 0
	var property position = newGame.position().left(1)
	method finalDelMenu() = mainMenu.objetosEnElMenu().size() - 1
	method principioDelMenu() = 0
	method seleccionActual() = game.getObjectsIn(self.position().right(1)).head()
	method image() = "menu/cursor.png"
	

	method bajar() {
		if (self.puedoBajar()) {
			index++
		} 
		
		else {
			index = self.principioDelMenu()
		}
		self.position(mainMenu.elementoDelMenu(index))
	}

	method subir() {
		if (self.puedoSubir()) {
			index--
		} 
		
		else {
			index = self.finalDelMenu()
		}
		
		self.position(mainMenu.elementoDelMenu(index))
	}

	method puedoBajar() {
		return index != self.finalDelMenu() and mainMenu.contieneMenu()
	}
	
	method puedoSubir() {
		return index != self.principioDelMenu() and mainMenu.contieneMenu()
	}
	
}