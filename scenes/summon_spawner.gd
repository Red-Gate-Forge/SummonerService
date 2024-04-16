extends Node3D

signal on_summon_object_finished

@onready var summon_good_sound: AudioStreamPlayer = $summon_good_audio
@onready var summon_failed_sound: AudioStreamPlayer = $summon_failed_audio

var spanwed: Node3D
var pentagram_color: Vector3

func _on_summon_failed():
	summon_failed_sound.play()
	pentagram_color = Vector3.RIGHT
	pulse_pentagram()

func _on_summon_object_finished():
	on_summon_object_finished.emit()

func _on_summon_succeeded(summonable: Summonable):
	summon_good_sound.play()
	pentagram_color = Vector3.ONE
	pulse_pentagram()
	var spawnable = load(summonable.spawnable_path) as PackedScene
	spanwed = spawnable.instantiate() as Node3D
	add_child(spanwed)
	if spanwed.has_signal("on_finish"):
		spanwed.connect("on_finish", _on_summon_object_finished)

func pulse_pentagram():
	var tween = get_tree().create_tween()
	tween.tween_method(set_pentagram_color, 0.0, 1.0, .1)
	tween.chain().tween_method(set_pentagram_color, 1.0, 0.0, 1.5)

func set_pentagram_color(intensity: float):
	RitualUtils.set_pentagram_color(pentagram_color * intensity * 2)
