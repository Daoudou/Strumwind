extends Node

@export var node_a_path: NodePath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	
	# On attend que le messageTime ce termine
	await $MessageTimer.timeout
	$Message.text = "Shoot them up"
	$Message.show()
	
	await $MessageTimer.timeout
	$Message.text = "Return to the select level"
	$Message.show()
	
	# Créer un miniteur unique et attend qu'il ce termine
	await get_tree().create_timer(1.0).timeout

	get_tree().change_scene_to_file("res://scenes/levels_select.tscn")
	
func update_timer(time):
	$Timer/TimeNum.text = str(time)
	
func update_score(score):
	$ScoreLabel/Score.text = str(score)
	
func show_level(level):
	$NumberLevels/Level.text = str(level)
	
func _on_level_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes//levels_select.tscn")

func _on_message_timer_timeout() -> void:
	$Message.hide()
