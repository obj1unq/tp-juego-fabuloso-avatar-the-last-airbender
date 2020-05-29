import wollok.game.*
import characters.*

object arriba{
	var animacion = 1
	const fotogramas = 9
	const reiniciar = 1
	
	method image(){
		return "aang__movement/toTop/" + animacion + ".png"
	}
	
	method position(){
		return aang.position().up(1)
	}
	
	method direccionOpuesta(){
		return abajo
	}
	
	
	method salto(){
		return saltoDesdeIzquierda
	}
	
	method hit(){
		return hitDerecha
	}
	
	method avanzarAnimaciones(){
		animacion++
		if(animacion>fotogramas){
			animacion=reiniciar
		}
	}
	
}

/*object arriba{
	const property direccionOpuesta = abajo
	var property animacion = 1
	method image(){return "aang__movement/toTop/"+ animacion.toString() + ".png"}
    method position() = aang.position().up(1)
	method avanzarAnimaciones(){
		animacion++
		if(animacion>9){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
	method salto(){return saltoDesdeIzquierda}
	method hit() {return hitDerecha}
}*/


object abajo{
	const property direccionOpuesta = arriba
	var property animacion = 1
	method image(){return "aang__movement/toBottom/"+ animacion.toString() + ".png"}
    method position() = aang.position().down(1)
	method avanzarAnimaciones(){
		animacion++
		if(animacion>9){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
	method salto(){return saltoDesdeIzquierda}
	method hit() {return hitDerecha}
}

object derecha{
	const property direccionOpuesta = izquierda 
	var property animacion = 1
	method image(){return "aang__movement/toRight/"+ animacion + ".png"}
    method position() = aang.position().right(1)
	method avanzarAnimaciones(){
		animacion++
		if(animacion>4){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
	method salto(){return saltoDesdeIzquierda}
	method hit(){return hitDerecha}
}

object izquierda{
	const property direccionOpuesta = derecha
	var property animacion = 1
	method image(){return "aang__movement/toLeft/"+ animacion.toString() + ".png"}
    method position() = aang.position().left(1)
	method avanzarAnimaciones(){
		animacion++
		if(animacion>4){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
	method salto(){return saltoDesdeDerecha}
	method hit() {return hitIzquierda}
}
object hitIzquierda{
	var property animacion = 1
	const property danio = 2
	const property energiaAPerder = 1
	method image(){return "fight/toLeft/" + animacion.toString() + ".png" }
	method avanzarAnimaciones(){
		if(animacion < 6){
		animacion++ 1
		}else {game.removeTickEvent("golpe")
				animacion = 1}
	}
	method imagenSiguiente(){return self.image()}
}
object hitDerecha{
	const property danio = 2
	var property animacion = 1
	const property energiaAPerder = 1
	method image(){return "fight/toRight/" + animacion.toString() + ".png" }
	method avanzarAnimaciones(){
		if(animacion < 6){
			animacion++ 1
		}else {game.removeTickEvent("golpe")
				animacion = 1
		}
		}
	method imagenSiguiente(){return self.image()}
}

object saltoDesdeIzquierda{
	var property animacion = 1
	method image(){return "aang__movement/jump/fromRight/"+ animacion.toString() + ".png"}
	method avanzarAnimaciones(){
		animacion++
		if(animacion>4){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
}

object saltoDesdeDerecha{
	var property animacion = 1
	method image(){return "aang__movement/jump/fromLeft/"+ animacion.toString() + ".png"}
	method avanzarAnimaciones(){
		animacion++
		if(animacion>4){
			animacion=1
		}
	}
	method imagenSiguiente(){return self.image()}
}


///////////////////
// A IMPLEMENTAR //
///////////////////

class Movimiento{
	
	const fotogramas
	
	const direccionDelMovimiento
	
	var animacion = 1
	
	const property position
	
	method image(){
		return "aang__movement/" + direccionDelMovimiento + "/" + "animacion" + ".png"
	}
	
	method avanzarAnimacion(){
		animacion++
		if(animacion>fotogramas){
			animacion=1
		}
	}
}