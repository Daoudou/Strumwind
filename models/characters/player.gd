extends Area2D

var speed = 500
var screen_size

var hitten
var gameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()

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
		
		if velocity.length() > 0: # On verifie que le vecteur n'est pas null
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
		
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)

func start(pos):
	position = pos
	hitten = false
	gameOver = false
	show()

func _on_body_entered(body: Node2D) -> void:
	hitten = true
