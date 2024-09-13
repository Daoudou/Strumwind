extends Node2D

var timer
var level
var score
var is_paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_level()
	$HudLevels/GiveUpButton.connect("pressed",Callable(self,"game_over"))
	$HudLevels/PauseButton.connect("pressed",Callable(self,"_on_GamePaused"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_level():
	timer = 80
	level = 4
	score = 0
	is_paused = false
	$HudLevels.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$TimerRemain.start()
	$HudLevels.show_level(level)

func _on_timer_remain_timeout() -> void:
	timer -= 1
	if (timer >= 0):
		$HudLevels.update_timer(timer)
	else:
		game_over()
		
func game_over():
	$TimerRemain.stop()
	$HudLevels.show_game_over()
	
func _on_GamePaused():
	if	(is_paused == false):
		$HudLevels.set_process(false)
		$TimerRemain.stop()
		$HudLevels.show_message("Paused")
		is_paused = true
	elif (is_paused == true):
		$HudLevels.set_process(true)
		$TimerRemain.start()
		$HudLevels.show_message("")
		is_paused = false
		
	
	
