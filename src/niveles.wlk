import wollok.game.*
import pepita.*
import comidas.*

object juegoPepita {

	const alimentos = []
	var enJuego = true

	method configurar() {
		game.addVisual(nido)
		game.addVisual(silvestre)
		self.agregarComida(new Manzana())
		game.addVisual(pepita)
		game.showAttributes(pepita) // Debug
		teclado.configurar()
		self.configurarAcciones()
		self.configurarColiciones()
		self.configurarComidas()
	}

	method agregarAlimento() {
		if (alimentos.size() < 3) {
			const nuevoAlimento = if (0.randomUpTo(1) == 0) new Manzana() else new Alpiste(cuantoOtorga = 10.randomUpTo(50))
			self.agregarComida(nuevoAlimento)
		}
	}

	method configurarComidas() {
		game.onTick(3000, "agregarComida", { self.agregarAlimento()})
	}

	method configurarAcciones() {
		game.onTick(800, "pepitaCae", { pepita.perderAltura()})
	}

	method comer(comida) {
		pepita.comer(comida)
		game.removeVisual(comida)
		alimentos.remove(comida)
	}

	method teAtraparon() {
		pepita.teAtraparon(true)
		self.perder()
	}

	method configurarColiciones() {
		game.onCollideDo(silvestre, { algo => self.teAtraparon()})
		game.onCollideDo(nido, { algo => self.ganar()})
	}

	method agregarComida(comida) {
		game.addVisual(comida)
		alimentos.add(comida)
		game.onCollideDo(comida, { algo => self.comer(comida)})
	}

	method terminarJuego(sonido, mensaje, demora) {
		enJuego = false
		game.sound(sonido).play()
		game.say(pepita, mensaje)
		game.schedule(demora, { game.stop()})
		self.limitarMovimientos()
	}

	method perder() {
		self.terminarJuego("perdiste.wav", "Changos!", 3000)
	}

	method ganar() {
		game.removeVisual(nido)
		self.terminarJuego("ganaste.mp3", "VAMAAAAAAAAAA", 17000)
	}

	method limitarMovimientos() {
		game.removeTickEvent("pepitaCae")
		game.removeTickEvent("agregarComida")
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
		keyboard.any().onPressDo{ juegoPepita.chequearEstadoJuego()}
	}

}

