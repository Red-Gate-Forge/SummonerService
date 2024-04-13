extends Ritual

var count: int = 0

func perform():
	while active:
		print("Ping")
		count += 1
		await get_tree().create_timer(0.8).timeout

## Ritual Type Interface BEGIN ##

func begin(): #override
	super.begin()
	count = 0
	perform()

func end(): #override
	super.end()

func get_type() -> Ritual.Type: #override
	return Type.BLOOD_SACRAFICE
		
func compare_requirement(requirement: SummonStep) -> bool: #override
	var blood_sacrafice_requirement = requirement as BloodSacraficeSummonStep
	if blood_sacrafice_requirement == null:
		print("BloodSacraficeSummonStep is null")
		return false

	if blood_sacrafice_requirement.get_content() != count:
		print("Blood Sacrafice count does not match")
		return false

	return true

## Ritual Type Interface END ##