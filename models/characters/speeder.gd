extends RigidBody2D

@export var speed = 4

@onready var timerPV = $TimerPV
@onready var timerShield = $TimerShield
@onready var LabelPv = $LabelPv/LabelPvNum
@onready var labelShiedl = $LabelShield/LabelShieldNum
@onready var ShieldNode = $Shield

var targetPosition = Vector2.ZERO

var pv
var shieldPV
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (shieldPV <= 0):
		ShieldNode.hide()
	var direction = position.angle_to_point(targetPosition)
	# On choisi la vélocité pour le mob
	var velocity = Vector2(randf_range(50.0,50.0),0.0) * speed
	self.linear_velocity = velocity.rotated(direction)
	self.rotation = direction
	
func start():
	pv = 50
	shieldPV = 100
	timerPV.start()
	timerShield.start()
	show()
	
func take_damage(damage):
	if (shieldPV <= 0):
		pv -= damage
		if (pv <= 0):
			timerPV.stop()
			timerShield.stop()
			queue_free()
	else:
		shieldPV -= damage


func _on_timer_pv_timeout() -> void:
	LabelPv.text = str(pv)


func _on_timer_shield_timeout() -> void:
	labelShiedl.text = str(shieldPV)
