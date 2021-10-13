import wollok.game.*
import pepita.*
import comidas.*

object juegoPepita {

	var enJuego = true

	method configurar() {
		game.addVisual(nido)
		game.addVisual(silvestre)
		game.addVisual(manzana)
		game.addVisual(pepita)
		game.showAttributes(pepita) // Debug
		teclado.configurar()
		self.configurarAcciones()
		self.configurarColiciones()
	}

	method configurarAcciones() {
		game.onTick(800, "pepitaCae", { pepita.perderAltura()})
	}

	method colisionar(objeto,contraQue) {
		contraQue.teChoco(objeto)
		self.chequearEstadoJuego()
	}
	
	method configurarColiciones() {
		game.onCollideDo(pepita,{algo => self.colisionar(pepita,algo)})
	}

	method terminarJuego(sonido,mensaje, demora){
		game.sound(sonido).play()
		game.say(pepita,mensaje)
		game.schedule(demora, { game.stop()})
		self.limitarMovimientos()		
	}
	method perder() {
		self.terminarJuego("perdiste.wav","Changos!",3000)
	}

	method ganar() {
		game.removeVisual(nido)
		self.terminarJuego("ganaste.mp3","VAMAAAAAAAAAA",17000)
	}

	method limitarMovimientos() {
		game.removeTickEvent("pepitaCae")
		enJuego = false
	}

	method atraparComida() {
		const comidas = game.colliders(pepita)
		if (!comidas.isEmpty() && enJuego) {
			const comida = comidas.first()
			pepita.comer(comida)
			game.removeVisual(comida)
		}
	}

	method chequearEstadoJuego() {
		if (enJuego && pepita.perdio()) {
			self.perder()
		}
		if (enJuego && pepita.gano()) {
			self.ganar()
		}
	}

}

object teclado {

	method configurar() {
		keyboard.left().onPressDo{ pepita.irA(pepita.position().left(1))}
		keyboard.right().onPressDo{ pepita.irA(pepita.position().right(1))}
		keyboard.up().onPressDo{ pepita.irA(pepita.position().up(1))}
		keyboard.down().onPressDo{ pepita.irA(pepita.position().down(1))}
		keyboard.c().onPressDo{ juegoPepita.atraparComida()}
	}

}

