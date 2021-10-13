import wollok.game.*
import niveles.*

object pepita {

	var property teAtraparon = false
	var property llegoAlNido = false
	var property position = game.origin()
	var property energia = 100

	method image() = if (self.perdio()) "pepita-gris.png" else "pepita.png"

	method volar(kms) {
		energia = energia - (kms * 9)
	}

	method irA(nuevaPosicion) {
		if (!self.terminoElJuego()) {
			self.volar(nuevaPosicion.distance(position))
			position = nuevaPosicion
			self.corregirPosicion()
		}
	}

	method estaCansada() = energia <= 0

	method perdio() = self.estaCansada() || self.teAtraparon()

	method gano() = self.llegoAlNido()

	method terminoElJuego() = self.gano() || self.perdio()

	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method perderAltura() {
		position = position.down(1)
		self.corregirPosicion()
	}

	method corregirPosicion() {
		position = new Position(x = position.x().max(0).min(game.width()), y = position.y().max(0).min(game.height()))
	}

}

object silvestre {

	var property personajePrincipal = pepita

	method image() = "silvestre.png"

	method position() = new Position(x = personajePrincipal.position().x().max(3), y = 0)

}

object nido {

	const tablero = game

	method image() = "nido.png"

	method position() = tablero.center() // new Position(x = tablero.width(), y = tablero.height())

}

