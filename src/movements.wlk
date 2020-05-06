import characters.*

object arriba{
	var property animacion = 0
	const property imagenes = ["aang__movement/toTop/1.png", "aang__movement/toTop/2.png", "aang__movement/toTop/3.png"]
	method image(){return "aang__movement/toTop/"+ animacion.toString() + ".png"}
    method position() = aang.position().up(1)
	method avanzarAnimacion(n){
		animacion++
		if(animacion>9){animacion=1}
	}
}

object abajo{
	var property animacion = 0
	method image(){return "aang__movement/toBottom/"+ animacion.toString() + ".png"}
    method position() = aang.position().down(1)
	method avanzarAnimacion(n){
		animacion++
		if(animacion>9){animacion=1}
	}
}

object derecha{
	var property animacion = 0
	method image(){return "aang__movement/toRight/"+ animacion.toString() + ".png"}
    method position() = aang.position().right(1)
	method avanzarAnimacion(n){
		animacion++
		if(animacion>4){animacion=1}
	}
}

object izquierda{
	var property animacion = 0
	method image(){return "aang__movement/toLeft/"+ animacion.toString() + ".png"}
    method position() = aang.position().left(1)
	method avanzarAnimacion(n){
		animacion++
		if(animacion>4){animacion=1}
	}
}