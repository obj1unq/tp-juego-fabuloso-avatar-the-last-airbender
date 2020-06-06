import wollok.game.*

import characters.*
import movements.*
import animations.*

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

object estalactita{
	const fotogramas = 10
	
	var property fotograma = 1
	
    var property position = game.at(4,4)
	
	method image(){
		return "estalactita/" + fotograma + ".png"
	}
	
	method avanzarAnimaciones(){
		fotograma++
		if(fotograma>fotogramas){
			position = self.position().down(1)
			fotograma = 1
		}
	}
	
	method esAtravesable(personaje){
		return true
	}

}

object estalactita2{

    method position(){
    	return estalactita.position().down(1)
    }
	
	method image(){
		return "estalactita/" + self.fotograma() + ".png"
	}
	
	method fotograma(){
		return if (estalactita.fotograma() < 6) 0 else estalactita.fotograma() * 10 
	}
	
	method esAtravesable(personaje){
		return true
	}
}


