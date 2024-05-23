## Player is the blueprint for a player character. Each instance has a configurable `player_name`,
## `character_class`, and `attack_action`. Whenever the `character_class` value changes, the
## Player's other attributes (e.g. `health`, `speed`, `jump`) are updated accordingly. 
class_name Player
extends CharacterBody2D

## Static reference to `Fighter` CharacterClass resource, so `Player.Fighter` can be used anywhere.
static var Fighter = preload("res://characters/classes/fighter.tres")

## Static reference to `Thief` CharacterClass resource, so `Player.Thief` can be used anywhere.
static var Thief = preload("res://characters/classes/thief.tres")

## This signal is emitted whenever the player attacks.
signal just_attacked(
	attacker_name: String,
	attack_roll: int,
)

## Example values for a very simple state machine, to keep track of what the player is doing.
enum PlayerState {
	IDLE,
	JUMPING,
	WALKING,
}

## The player's screen name.
@export var player_name: String

## A CharacterClass resource provides the Player with some base attribute values.
@export var character_class: CharacterClass: set = _set_character_class

## An input action used to indicate that this player is attacking.
@export var attack_action: StringName

## Used to cache the current state of the player.
var current_state: PlayerState

## Gravity value from ProjectSettings.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

## The amount of hit damage the Player can take.
var health: int

## The value of velocity.y when the Player jumps.
var jump: float

## The value velocity.x is multiplied by when the Player moves.
var speed: float


## Check each tick for attack input, and update the player's `current_state`.
func _process(delta):
	if Input.is_action_just_pressed(attack_action):
		attack()
	
	update_state()


## Standard physics for a 2D platformer.
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0

	move_and_slide()


## Perform an attack by emitting the `just_attacked` signal with a random dice roll value.
func attack():
	var attack_roll = roll_dice(3, 6)
	
	just_attacked.emit(player_name, attack_roll)


## Attempt to defend an attack by rolling a value >= the attacker's `attack_roll` value.
func defend(attacker_name: String, attack_roll: int):
	var defense_roll = roll_dice(3, 6)
	
	if defense_roll >= attack_roll:
		# TODO: Consider emitting separate signals for `just_defended` and `just_took_damage`.
		# This would enable the parent node to update the UI or award points to the attacker,
		# for example.
		print("%s defended an attack!" % attacker_name)
	else:
		# TODO: Apply attack damage, which should be determined by the Player's equipped weapon,
		# maybe with a modifier based on the Player's attack strength. Of course, first we'd need
		# to add these attributes to the Player.
		print("%s was hit by an attack!" % attacker_name)


## Helper function to simulate rolling `quantity` number of `sides`-sided dice.
## 
## TODO: Something like this really should live in an autoloaded utility class or plugin.
func roll_dice(quantity: int, sides: int) -> int:
	var value: int = 0
	
	for i in range(quantity):
		value += randi_range(1, sides)
	
	return value


## Example of a very simple state machine.
func update_state():
	if is_on_floor():
		if Input.get_axis("ui_left", "ui_right"):
			# Player is trying to move left or right, so they are walking.
			# TODO: Make actions specific to the input device assigned to a player. For multi-
			# player, use something like: https://github.com/matjlars/godot-multiplayer-input
			current_state = PlayerState.WALKING
		else:
			# Player is not trying to move, so they are idle.
			current_state = PlayerState.IDLE
	else:
		# Player is not on the ground, so they are jumping.
		current_state = PlayerState.JUMPING


## Custom setter for `character_class`, to apply base attribute values.
func _set_character_class(value: CharacterClass):
	character_class = value
	# Apply base attribute values from `character_class`.
	health = character_class.max_health
	speed = character_class.base_speed
	jump = character_class.base_jump
