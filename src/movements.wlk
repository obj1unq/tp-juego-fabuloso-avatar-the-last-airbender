import characters.*

object saltoDesdeIzquierda{
	var property animacion = 1
	method image(){return "aang__movement/jump/fromRight/"+ animacion + ".png"}
	method avanzarAnimaciones(){
		animacion++
		if(animacion>4){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
}

object saltoDesdeDerecha{
	var property animacion = 1
	method image(){return "aang__movement/jump/fromLeft/"+ animacion + ".png"}
	method avanzarAnimaciones(){
		animacion++
		if(animacion>4){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
}

object arriba{
	const property direccionOpuesta = abajo
	var property animacion = 1
	method image(){return "aang__movement/toTop/"+ animacion + ".png"}
    method position() = aang.position().up(1)
	method avanzarAnimaciones(){
		animacion++
		if(animacion>9){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
	method salto(){return saltoDesdeIzquierda}
}

object abajo{
	const property direccionOpuesta = arriba
	var property animacion = 1
	method image(){return "aang__movement/toBottom/"+ animacion + ".png"}
    method position() = aang.position().down(1)
	method avanzarAnimaciones(){
		animacion++
		if(animacion>9){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
	method salto(){return saltoDesdeIzquierda}
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
}

object izquierda{
	const property direccionOpuesta = derecha
	var property animacion = 1
	method image(){return "aang__movement/toLeft/"+ animacion + ".png"}
    method position() = aang.position().left(1)
	method avanzarAnimaciones(){
		animacion++
		if(animacion>4){animacion=1}
	}
	method imagenSiguiente(){return self.image()}
	method salto(){return saltoDesdeDerecha}

}

