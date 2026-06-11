extends CharacterBody2D

var isRolling: bool = false
const SPEED = 150.0
const rollSpeed = 250

const ACCELERATION = 0.1
const DECELERATION = 0.1


const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# 🌟 DOUBLE JUMP TRACKERS
var jumps_made: int = 0
const MAX_JUMPS: int = 2 # Set to 3 for triple jump, etc.

func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(func(): 
		if animated_sprite_2d.animation == "rolling": 
			isRolling = false
	)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# 🌟 RESET TRACKER: Whenever our feet touch the ground, reset the jump counter
		jumps_made = 0

	# 🌟 MODIFIED JUMP LOGIC
	if Input.is_action_just_pressed("jump"):
		# Case 1: Standard ground jump
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jumps_made += 1
		# Case 2: Mid-air jump (Only works if we haven't reached our max limit)
		elif jumps_made < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jumps_made += 1
			# Optional: Play a spinning or special flip animation for the double jump here!

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
# Handle rolling input
	if Input.is_action_just_pressed("roll") and not isRolling:
		isRolling = true
		animated_sprite_2d.play("rolling")
		# Mengubah -1 menjadi -1.0 dan 1 menjadi 1.0 agar kompatibel dengan tipe float dari 'direction'
		var rollDir = direction if direction != 0 else (-1.0 if animated_sprite_2d.flip_h else 1.0)
		velocity.x = rollDir * rollSpeed
		
	# Normal movement and animation processing
	if not isRolling:
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("idle")
			else:
				animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("jumping")

		if direction:
			velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
		else:
			velocity.x = lerp(velocity.x, 0.0, DECELERATION)

	move_and_slide()
