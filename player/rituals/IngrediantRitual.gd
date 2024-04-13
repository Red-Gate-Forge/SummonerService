extends Ritual

var ingrediant: Ingrediant

## Ritual Type Interface BEGIN ##

func begin(): #override
    super.begin()
    performed = true

func end(): #override
    super.end()

func get_type() -> Ritual.Type: #override
    return Type.INGREDIANT

func compare_requirement(requirement: SummonStep) -> bool: #override
    var ingrediant_requirement = requirement as IngrediantSummonStep
    if ingrediant_requirement == null:
        print("IncenseSummonStep is null")
        return false

    

    return true

## Ritual Type Interface END ##