import wollok.game.*
import animations.*
import characters.*
////////////////////////////////////
///////////ELEMENTOS////////////////
///////////////////////////////////
object air {
	var  animacion = 1
	var property image = "elements/air/" + animacion.toString() + ".png"
	method imagenSiguiente() = "elements/air/" + animacion + ".png"
	method avanzarAnimaciones(){
		animacion++
		if(animacion > 12){animacion = 1}
	}
}

object water {
	var  animacion = 1
	var property image = "elements/water/" + animacion.toString() + ".png"
	method imagenSiguiente() = "elements/water/" + animacion.toString() + ".png"
	method avanzarAnimaciones(){
		animacion++
		if(animacion > 12){animacion = 1}
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


/////////////////////////////
//////S C O R E//////////////
////////////////////////////
object scoreUnidad{
	var property score = 0
	method position(){return game.at(10,10)}
	method image() {return "score/unidad/"+ score.toString() + ".png"}
	method imagenSiguiente(){return self.image()}
	
	method aumentar(){
		if (self.score() == 9){
			scoreDecena.aumentar()
			score = 0
		}else {score += 1}
	}
}

object scoreDecena{
	var property score = 0
	method position(){return game.at(9,10)}
	method image() {return "score/decena/"+ score.toString()+".png"}
	method aumentar(){
		if (self.score() == 9){
			scoreCentena.aumentar()
			score = 0
		}else {score += 1}
	}
}
object scoreCentena{
	var property score = 0
	method position(){return game.at(8,10)}
	method image() {return "score/centena/"+ score.toString()+".png"}
	method aumentar(){
		if (self.score() == 9){
			scoreUnidad.aumentar()
		}else {score += 1}
	}
	
}