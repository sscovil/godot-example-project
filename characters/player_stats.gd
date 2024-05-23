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
