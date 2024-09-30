extends RigidBody2D

@onready var timerPV = $TimerPV
@onready var timerShield = $TimerShield
@onready var LabelPv = $LabelPv/LabelPvNum
@onready var labelShiedl = $LabelShield/LabelShieldNum
@onready var ShieldNode = $Shield

var pv
var shieldPV

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (shieldPV <= 0):
		ShieldNode.hide()

func start():
	pv = 150
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

func give_shield(mob : Node2D ,shieldInit):
	if (mob.shieldPV < shieldInit):
		mob.shieldPV += 8

func _on_timer_pv_timeout() -> void:
	LabelPv.text = str(pv)

func _on_timer_shield_timeout() -> void:
	labelShiedl.text = str(shieldPV)
	
