import wollok.game.*
import characters.*

////////////////////////////////////
///////////ELEMENTOS////////////////
////////////////////////////////////

class Elemento{
	const elemento
	const fotogramas = 12
	var animacion = 1
	const property position
	method image() = "elements/" + elemento + "/" + animacion + ".png"
	method avanzarAnimaciones(){
		animacion++
		if(animacion>fotogramas){animacion=1}
	}
	method esAtravesable(personaje){
	return true
} 
}


object aire {
	method image() = "barras_elementos/aire.png"
	method position()  {return game.at(1,10)} 

}


object agua {
	method image() = "barras_elementos/agua.png"
	method position()  {return game.at(2,10)} 
	method aprendioADominarElAgua(){
		game.addVisual(self)
	}

}
object tierra {
	method image() = "barras_elementos/tierra.png"
	method position()  {return game.at(3,10)} 
	method aprendioADominarLaTierra(){
		game.addVisual(self)
	}

}
object fuego {
	method image() = "barras_elementos/fuego.png"
	method position()  {return game.at(4,10)} 
	method aprendioADominarElFuego(){
		game.addVisual(self)
	}
}
//////////////////////////////	
//////BARRAS MANA Y VIDA//////
//////////////////////////////


object barraVida{
	var property barraVida = 6
	method position(){return game.at(1,8)}
	method image()="vida/"+ barraVida.toString()+".png"
	method descontarBarra(){
		if (barraVida == 0){game.stop()}
		else {barraVida -=1}
	}
	method aumentarBarra(){barraVida += 1}
	
}
object barraMana{
	var property barraEnergia = 7
	method position() {return game.at(1,8)}
	method image() = "barraMana/"+ barraEnergia.toString()+".png"
	method aumentarBarra(){barraEnergia += 1}
	method descontarBarra(energiaAPerder){
		  barraEnergia -= energiaAPerder
	}
	
}


///////////////////////////
//////S C O R E////////////
///////////////////////////


object scoreUnidad{
	
	var score = 0
	
	method position(){
		return game.at(19,9)
	}
	method image() {
		return "score/unidad/"+ score + ".png"
	}
	
	method aumentar(){
		score++
		if (score > 9){
			scoreDecena.aumentar()
			score = 0
		}
	}

}

object scoreDecena{
	
	var score = 0
	
	method position(){
		return game.at(18,9)
	}
	method image() {
		return "score/decena/"+ score + ".png"
	}
	
	method aumentar(){
		score++
		if (score > 9){
			scoreCentena.aumentar()
			score = 0
		}
	}

}

object scoreCentena{
	
	var score = 0
	
	method position(){
		return game.at(17,9)
	}
	method image() {
		return "score/centena/"+ score + ".png"
	}
	
	method aumentar(){
		score++
		if (score > 9){
			scoreUnidad.aumentar()
			score = 0
		}
	}

}