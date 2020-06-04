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
	return false //self.position().y() > personaje.position().y()
} 
}


class Escalera{
	
	const property position
	const images=["Stage/Escalera.png","Stage/Escalera-Base.png"]
	const indice = 0
	
	method image(){
		return images.get(indice)
	}
	method esAtravesable(personaje){
		return true
	}
}

class BloqueVacio{
	const property position
	
	method image(){return"Stage/Muro.png"}
	
	method esAtravesable(personaje){
		return false
	}
}



