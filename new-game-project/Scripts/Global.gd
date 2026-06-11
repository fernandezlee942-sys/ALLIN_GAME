extends Node

var score: int = 0
var collected_coin_paths: Array[String] = []

# Variabel hardcode untuk menampung alamat scene game yang sedang aktif
var current_game_scene: Node2D = null

const SAVE_PATH = "res://savegame.cfg" 

func add_coin(coin_id: String) -> void:
	if not collected_coin_paths.has(coin_id):
		collected_coin_paths.append(coin_id)
		score += 1
		print("[GLOBAL] Koin bertambah! Total sekarang: ", score)
		
		# --- FITUR HARDCODE KANDIDAT UTAMA ---
		# Setiap kali koin bertambah, langsung cek apakah scene game ada dan koin mencapai 27
		if score >= 27 and current_game_scene != null:
			if current_game_scene.has_method("hapus_beberapa_tile"):
				current_game_scene.hapus_beberapa_tile()
		
		# Otomatis save game setiap ambil koin
		save_game() 

# --- FUNGSI SAVE GAME ---
func save_game() -> void:
	var config = ConfigFile.new()
	config.set_value("Player", "score", score)
	config.set_value("Player", "collected_coins", collected_coin_paths)
	var error = config.save(SAVE_PATH)
	if error == OK:
		print("Game Berhasil Di-Save!")

# --- FUNGSI LOAD GAME ---
func load_game() -> bool:
	var config = ConfigFile.new()
	var error = config.load(SAVE_PATH)
	
	if error == OK:
		score = config.get_value("Player", "score", 0)
		var loaded_coins = config.get_value("Player", "collected_coins", [])
		collected_coin_paths.clear()
		for coin in loaded_coins:
			collected_coin_paths.append(String(coin))
			
		print("Game Berhasil Di-Load! Skor dimuat: ", score)
		
		# Jika pas di-load ternyata koinnya sudah 27 atau lebih, langsung hancurkan tilenya
		if score >= 27 and current_game_scene != null:
			if current_game_scene.has_method("hapus_beberapa_tile"):
				current_game_scene.hapus_beberapa_tile()
				
		return true
		
	return false
