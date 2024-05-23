## CharacterClass is a resource template used to create classes with different base attributes.
## TODO: Add more base attribute values, modifiers, special abilities, etc.
class_name CharacterClass
extends Resource

@export var name: String
@export var max_health: int = 100
@export var base_speed: float = 300.0
@export var base_jump: float = -400.0
@export_flags(
	"Equip Heavy Armor",
	"Equip Heavy Weapon",
	"Cast Black Magic",
	"Cast White Magic",
	"Pick Locks",
	"Disarm Traps",
	"Pickpocket",
) var abilities: int
