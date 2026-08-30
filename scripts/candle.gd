extends Node3D

var base_energy := 1
var time := 0.0

func _process(delta):
	time += delta

	var flicker = sin(time * 8.0) * 0.12
	flicker += sin(time * 13.0) * 0.08

	$Point.light_energy = base_energy + flicker
	print($Point.light_energy)
