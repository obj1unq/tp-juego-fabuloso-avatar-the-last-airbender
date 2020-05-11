import wollok.game.*

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