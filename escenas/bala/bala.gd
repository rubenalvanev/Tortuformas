class_name Bala
extends RigidBody2D

@export var velocidad: float = 400.0

func _ready() -> void:
	apply_central_impulse(Vector2.LEFT * velocidad)

	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("jugador"):
		print("¡Jugador eliminado!")
		if body.has_method("morir"): 
			body.morir()

	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
