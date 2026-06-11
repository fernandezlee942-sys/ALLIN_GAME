extends Node

var score = 0

@onready var coin_label: Label = %CoinLabel

func add_point():	
	score+=1
	print(score)
	coin_label.text ="You've collected "+str(score)+" coins."
