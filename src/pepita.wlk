import wollok.game.*

object pepita {
	var property enemigo = silvestre
	var property objetivo = nido
	var property position = game.origin()
	var property energia = 100

	method image() = if (self.estaCansada() || self.teAtraparon()) "pepita-gris.png" else "pepita.png"
	method volar(kms) {
		energia = energia - (kms * 9)
	}
	method irA(nuevaPosicion) {
		if (!self.terminoElJuego()) {
			self.volar(nuevaPosicion.distance(position))
			position = nuevaPosicion
			self.chequearEstadoJuego()
		}
	}
	method chequearEstadoJuego() {
		if (self.estaCansada()) {
			game.sound("perdiste.wav").play()
			game.schedule(3000, { game.stop() })
		}
		if (self.llegoAlNido()) {
			game.sound("ganaste.mp3").play()
			game.removeVisual(objetivo)
			game.schedule(17000, { game.stop() })
		}
	}
	method estaCansada() = energia <= 0
	method teAtraparon() = enemigo.position() == self.position()
	method llegoAlNido() = objetivo.position() == self.position()
	method terminoElJuego() = self.estaCansada() || self.teAtraparon() || self.llegoAlNido()
	method atraparComida() {
		const comida = game.uniqueCollider(self)
		if (comida !== null) {
			self.comer(comida)
		}
		game.removeVisual(comida)
	}
	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}
}

object silvestre {
	var property personajePrincipal = pepita

	method image() = "silvestre.png"
	method position() = game.at(personajePrincipal.position().x().max(3), 0)
}

object nido {
	method image() = "nido.png"
	method position() = game.center() // game.at(game.width(), game.height())
}
