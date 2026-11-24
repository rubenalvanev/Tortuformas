extends CharacterBody2D

@onready var target = $"../Personaje"
@export var animacion : AnimatedSprite2D
var velocidad = 40


func _physics_process(_delta):
	var distancia_x = target.position.x - position.x

	if abs(distancia_x) > 5:
		var direccion = sign(distancia_x)
		velocity.x = direccion * velocidad

		animacion.play("correr")
		animacion.flip_h = direccion < 0
	else:
		velocity.x = 0
		animacion.play("idle")

	if not is_on_floor():
		velocity.y += 980 * _delta
	else:
		velocity.y = 0
		
	move_and_slide()
