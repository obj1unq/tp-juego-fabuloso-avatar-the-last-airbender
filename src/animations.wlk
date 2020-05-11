object animacion {
	method dePersonaje(personaje, objetoAAnimar){
		objetoAAnimar.avanzarAnimaciones()
		return personaje.image(objetoAAnimar.imagenSiguiente())
	}	
	
	method deElemento(elemento){
		elemento.avanzarAnimaciones()
		return elemento.image(elemento.imagenSiguiente())
	}
