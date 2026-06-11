extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var my_id: String = String(get_path()) # Mengambil alamat map unik milik koin ini

func _ready() -> void:
	# Jika alamat koin ini sudah terdaftar di memory Global, langsung hapus koinnya
	if Global.collected_coin_paths.has(my_id):
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Pastikan nama node Karakter Utama kamu di panel Scene adalah "Player"
	if body.name == "Player": 
		Global.add_coin(my_id) # Kirim data koin ke memory abadi Global
		animation_player.play("Pickup") # Putar animasi ambil koin
