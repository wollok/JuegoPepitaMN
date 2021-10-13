import wollok.game.*

class Alimento {

	var property position = game.at(1.randomUpTo(3).roundUp(), 1.randomUpTo(3).roundUp())

	method image()

	method energiaQueOtorga()

}

class Manzana inherits Alimento {

	override method image() = "manzana.png"

	override method energiaQueOtorga() = 40

}

class Alpiste inherits Alimento {

	const cuantoOtorga

	override method image() = "manzana.png"

	override method energiaQueOtorga() = cuantoOtorga

}

