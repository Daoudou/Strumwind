extends RigidBody2D

@export var missile_scene: PackedScene
@export var fire_rate = 0.5 # Ceci cera l'intervalle entre les tirs (définie en secondes)

@onready var collision = $CollisionShape2D
@onready var missileLoad = preload("res://models/missile.tscn")
@onready var labelPVNum = $LabelPv/LabelPvNum
@onready var labelShield = $LabelShield
@onready var labelShieldNum = $LabelShield/LabelShieldNum
@onready var TimerPv = $TimerPV
@onready var TimerShield = $TimerShield

var time_since_last_shot: float = 0.0

var directionMissile: Vector2 = Vector2.ZERO

var pv
var shieldPV

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_shot += delta
	if time_since_last_shot >= fire_rate:
		fire_missile(Vector2(-60,170))
		fire_missile(Vector2(60,176))
		fire_missile(Vector2(-115,175))
		fire_missile(Vector2(115,175))
		time_since_last_shot = 0.0

func start():
	pv = 350
	shieldPV = 200
	collision.disabled = false
	TimerPv.start()
	TimerShield.start()
	show()

func fire_missile(pos):
	for i in range(1):
		missile_scene = missileLoad
		var missile = missile_scene.instantiate() as Area2D
		var target = Vector2.ZERO	
		
		target = Vector2(missile.position.x,1000)
		missile.position = pos
	
		missile.direction = (target - missile.position).normalized()
		missile.velocity = (target - missile.position).normalized() * missile.speed
		# Ajuster la rotation du missile pour qu'il fasse face à sa direction
		missile.rotation = missile.direction.angle()
		missile.set_degat(10)
		
		add_child(missile)
		
func take_damage(damage):
	if (shieldPV <= 0):
		pv -= damage
		if (pv <= 0):
			TimerPv.stop()
			TimerShield.stop()
			queue_free()
	else:
		shieldPV -= damage
		

func _on_timer_pv_timeout() -> void:
	labelPVNum.text = str(pv)


func _on_timer_shield_timeout() -> void:
	labelShieldNum.text = str(shieldPV)
