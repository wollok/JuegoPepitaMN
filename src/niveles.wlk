import wollok.game.*
import pepita.*
import comidas.*

object tutorial2 {

	method configurar() {
		game.addVisual(nido)
		game.addVisual(silvestre)
		game.addVisual(manzana)
		game.addVisual(pepita)
		game.showAttributes(pepita) // Debug
		teclado.configurar()
		acciones.configurar()
	}

}

object teclado {
	method configurar() {
		keyboard.left().onPressDo { pepita.irA(pepita.position().left(1))}
		keyboard.right().onPressDo { pepita.irA(pepita.position().right(1))}
		keyboard.up().onPressDo { pepita.irA(pepita.position().up(1))}
		keyboard.down().onPressDo { pepita.irA(pepita.position().down(1))}
		keyboard.c().onPressDo { 
			pepita.atraparComida()
		}
	}
}

object acciones {
	method configurar() {
		game.onTick(800, "pepitaCae", { pepita.perderAltura() })
	}
}