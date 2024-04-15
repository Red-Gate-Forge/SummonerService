extends Node

@onready var ambient_music: AudioStreamPlayer = $AmbientMusic
@onready var menu_music: AudioStreamPlayer = $MenuMusic


# Called when the node enters the scene tree for the first time.
func _ready():
	ambient_music.play()
	pass
