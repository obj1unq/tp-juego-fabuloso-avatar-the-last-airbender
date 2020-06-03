import wollok.game.*

import characters.*
import movements.*

class Floor {

const property position

method image(){

	return "Stage/Piso.png"
	
}

method esAtravesable(personaje){
	return false
} 

}

class FloatingFloor {

const property position

method image(){

	return "Stage/Piso-Air.png"

	
}
method esAtravesable(personaje){
	return self.position().y() > personaje.position().y()
} 
}






