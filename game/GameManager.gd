class_name GameManager extends Node

var state: GameState

func _ready():
	state = GameState.new()
	var ritual_manager = RitualManager.get_instance()

	##ritual_manager.on_summon_succeeded.connect("on_summon_complete")
	##ritual_manager.on_summon_failed.connect("on_summon_failed")
	print("GameManager ready")

func on_summon_failed():
	pass

func on_summon_complete(summonable: Summonable):
	pass


func game_over():
	pass

func apply_damage(damage : int):
	state.health -= abs(damage)
	state.health = max(0, state.health)
	if state.health == 0:
		game_over()
