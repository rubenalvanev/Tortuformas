class_name DelReves
extends Node2D

@export var area_2d: Area2D

func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_method("invertir_controles"):
		body.invertir_controles()
		queue_free()
