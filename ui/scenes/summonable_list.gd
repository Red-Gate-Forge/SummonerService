extends RichTextLabel


@export_file("*.tres") var summon_collection: String

# Called when the node enters the scene tree for the first time.
func _ready():
	text += "[b]Summon Objects[/b]\n\n\n"

	var collection = load(summon_collection) as SummonableCollection
	for summonable in collection.collection:
		text += "[img=96x96]" + summonable.icon_path + "[/img]"
		text += "[b]" + summonable.name + "[/b]\n"
		text += "[i]" + summonable.description + "[/i]\n\n"
		text += summonable.get_instructions_text()
		text += "\n\n\n"
