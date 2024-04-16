extends Node3D

signal on_finish


func _ready():
	var target_pos = position
	position += Vector3.DOWN
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_pos, 0.5).set_trans(Tween.TRANS_QUAD)
	await get_tree().create_timer(3.0).timeout
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "position", target_pos + Vector3.UP * 2, 1).set_trans(Tween.TRANS_QUAD)
	await get_tree().create_timer(1.0).timeout
	on_finish.emit()
	queue_free()

