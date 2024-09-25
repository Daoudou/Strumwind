extends Area2D

@export var missile_scene: PackedScene
@onready var collision = $CollisionShape2D
@export var fire_rate = 0.2 # Ceci cera l'intervalle entre les tirs (définie en secondes)
var time_since_last_shot: float = 0.0

var pv

var speed = 500
var screen_size

var hitten
var gameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	collision.disabled = false
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (gameOver == false):
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("fire"):
			time_since_last_shot += delta
			if time_since_last_shot >= fire_rate:
				fire_missile()
				time_since_last_shot = 0.0
		
		if velocity.length() > 0: # On verifie que le vecteur n'est pas null
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
		
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)

func start(pos):
	position = pos
	pv = 100
	hitten = false
	gameOver = false
	show()
	
func take_damage(damage):
	pv -= damage
	
func fire_missile():
	
	missile_scene = preload("res://models/missile.tscn")
	var missile = missile_scene.instantiate() as Area2D
	missile.set_degat(50)
	# Définir la direction du missile (par exemple, vers la droite)
	missile.direction = Vector2.UP
	
	# Ajuster la rotation du missile pour qu'il fasse face à sa direction
	missile.rotation = missile.direction.angle()
	
	add_child(missile)
	
func _on_body_entered(body: Node2D) -> void:
	print("joueur toucher")
