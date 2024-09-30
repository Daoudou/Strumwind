extends Node2D

@onready var giveUpButton = $HudLevels/GiveUpButton
@onready var pauseButton = $HudLevels/PauseButton
@onready var player = $Player
@onready var hudLevels = $HudLevels
@onready var timerRemain = $TimerRemain
@onready var startPosition = $StartPosition

@onready var speeder = $Speeder
@onready var speeder2 = $Speeder2
@onready var speeder3 = $Speeder3

@onready var gardian = $Gardian

@export var fire_rate = 0.2 # Ceci cera l'intervalle entre les shield (définie en secondes)
var time_since_last_shot: float = 0.0

var timer
var level
var score
var is_paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_level()
	giveUpButton.connect("pressed",Callable(self,"game_over"))
	pauseButton.connect("pressed",Callable(self,"_on_GamePaused"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if	(player.getPv() <= 0):
		game_over()
		
	if (speeder != null):
		speeder.targetPosition = player.position
		if (speeder.shieldPV != 0):
			if (gardian != null):
				gardian.give_shield(speeder, 100)
			else:
				speeder.shieldPV = 0
	if (speeder2 != null):
		speeder2.targetPosition = player.position
		if (speeder2.shieldPV != 0):
			if (gardian != null):
				gardian.give_shield(speeder2, 100)
			else:
				speeder2.shieldPV = 0
	if (speeder3 != null):
		speeder3.targetPosition = player.position
		if (speeder3.shieldPV != 0):
			if (gardian != null):
				gardian.give_shield(speeder3, 100)
			else:
				speeder3.shieldPV = 0
				
	if ((speeder and speeder2 and speeder3 and gardian) == null):
		victory()

func start_level():
	timer = 80
	level = 3
	score = 0
	is_paused = false
	hudLevels.show_message("Get Ready")
	player.start(startPosition.position)
	timerRemain.start()
	hudLevels.show_level(level)

func _on_timer_remain_timeout() -> void:
	timer -= 1
	if (timer >= 0):
		hudLevels.update_timer(timer)
	else:
		game_over()
		
func game_over():
	timerRemain.stop()
	hudLevels.show_game_over()
	
func _on_GamePaused():
	if	(is_paused == false):
		hudLevels.set_process(false)
		timerRemain.stop()
		hudLevels.show_message("Paused")
		is_paused = true
	elif (is_paused == true):
		hudLevels.set_process(true)
		timerRemain.start()
		hudLevels.show_message("")
		is_paused = false
		
	
func victory():
	timerRemain.stop()
	giveUpButton.hide()
	pauseButton.hide()
	hudLevels.show_victory("res://levels/level_4.tscn")
