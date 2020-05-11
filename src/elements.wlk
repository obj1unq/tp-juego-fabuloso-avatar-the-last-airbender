import wollok.game.*
import characters.*
////////////////////////////////////
///////////ELEMENTOS////////////////
///////////////////////////////////
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

object barraMana{
	var property barraEnergia = 7
	method position() {return game.at(1,12)}
	method image() = "barraMana/"+ barraEnergia.toString()+".png"
	method descontarBarra(energiaAPerder){barraEnergia -= energiaAPerder}
	method aumentarBarra(){barraEnergia += 1}
}
object barraVida{
	var property barraVida = 6
	method position(){return game.at(1,12)}
	method image()="vida/"+ barraVida.toString()+".png"
	method descontarBarra(){barraVida -=1}
	method aumentarBarra(){barraVida += 1}
	
}

object air {
	var  animacion = 1
	var property image = "elements/air/" + animacion + ".png"
	method imagenSiguiente() = "elements/air/" + animacion + ".png"
	method avanzarAnimaciones(){
		animacion++
		if(animacion > 12){animacion = 1}
	}
}

object water {
	var  animacion = 1
	var property image = "elements/water/" + animacion + ".png"
	method imagenSiguiente() = "elements/water/" + animacion + ".png"
	method avanzarAnimaciones(){
		animacion++
		if(animacion > 12){animacion = 1}
	}
} 
/////////////////////////////
//////S C O R E//////////////
////////////////////////////
/*object score unidad{
	var property score = 0
	method position(){return game.at()}
}*/
}
