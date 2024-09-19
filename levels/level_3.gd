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
	speeder.targetPosition = player.position
	speeder2.targetPosition = player.position
	speeder3.targetPosition = player.position

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
		
	
	
