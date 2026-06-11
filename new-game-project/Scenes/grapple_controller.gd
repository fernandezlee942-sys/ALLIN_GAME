extends Node2D

var target: Vector2
var launched: bool = false

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var player: CharacterBody2D = get_parent() # Assuming player is a CharacterBody2D
@onready var rope: Line2D = $Line2D

@export var rest_length: float = 2.0
@export var stiffness: float = 15.0
@export var damping: float = 2.0

func _process(delta: float) -> void:
	ray_cast_2d.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("grapple"):
		launch()
	if Input.is_action_just_released("grapple"):
		retract()
		
	if launched:
		handle_grapple(delta)

func launch() -> void:
	if ray_cast_2d.is_colliding():
		launched = true
		target = ray_cast_2d.get_collision_point()
		rope.show()
	else:
		# Safety check: If we click the sky, cancel any previous grapple state
		retract()

func handle_grapple(delta: float) -> void:
	var target_direction := player.global_position.direction_to(target)
	var target_dist := player.global_position.distance_to(target)
	
	var displacement := target_dist - rest_length
	var force := Vector2.ZERO
	
	if displacement > 0:
		# 1. Calculate magnitude safely with explicit float types
		var spring_force_magnitude := stiffness * displacement
		# 2. Multiply by target_direction (Vector2) so the force pulls TOWARD the hook
		var spring_force := target_direction * spring_force_magnitude
		
		# 3. Calculate damping force 
		var vel_dot := player.velocity.dot(target_direction)
		var damping_force := -damping * vel_dot * target_direction

		force = spring_force + damping_force
		
	player.velocity += force * delta
	updateRope()

func retract() -> void:
	launched = false
	rope.set_point_position(1, Vector2.ZERO) 
	rope.hide()
	
func updateRope() -> void:
	rope.set_point_position(1, to_local(target))
