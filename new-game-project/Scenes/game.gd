extends Node2D

@onready var tile_map: TileMap = $TileMap

# ====================================================================
# VARIABEL TARGET KOIN (Bisa kamu ganti jadi 1 untuk testing!)
# Kamu juga bisa mengubah angka ini langsung dari Inspector kanan Godot
@export var coin_threshold: int = 10
# ====================================================================

func _ready() -> void:
	# Hubungkan scene game ini ke dalam "Custom Registry" Global saat game dimulai
	Global.current_game_scene = self
	
	# Kirim nilai batasan koin saat ini ke Global agar sinkron
	Global.max_coins_needed = coin_threshold
	
	# Cek langsung di awal sesi
	check_hardcoded_coins()

func check_hardcoded_coins() -> void:
	print("[DEBUG - HARDCODE] Memeriksa koin. Target: ", Global.score, "/", coin_threshold)
	if Global.score >= coin_threshold:
		hapus_beberapa_tile()

func hapus_beberapa_tile() -> void:
	print("[DEBUG - HARDCODE] Target koin tercapai! Menghancurkan gerbang...")
	
	var layer_id = 1
	var target_tiles: Array[Vector2i] = [
		Vector2i(236, -27),
		Vector2i(237, -27),
		Vector2i(238, -27),
		Vector2i(239, -27)
	]
	
	for koordinat in target_tiles:
		tile_map.erase_cell(layer_id, koordinat)
		
	print("[DEBUG - HARDCODE] Tembok koordinat (236 sampai 239) BERHASIL DI-ERASE!")
