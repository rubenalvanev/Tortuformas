extends CanvasLayer

@export var izquierda: TouchScreenButton
@export var derecha: TouchScreenButton
@export var saltar: TouchScreenButton
@export var crecer: TouchScreenButton
@export var menguar: TouchScreenButton

func _on_izquierda_pressed():
	$Izquierda.modulate.a = 0.25


func _on_izquierda_released():
	$Izquierda.modulate.a = 0.5


func _on_derecha_pressed():
	$Derecha.modulate.a = 0.25


func _on_derecha_released():
	$Derecha.modulate.a = 0.5


func _on_saltar_pressed():
	$Saltar.modulate.a = 0.25


func _on_saltar_released():
	$Saltar.modulate.a = 0.5
