object animacion {
	method dePersonaje(personaje, objetoAAnimar){
		objetoAAnimar.avanzarAnimaciones()
		//personaje.image(objetoAAnimar.imagenSiguiente())
	}	
	
	method deElemento(elemento){elemento.avanzarAnimaciones()}
}