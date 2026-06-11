extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(_body: Node2D) -> void:
	game_manager.add_point()
	animation_player.play("Pickup")
	











# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	fungsi konstruktor
	#print("Aku Sigma") #cuman ad di terminal

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
