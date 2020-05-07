import wollok.game.*
import characters.*

object aire {
	method image() = "barras_elementos/aire.png"
	method position()  {return game.at(1,10)} 

}


object agua {
	method image() = "barras_elementos/aguita.png"
	method position()  {return game.at(1,10)} 
	method aprendioADominarElAgua(){
		game.addVisual(self)
	}

}
object tierra {
	method image() = "barras_elementos/tierra.png"
	method position()  {return game.at(1,10)} 
	method aprendioADominarLaTierra(){
		game.addVisual(self)
	}

}
object fuego {
	method image() = "barras_elementos/fueguito.png"
	method position()  {return game.at(1,10)} 
	method aprendioADominarElFuego(){
		game.addVisual(self)
	}
//BARRAS MANA Y VIDA
}
object barraMana{
	var property barraEnergia = 5
	method position() {return game.at(1,8)}
	method image() = "barraMana/"+self.barraEnergia()+".png"
	
	method descontarBarra(){
		if(barraEnergia >0) barraEnergia -= 1
	}
	method aumentarBarra(){
		if (barraEnergia< 5) barraEnergia += 1
	}
}
