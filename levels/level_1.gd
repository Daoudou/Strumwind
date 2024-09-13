extends Node2D

var RigidBody2D_scene: PackedScene

var timer
var level
var score
var is_paused

var posX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_level()
	$HudLevels/GiveUpButton.connect("pressed",Callable(self,"game_over"))
	$HudLevels/PauseButton.connect("pressed",Callable(self,"_on_GamePaused"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pass
	# Pour l'instant le simple fait de nous toucher provoque un game over
	if	($Player.hitten):
		game_over()

func start_level():
	timer = 50
	level = 1
	score = 0
	posX = 100
	is_paused = false
	$HudLevels.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$TimerRemain.start()
	$HudLevels.show_level(level)
	
	RigidBody2D_scene = preload("res://models/characters/soldier.tscn")
	
	var num_soldier_instance = 5
	for i in range(0,num_soldier_instance):
		var soldierInstance = RigidBody2D_scene.instantiate()
		soldierInstance.start(Vector2(posX,100))
		soldierInstance.gravity_scale = 0
		soldierInstance.rotate(180 *PI/180)
		
		var mob_spawn_location = $MobPath/MobSpawnLocation
		var direction = mob_spawn_location.rotation *PI/2
		direction += (90*PI/180)
		
		# On choisi la vélocité pour le mob
		var velocity = Vector2(randf_range(50.0,50.0),0.0)
		soldierInstance.linear_velocity = velocity.rotated(direction)
		
		posX += 100 + 35
		add_child(soldierInstance)
	

func _on_timer_remain_timeout() -> void:
	timer -= 1
	if (timer >= 0):
		$HudLevels.update_timer(timer)
	else:
		game_over()
		
func game_over():
	$TimerRemain.stop()
	$Player.gameOver = true
	$HudLevels.show_game_over()
	$HudLevels/GiveUpButton.hide()
	$HudLevels/PauseButton.hide()
	
	
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
		
	
	
