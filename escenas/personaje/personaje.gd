extends CharacterBody2D

signal personaje_muerto

@export var animacion : AnimatedSprite2D
@export var area_2d: Area2D
@export var material_personaje_rojo: ShaderMaterial

@export var _escala_maxima: float = 2
@export var _escala_minima: float = 0.25
@export var _incremento_escala: float = 0.25
var _velocidad : float = 100.0
var _velocidad_salto : float = -320.0
var _muerto: bool
var _invertido: bool = false

func _ready():
	add_to_group("personajes")
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta):
	if _muerto:
		return
	
	velocity += get_gravity() * delta
	
	if Input.is_action_pressed("speedmode1") and Input.is_action_pressed("speedmode2"):
		_velocidad = 1000.0
	else:
		if _invertido:
			_velocidad = -100
		else:
			_velocidad = 100

		
	
	if ControladorGlobal.nivel > 3:
		if Input.is_action_just_pressed("crecer") and is_on_floor():
			if scale.x < _escala_maxima:
					scale += Vector2(_incremento_escala, _incremento_escala)
		
		if Input.is_action_just_pressed("menguar") and is_on_floor():
			if scale.x > _escala_minima:
					scale -= Vector2(_incremento_escala, _incremento_escala)
	
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = _velocidad_salto
	
	if Input.is_action_pressed("derecha"):
		velocity.x = _velocidad
		if _invertido:
			animacion.flip_h = true
		else:
			animacion.flip_h = false
	elif Input.is_action_pressed("izquierda"):
		velocity.x = -_velocidad
		if _invertido:
			animacion.flip_h = false
		else:
			animacion.flip_h = true
	else:
		velocity.x = 0
	move_and_slide()
	
	if !is_on_floor():
		animacion.play("saltar")
	elif  velocity.x != 0:
		animacion.play("correr")
	else:
		animacion.play("idle")


func _on_area_2d_body_entered(_body: Node2D) -> void:
	animacion.material = material_personaje_rojo
	_muerto = true
	animacion.play("morir")
	animacion.stop()

	await get_tree().create_timer(0.5).timeout
	personaje_muerto.emit()

	ControladorGlobal.sumar_muerte()

func invertir_controles():
	_invertido = not _invertido
