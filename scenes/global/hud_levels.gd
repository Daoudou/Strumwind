extends Node

@export var node_a_path: NodePath

@onready var message = $Message
@onready var messageTimer = $MessageTimer
@onready var scoreOfScoreLabel = $ScoreLabel/Score
@onready var LabelPV = $PV/PVNum
@onready var timerNum = $Timer/TimeNum
@onready var timerScore = $TimerScore
@onready var levelOfLevels = $NumberLevels/Level

var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	#$TimerScore.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	message.text = text
	message.show()
	messageTimer.start()

func show_victory(nextLevel):
	show_message("victory")
	
	await get_tree().create_timer(1.0).timeout
	message.text = "Go to the next level"
	message.show()

	get_tree().change_scene_to_file(nextLevel)
	
func show_game_over():
	show_message("Game Over")
	
	# On attend que le messageTime ce termine
	await messageTimer.timeout
	message.text = "Shoot them up"
	message.show()
	
	await messageTimer.timeout
	message.text = "Return to the select level"
	message.show()
	
	# Créer un miniteur unique et attend qu'il ce termine
	await get_tree().create_timer(1.0).timeout

	get_tree().change_scene_to_file("res://scenes/levels_select.tscn")
	
func update_timer(time):
	timerNum.text = str(time)
	
func update_pv(pv):
	LabelPV.text = str(pv)
	
func update_score(scoreUpdate):
	score += scoreUpdate
	
func show_level(level):
	levelOfLevels.text = str(level)

func show_score():
	scoreOfScoreLabel.text = str(score)
	
func _on_level_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes//levels_select.tscn")

func _on_message_timer_timeout() -> void:
	message.hide()

func _on_timer_score_timeout() -> void:
	show_score()
