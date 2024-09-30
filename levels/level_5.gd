extends Node2D

@onready var giveUpButton = $HudLevels/GiveUpButton
@onready var pauseButton = $HudLevels/PauseButton
@onready var player = $Player
@onready var hudLevels = $HudLevels
@onready var timerRemain = $TimerRemain
@onready var timerPV = $TimerPV
@onready var startPosition = $StartPosition
@onready var boss = $Boss
@onready var gardian = $Gardian
@onready var gardian2 = $Gardian2

@export var fire_rate = 0.2 # Ceci cera l'intervalle entre les soins (définie en secondes)
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
		
	if (boss != null):
		time_since_last_shot += delta
		if time_since_last_shot >= fire_rate:
			if (gardian != null):
				gardian.give_shield(boss, 200)
			if (gardian2 != null):
				gardian2.give_shield(boss, 200)
				
			time_since_last_shot = 0.0
		boss.directionMissile = player.position
	else :
		if ((gardian == null) and (gardian2 == null)):
			victory()

func start_level():
	timer = 120
	level = 5
	score = 0
	is_paused = false
	hudLevels.show_message("Get Ready")
	player.start(startPosition.position)
	timerRemain.start()
	timerPV.start()
	hudLevels.show_level(level)

		
func game_over():
	timerRemain.stop()
	timerPV.stop()
	hudLevels.show_game_over()
	
func _on_GamePaused():
	if	(is_paused == false):
		hudLevels.set_process(false)
		timerRemain.stop()
		timerPV.stop()
		hudLevels.show_message("Paused")
		is_paused = true
	elif (is_paused == true):
		hudLevels.set_process(true)
		timerRemain.start()
		timerPV.start()
		hudLevels.show_message("")
		is_paused = false

func _on_timer_remain_timeout() -> void:
	timer -= 1
	if (timer >= 0):
		hudLevels.update_timer(timer)
	else:
		game_over()

func victory():
	timerRemain.stop()
	giveUpButton.hide()
	pauseButton.hide()
	hudLevels.show_victory("res://scenes/levels_select.tscn")


func _on_timer_pv_timeout() -> void:
	hudLevels.update_pv(player.pv)
