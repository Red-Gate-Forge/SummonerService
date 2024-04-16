class_name RitualUtils 

static func set_pentagram_color(color: Vector3):
    RenderingServer.global_shader_parameter_set("pentagram_color", color)

enum HandSign { UP, DOWN, LEFT, RIGHT }

enum TonePitch { ASTRI, SAK, DOX }
enum ToneLenght { WHOLE, HALF, QUARTER, CRAP }

enum Summonable {
    NONE,
    CHEESEBURGER,
    DEFAULT_CUBE,
    RUBIX_CUBE,
    GHOST,
    GOLEM,
    GREATER_DEMON,
    LESSER_DEMON,
    HERO,
    HOLY_SWORD,
    MINI_NUKE,
    ENEGRY_DRINK
}

enum Ingrediant {
    NONE,
    BRICK,
    URAN,
    SOUL_ESSENCE,
    VOODOO_DOLL,
    GEAR,
    ANVIL,
    OUIJA_BOARD,
    CRYSTAL_BALL,
    PLASTIC_STRAW,
    INCENSE_STICKS,
    HERBS
}