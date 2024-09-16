extends Node2D

var RigidBody2D_scene: PackedScene

@onready var giveUpButton = $HudLevels/GiveUpButton
@onready var pauseButton = $HudLevels/PauseButton
@onready var player = $Player
@onready var hudLevels = $HudLevels
@onready var timerRemain = $TimerRemain
@onready var startPosition = $StartPosition
@onready var mobSpawnLocation = $MobPath/MobSpawnLocation

var timer
var level
var score
var is_paused

var posX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_level()
	giveUpButton.connect("pressed",Callable(self,"game_over"))
	pauseButton.connect("pressed",Callable(self,"_on_GamePaused"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pass
	# Pour l'instant le simple fait de nous toucher provoque un game over
	if	(player.hitten):
		game_over()

func start_level():
	timer = 50
	level = 1
	score = 0
	posX = 100
	is_paused = false
	hudLevels.show_message("Get Ready")
	player.start(startPosition.position)
	timerRemain.start()
	hudLevels.show_level(level)
	
	RigidBody2D_scene = preload("res://models/characters/soldier.tscn")
	
	var num_soldier_instance = 5
	for i in range(0,num_soldier_instance):
		var soldierInstance = RigidBody2D_scene.instantiate()
		soldierInstance.start(Vector2(posX,100))
		soldierInstance.gravity_scale = 0
		soldierInstance.rotate(180 *PI/180)
		
		var mob_spawn_location = mobSpawnLocation
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
		hudLevels.update_timer(timer)
	else:
		game_over()
		
func game_over():
	timerRemain.stop()
	player.gameOver = true
	hudLevels.show_game_over()
	giveUpButton.hide()
	pauseButton.hide()
	
	
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
		
	
	
