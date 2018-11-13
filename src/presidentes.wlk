class Presidente {
	var actos = []
	
	var promesas = []
	
	var property estaVivo = true
	
	var property fechaMuerte = null

	method agregarActo(acto) = actos.add(acto)
	
	method agregarPromesa(promesa) = promesas.add(promesa)
	
	method impactoTotal() = self.impactoParcial() + self.impactoPorFallecimiento()
	method impactoParcial() = actos.sum { acto => acto.impacto() }
	method impactoPorFallecimiento() {
		if( fechaMuerte != null) return self.impactoParcial() * 0.1 * ( fechaActual.fecha() - fechaMuerte)
		else return 0
		
	} 
	
	method matarPresidente(fecha) { 
		fechaMuerte = fecha
		estaVivo = false
	}
	method masDeCuatroAcciones() = actos.size() > 4
	
	//Este metodo si se agrega me modifica el polimorfismo
	//method promesasCumplidas() = 
	//	actos.all { acto => acto.estaCumplida() }
	
	method cumplirPromesas() = promesas.forEach { acto => acto.cumplirPromesa() }
}

class Acto {
	const property cantidadDePersonasAfectadas
	const property importancia
	
	method impacto()
}
class Obra inherits Acto {
	const property porcDeAlcance
		
	override method impacto() = 
		 cantidadDePersonasAfectadas * importancia * porcDeAlcance
}

class Discurso inherits Acto {
	const property aplausoIntensidad
		
	override method impacto() = cantidadDePersonasAfectadas * importancia * aplausoIntensidad
}

class Promesa inherits Discurso {
	var property estaCumplida = false
	
	method cumplirPromesa() {
		estaCumplida = true
	}
	
	override method impacto() {
		if (estaCumplida) return super() * 2
		else return super() * -1
	}
}

class DenunciaPorTv  inherits Acto{
	const property denunciante
	
	 override method impacto() =
		-1 * cantidadDePersonasAfectadas * importancia * denunciante.efecto(cantidadDePersonasAfectadas)
		
}

object periodista {
	method efecto(rating) = rating / 2 
}

class Politico {
	var property seguidores 
	method efecto(rating) = rating.min(seguidores)
}

class Pais {
	var presidentes = []
	
	method mejorPresidente() = presidentes.max { presidente => presidente.impactoTotal() }
	
	method agregarPresidente ( presidente ) = presidentes.add(presidente)
	
	method accionesMayorACuatro() = presidentes.any { presidente => presidente.masDeCuatroAcciones()}
}

object fechaActual {
	const fecha = 2018
	
	method fecha() = fecha
}