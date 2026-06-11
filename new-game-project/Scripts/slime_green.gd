extends CharacterBody2D

const SPEED = 60.0
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. TAMBAHKAN GRAVITASI (Sama persis dengan logika di script Player kamu)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. LOGIKA DETEKSI DINDING / JURANG (PATROLI)
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false

	# 3. ATUR KECEPATAN HORIZONTAL
	velocity.x = direction * SPEED

	# 4. GERAKKAN MUSUH DENGAN FISIKA GODOT
	# Fungsi ini otomatis menghitung delta, gravitasi, tabrakan, dan lereng lantai
	move_and_slide()
