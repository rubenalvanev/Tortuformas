extends CharacterBody2D

@export var animacion : AnimatedSprite2D

var direccion = 1
var velocidad = 40

func _physics_process(delta):
	velocity.x = direccion * velocidad

	if not is_on_floor():
		velocity.y += 980 * delta

	move_and_slide()
	
	if  velocity.x != 0:
		animacion.play("correr_2")
	if velocity.x < 0:
		animacion.flip_h = false
	else:
		animacion.flip_h = true
	if  velocity.x == 0:
		animacion.play("idle_2")

	if is_on_wall():
		cambiar_direccion()

func cambiar_direccion():
	direccion *= -1
	scale.x = abs(scale.x) * direccion
