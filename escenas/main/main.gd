extends Node2D

@export var niveles: Array[PackedScene]
@export var controlador_partida: ControladorPartida
@export var camara : Camera2D
@export var controles: CanvasLayer

var _nivel_actual: int = 1
var _nivel_instanciado: Node

func _ready() -> void:
	if ControladorGlobal.nivel > 1:
		_cargar_nivel()
	else:
		_crear_nivel(_nivel_actual)

func _process(delta: float) -> void:
	if ControladorGlobal.nivel > 6 and ControladorGlobal.nivel < 8:
		camara.enabled = false
	else:
		camara.enabled = true
		
	if ControladorGlobal.nivel > 3:
		controles.crecer.visible = true
		controles.menguar.visible = true

func _crear_nivel(numero_nivel: int):
	_nivel_instanciado = niveles[numero_nivel - 1].instantiate()
	add_child(_nivel_instanciado)
	
	var hijos := _nivel_instanciado.get_children()
	
	for i in hijos.size():
		if hijos[i].is_in_group("personajes"):
			hijos[i].personaje_muerto.connect(_reiniciar_nivel)
			break
			
	ControladorGlobal.nivel = numero_nivel
	controlador_partida.guardar_partida()

func _eliminar_nivel():
	_nivel_instanciado.queue_free()
	
func _reiniciar_nivel():
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)

func siguente_nivel():
	_nivel_actual += 1
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)
	
func _cargar_nivel():
	_nivel_actual = ControladorGlobal.nivel
	_crear_nivel.call_deferred(_nivel_actual)
