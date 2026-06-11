extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# Memastikan hanya berjalan jika yang menyentuh Area2D ini adalah Player
	if body.name == "Player":
		print("You Died!")
		Engine.time_scale = 0.5 # Efek slow motion saat mati
		
		# Pengamanan: Cek dulu apakah node CollisionShape2D ada sebelum dihapus
		if body.has_node("CollisionShape2D"):
			body.get_node("CollisionShape2D").queue_free()
		
		# BARIS DI BAWAH INI DIHAPUS agar file save tidak rusak oleh loop kematian:
		# Global.save_game() 
		
		timer.start()	

func _on_timer_timeout() -> void:
	# Mengembalikan kecepatan game ke normal sebelum me-reload map
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
