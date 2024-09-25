extends RigidBody2D

@export var missile_scene: PackedScene
@export var fire_rate = 0.5 # Ceci cera l'intervalle entre les tirs (définie en secondes)

@onready var collision = $CollisionShape2D
@onready var missileLoad = preload("res://models/missile.tscn")

var time_since_last_shot: float = 0.0

var directionMissile: Vector2 = Vector2.ZERO

var pv

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set_physics_process(true)
	collision.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_shot += delta
	if time_since_last_shot >= fire_rate:
		fire_missile()
		time_since_last_shot = 0.0

func start(pos):
	position = pos
	pv = 100
	show()

func fire_missile():
	for i in range(1):
		missile_scene = missileLoad
		var missile = missile_scene.instantiate() as Area2D
		var target = Vector2.ZERO	
		
		target = Vector2(missile.position.x,1000)
		missile.position = Vector2(missile.position.x,missile.position.y + 65)
	
		missile.direction = (target - missile.position).normalized()
		missile.velocity = (target - missile.position).normalized() * missile.speed
		# Ajuster la rotation du missile pour qu'il fasse face à sa direction
		missile.rotation = missile.direction.angle()
	
		#add_child(missile)
		
func take_damage(damage):
	pv -= damage
	if (pv <= 0):
		queue_free()
