extends Node3D

enum Mode { SIMPLE, MOVE_AND_COLLIDE, MOVE_AND_SLIDE }
@export var mode: Mode
@export var frame_interval = 2

func _ready():
	var characters = get_tree().get_nodes_in_group("character")
	for character in characters: character.mode = mode
	characters[1].frame_interval = frame_interval
	print("START mode: ", Mode.keys()[mode], " frame interval: ", frame_interval)

func _physics_process(_delta):
	call_deferred("exec")

func exec():
	if Engine.get_physics_frames() == 0: return
	if Engine.get_physics_frames() % frame_interval != 0: return
	var characters = get_tree().get_nodes_in_group("character")
	for character in characters:
		print(
			"[", Engine.get_physics_frames(), "]",
			"[", character.name, "] ",
			" pos_x: ", character.global_position.x,
			" error: ", characters[0].global_position.x - characters[1].global_position.x,
			" ticks: ", character.get_meta("tick_count", 0))
