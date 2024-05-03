extends CharacterBody3D

enum Mode { SIMPLE, MOVE_AND_COLLIDE, MOVE_AND_SLIDE }
var mode: Mode
var frame_interval = 1
var counter = 0
var pending_frames = 0
const SPEED = 1

func _physics_process(delta):
	pending_frames += 1
	if Engine.get_physics_frames() == 0: return
	if Engine.get_physics_frames() % frame_interval != 0: return
	counter += 1; set_meta("tick_count", counter)
	match mode:
		Mode.SIMPLE: _simple(pending_frames)
		Mode.MOVE_AND_COLLIDE: _move_and_collide(pending_frames)
		Mode.MOVE_AND_SLIDE: _move_and_slide(pending_frames)
	pending_frames = 0

func _simple(count):
	global_position.x += SPEED * count

func _move_and_collide(count):
	velocity.x = SPEED * count
	move_and_collide(velocity)

func _move_and_slide(count):
	velocity.x = (SPEED * count) / get_physics_process_delta_time() # forces floating point math
	move_and_slide()
