extends Control

# PATH sudah diperbaiki ke folder Scenes dengan 'S' besar sesuai struktur proyekmu!
const GAME_SCENE_PATH = "res://Scenes/game.tscn"

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var load_button: Button = $VBoxContainer/LoadButton
@onready var exit_button: Button = $VBoxContainer/ExitButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	load_button.pressed.connect(_on_load_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_start_pressed() -> void:
	print("Tombol Start diklik, mencoba memuat: ", GAME_SCENE_PATH)
	
	# Bersihkan data skor lama untuk sesi game baru
	Global.score = 0
	Global.collected_coin_paths.clear()
	
	# Cek apakah file scene-nya ada sebelum pindah
	if ResourceLoader.exists(GAME_SCENE_PATH):
		get_tree().change_scene_to_file(GAME_SCENE_PATH)
	else:
		print("ERROR: File scene game tidak ditemukan! Periksa kembali GAME_SCENE_PATH kamu.")

func _on_load_pressed() -> void:
	print("Tombol Load diklik, memeriksa file save...")
	
	# Memuat data dari file savegame.cfg terlebih dahulu
	if Global.load_game():
		if ResourceLoader.exists(GAME_SCENE_PATH):
			get_tree().change_scene_to_file(GAME_SCENE_PATH)
		else:
			print("ERROR: Data save ada, tetapi file scene utama tidak ditemukan pada path.")
	else:
		print("LOAD GAGAL: Belum ada data save yang tersimpan.")

func _on_exit_pressed() -> void:
	print("Tombol Exit diklik, keluar dari game.")
	get_tree().quit()
