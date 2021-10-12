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
	}

	method configurarAcciones() {
		game.onTick(800, "pepitaCae", { pepita.perderAltura()})
	}

	method perder() {
		game.sound("perdiste.wav").play()
		game.schedule(3000, { game.stop()})
		self.limitarMovimientos()
	}

	method ganar() {
		game.sound("ganaste.mp3").play()
		game.removeVisual(nido)
		game.schedule(17000, { game.stop()})
		self.limitarMovimientos()
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
		if (enJuego && pepita.estaCansada()) {
			self.perder()
		}
		if (enJuego && pepita.llegoAlNido()) {
			self.ganar()
		}
	}

}

object teclado {

	method configurar() {
		keyboard.any().onPressDo{ juegoPepita.chequearEstadoJuego()}
		keyboard.left().onPressDo{ pepita.irA(pepita.position().left(1))}
		keyboard.right().onPressDo{ pepita.irA(pepita.position().right(1))}
		keyboard.up().onPressDo{ pepita.irA(pepita.position().up(1))}
		keyboard.down().onPressDo{ pepita.irA(pepita.position().down(1))}
		keyboard.c().onPressDo{ juegoPepita.atraparComida()}
	}

}

