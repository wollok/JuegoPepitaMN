import wollok.game.*
import pepita.*

object tutorial2 {

	method configurar() {
		game.addVisual(nido)
		game.addVisual(silvestre)
		game.addVisual(pepita)
		game.showAttributes(pepita) // Debug
		teclado.configurar()
		colisiones.configurar()
	}

}

object teclado {
	method configurar() {
		keyboard.left().onPressDo { pepita.irA(pepita.position().left(1))}
		keyboard.right().onPressDo { pepita.irA(pepita.position().right(1))}
		keyboard.up().onPressDo { pepita.irA(pepita.position().up(1))}
		keyboard.down().onPressDo { pepita.irA(pepita.position().down(1))}
	}
}

object colisiones {
	method configurar() {
		game.onCollideDo(nido, { otroObjeto =>
			game.sound("ganaste.mp3").play()
			game.schedule(17000, { game.stop() })
		})
	}
}