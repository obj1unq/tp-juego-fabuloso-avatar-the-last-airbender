import wollok.game.*
import animations.*
import elements.*
import movements.*
import Escenarios.*

class Personaje {
	
	method image()
	
	method nombre()
	
	method mover()
	
	method puedeMover(direccion)
	
}


class Enemigo inherits Personaje{
	
	
	
}

object enemigo{
	
	var property position = game.at(7,5)
	
//	var property direccionActual
	
	method image(){
		
		return "Stage/Escalera.png" //direccionActual.image()
		
	}
	
	method nombre(){
		
		return "enemy"
		
	}
	
	method mover(_direccion){
		
		/*if (self.puedeMover(_direccion)){
			
			direccionActual = _direccion
		}
		
		else {
			
			direccionActual = _direccion.direccionOpuesta()
			
		}*/
			
			self.position(direccionActual.position())
			
			//direccionActual.avanzarAnimaciones()
	}
	
	method puedeMover(_direccion){
		
		const objeto = game.getObjectsIn(_direccion.position())
		
		return not objeto.isEmpty()
		
	}
}

object aang{
	var property position = game.at(1,5)
	const derechaAang = new Movimiento(direccion=derecha, fotogramas= 9, personaje=self, position=self.position().right(1))
	var property vida = 6
	var property energia = 7
	var property direccionActual = derechaAang
	//var property image =
	
	method nombre(){
		return "aang"
	}
	
	method image(){
		return direccionActual.image()
	}  
	
	/*method saltar(){
		game.onTick(100, "salto", {animacion.dePersonaje(self, direccionActual.salto())})
		self.position(arriba.position())
		game.onTick(500, "saltar", {self.caer()})
	}*/
	
	method saltar(){
		const direccionPreviaAlSalto = direccionActual 
		self.direccionActual(direccionActual.salto()) 
		game.onTick(10, "salto", {direccionActual.avanzarAnimaciones()})
		self.position(arriba.position())
		game.onTick(500, "saltar", {self.caer()})
		direccionActual = direccionPreviaAlSalto
	}
	
	method guardar(elemento){
		scoreUnidad.aumentar()
		game.removeVisual(elemento)
	}
	method estaSobreEscalera(){
		return game.getObjectsIn(self.position()).any({i => i.image() == "Stage/Escalera.png"or i.image()=="Stage/Escalera-Base.png"})
	}
	
	method abajoHayEscalera(){
		return game.getObjectsIn(self.position().down(1)).any({i => i.image() == "Stage/Escalera.png"or i.image()=="Stage/Escalera-Base.png"})
	}
	method caer(){
		if (self.puedeMover(abajo)){
		self.position(abajo.position())
		}
		game.removeTickEvent("saltar")
		game.removeTickEvent("salto")
		//self.image(direccionActual.image())
	}
	
	method gravedad(){
		if (self.puedeMover(abajo)){
		self.position(abajo.position())
		}
		//self.image(direccionActual.image())
	}
	
	method mover(direccion){
		//if (self.puedeMover(direccion)){
			direccionActual = direccion
			self.position(direccion.position())
			direccion.avanzarAnimaciones()
		//}
		
	}
	method puedeMover(direccion){
		const objeto = game.getObjectsIn(direccion.position())
		return  objeto.isEmpty() or objeto.head().esAtravesable(self)
	}
	
	
	
	
	method perderEnergia(energiaAPerder){
		if (self.energia() > 0) {
		energia -= energiaAPerder
		barraMana.descontarBarra(energiaAPerder)}
	}
	method aumentarEnergia(){
		if (self.energia() < 7){
		energia += 1
		barraMana.aumentarBarra()}
	}
	method perderVida(){
		if(self.vida() > 0){
			vida -= 1
			barraVida.descontarBarra()
		}else {game.stop()}
	}
	method aumentarVida(){
		if(self.vida() < 6){
			vida += 1
			barraVida.aumentarBarra()
		}
	}
	
	method esAtravesable(personaje){
		return false
	}
	method figth(tipoDePelea){
		self.perderEnergia(tipoDePelea.energiaAPerder())
		game.onTick(100,"golpe",{animacion.dePersonaje(self, direccionActual.hit())})
		
	}
}	
