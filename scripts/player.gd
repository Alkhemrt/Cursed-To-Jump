extends CharacterBody2D

const SPEED: float = 90.0
const JUMP_VELOCITY: float = -300.0
const GRAVITY: float = 1000.0
const JUMP_CUTOFF_MULTIPLIER: float = 0.25

var is_moving: bool = true
var is_flipped: bool = false
var jump_pressed: bool = false
var final_level: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var items_holding: AnimatedSprite2D = $ItemsHolding
@onready var walk: AudioStreamPlayer = $Audio/Walk
@onready var jump: AudioStreamPlayer = $Audio/Jump

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if not final_level:
			animated_sprite_2d.play("airborne")
	elif not final_level:
		animated_sprite_2d.play("run")

	# Handle jump start
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_pressed = true
		if not jump.is_playing():
			jump.play()

	# Handle jump release to shorten the jump
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUTOFF_MULTIPLIER
		jump_pressed = false
		if not jump.is_playing():
			jump.play()

	# Start or stop moving
	if is_moving:
		if not is_flipped:
			if not final_level:
				animated_sprite_2d.flip_h = false
			velocity.x = SPEED
			if not walk.is_playing():
				walk.play()
		else:
			animated_sprite_2d.flip_h = true
			velocity.x = -SPEED
			if not walk.is_playing():
				walk.play()
	else:
		velocity.x = 0

	move_and_slide()
