## This is the main scene. It owns Player 1 and Player 2, which are both instances of the
## scene "res://characters/player.tscn". Main is responsible for listening to signals from
## it's children, and calling the appropriate methods of it's other children in response to
## those signals.
class_name Main
extends Node2D

## Reference to the Player1 child scene, configured with the Player.Fighter character class.
@onready var player_1 := $Player1

## Reference to the Player2 child scene, configured with the Player.Thief character class.
@onready var player_2 := $Player2


func _ready():
	# Connect the `just_attacked` signal from $Player1 to the _on_player_1_just_attacked() method.
	player_1.just_attacked.connect(_on_player_1_just_attacked)
	
	# Connect the `just_attacked` signal from $Player2 to the _on_player_2_just_attacked() method.
	player_2.just_attacked.connect(_on_player_2_just_attacked)
	
	# Even though the randomized PlayerStats values do not appear in the editor inspector, they
	# are in fact assigned random values at runtime.
	for stat in ["strength", "intelligence", "wisdom", "dexterity", "constitution", "charisma"]:
		prints(player_1.player_name, stat, player_1.stats.get(stat))
		prints(player_2.player_name, stat, player_2.stats.get(stat))


func _on_player_1_just_attacked(attacker_name: String, attack_roll: int):
	# When $Player1 attacks, tell $Player2 to defend the attack.
	player_2.defend(attacker_name, attack_roll)


func _on_player_2_just_attacked(attacker_name: String, attack_roll: int):
	# When $Player2 attacks, tell $Player1 to defend the attack.
	player_1.defend(attacker_name, attack_roll)
