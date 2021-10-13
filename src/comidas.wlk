import wollok.game.*

object manzana {
	var property position = game.at(1.randomUpTo(3).roundUp(), 1.randomUpTo(3).roundUp())

	method image() = "manzana.png"
	method energiaQueOtorga() = 40
	method teChoco(alguien) {}
}

