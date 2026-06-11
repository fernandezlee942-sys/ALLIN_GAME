extends CanvasLayer

const MAIN_MENU_PATH = "res://Scenes/main_menu.tscn"

@onready var resume_button: Button = %"Resume Button"
@onready var save_button: Button = %SaveButton
@onready var load_button: Button = %LoadButton
@onready var main_menu_button: Button = %MainMenuButton

func _ready() -> void:
	print("[DEBUG - PauseMenu] Node ready. Memeriksa koneksi tombol...")
	hide()
	
	if not resume_button or not save_button or not load_button or not main_menu_button:
		print("[DEBUG - ERROR] Salah satu node tombol bernilai NULL!")
		return

	resume_button.pressed.connect(_on_resume_pressed)
	save_button.pressed.connect(_on_save_pressed)
	load_button.pressed.connect(_on_load_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

func _input(event: InputEvent) -> void:
	# Memastikan mendeteksi tombol ESC ("ui_cancel") secara mutlak
	if event.is_action_pressed("ui_cancel"):
		print("[DEBUG - Input] ESC Terdeteksi!")
		if get_tree().paused:
			_on_resume_pressed()
		else:
			pause_game()
		get_tree().root.set_input_as_handled()

func pause_game() -> void:
	show()
	get_tree().paused = true
	print("[DEBUG] Game di-PAUSE.")

func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false
	print("[DEBUG] Game di-RESUME.")

func _on_save_pressed() -> void:
	Global.save_game()

func _on_load_pressed() -> void:
	if Global.load_game():
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
