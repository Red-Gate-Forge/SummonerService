class_name Summonable extends Resource

@export var id: RitualUtils.Summonable
@export_file("*.tscn") var spawnable_path: String
@export_file("*.png") var icon_path: String
@export var name: String
@export_multiline var description: String
@export var steps: Array[SummonStep]

func get_instructions_text() -> String:
    var instructions = ""
    for step in steps:
        instructions += (step as SummonStep).get_instruction_text() + "\n"
    return instructions