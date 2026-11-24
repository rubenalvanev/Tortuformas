extends Node2D

@export var bala_escena: PackedScene
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.5
	timer.timeout.connect(disparo)
	timer.start()

func disparo() -> void:
	if not bala_escena:
		return
		
	var bala = bala_escena.instantiate()
	bala.global_position = Vector2(144, -68)
	get_tree().current_scene.add_child(bala)
