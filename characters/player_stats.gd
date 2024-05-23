class_name PlayerStats
extends Resource

@export var strength: int
@export var intelligence: int
@export var wisdom: int
@export var dexterity: int
@export var constitution: int
@export var charisma: int


func _init():
	set_local_to_scene(true)


func _setup_local_to_scene():
	strength = randi_range(3, 18)
	intelligence = randi_range(3, 18)
	wisdom = randi_range(3, 18)
	dexterity = randi_range(3, 18)
	constitution = randi_range(3, 18)
	charisma = randi_range(3, 18)


func to_dict() -> Dictionary:
	var dict: Dictionary = {}
	
	for stat in ["strength", "intelligence", "wisdom", "dexterity", "constitution", "charisma"]:
		# Abbreviate the attribute name (e.g. "STR", "INT", "WIS")
		var key: String = stat.substr(0, 3).to_upper()
		var value: int = get(stat)
		dict[key] = value
	
	return dict
