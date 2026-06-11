extends Node2D

@onready var tile_map: TileMap = $TileMap

func _ready() -> void:
	# Hubungkan scene game ini ke dalam "Custom Registry" Global saat game dimulai
	Global.current_game_scene = self
	
	# Cek langsung di awal, siapa tahu player nge-load game yang koinnya sudah 27
	check_hardcoded_coins()

func check_hardcoded_coins() -> void:
	print("[DEBUG - HARDCODE] Memeriksa jumlah koin saat ini: ", Global.score)
	if Global.score >= 27:
		hapus_beberapa_tile()

func hapus_beberapa_tile() -> void:
	print("[DEBUG - HARDCODE] Koin PAS 27! Menghancurkan gerbang...")
	
	var layer_id = 0 
	var target_tiles: Array[Vector2i] = [
		Vector2i(236, -27),
		Vector2i(237, -27),
		Vector2i(238, -27),
		Vector2i(239, -27)
	]
	
	for koordinat in target_tiles:
		tile_map.erase_cell(layer_id, koordinat)
		
	print("[DEBUG - HARDCODE] Tembok koordinat (236 sampai 239) BERHASIL DI-ERASE!")
