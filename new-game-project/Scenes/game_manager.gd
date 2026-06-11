extends Node

@onready var coin_label: Label = %CoinLabel
var total_coins: int = 0

func _ready() -> void:
	# Mencari semua node koin yang ada di dalam grup bernama "Coins"
	total_coins = get_tree().get_nodes_in_group("Coins").size()
	update_ui()

func _process(_delta: float) -> void:
	update_ui()

func update_ui() -> void:
	# Format teks menjadi: "X out of Y coins"
	coin_label.text = "This is the game final area, collect at least 10 coins before going in.\nYou have collected "+str(Global.score) + " coins."
