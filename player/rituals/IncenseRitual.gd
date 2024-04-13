extends Ritual

var count: int = 0

func begin():
    super.begin()
    count = 0
    perform()

func end():
    super.end()

func perform():
    while active:
        print("Ping")
        count += 1
        await get_tree().create_timer(2.0).timeout
        