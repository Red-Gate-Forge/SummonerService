extends Ritual

@onready var place_audio: AudioStreamPlayer = $place_audio

var ingrediant: RitualUtils.Ingrediant

func _on_ingrediant_selection_change(new_selection:RitualUtils.Ingrediant):
    if performed:
        return

    ingrediant = new_selection

## Ritual Type Interface BEGIN ##

func begin(): #override
    super.begin()
    ingrediant = RitualUtils.Ingrediant.NONE

func end(): #override
    super.end()
    if ingrediant != RitualUtils.Ingrediant.NONE:
        place_audio.play()
        print("Selected ingrediant: " + str(ingrediant))
        performed = true

func get_type() -> Ritual.Type: #override
    return Type.INGREDIANT

func compare_requirement(requirement: SummonStep) -> bool: #override
    var ingrediant_requirement = requirement as IngrediantSummonStep
    if ingrediant_requirement == null:
        print("IngrediantSummonStep is null")
        return false

    var required_ingrediant = ingrediant_requirement.get_content() as Ingrediant

    if required_ingrediant.id != ingrediant:
        print("IngrediantSummonStep Requires: " + str(required_ingrediant.id) + " Selected: " + str(ingrediant))
        return false

    return true

## Ritual Type Interface END ##


