extends Node2D

const Speed = 60 
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * Speed * delta
	




#	moving things 1 pixes per sec no matter wht the fps is
# 1 here is  1 pixel/sec, and delta is sec/frame, so we will move 1 pixel every frame

#Player A (60 FPS)
#Their computer cuts 1 second into 60 tiny slices.
#Each slice (delta) lasts 0.016 seconds.
#Every frame, the character moves: 300 \times 0.016 = 5 pixels.
#At the end of 60 frames (1 second), the total distance is: $60 \times 5 =$ 300 pixels.

#Player B (30 FPS — Heavy Lag)
#Their computer cuts 1 second into only 30 larger slices.
#Each slice (delta) lasts twice as long: 0.033 seconds.
#Every frame, the character moves: 300 \times 0.033 = 10 pixels.
#At the end of 30 frames (1 second), 
#the total distance is: $30 \times 10 =$ 300 pixels.

#intinya delta ada biar gerakan di akhir detik sama
