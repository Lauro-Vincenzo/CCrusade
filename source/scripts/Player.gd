extends Area2D

@export var base_velocity = 100
@export var blink_multiplier = 100
@export var blink_cooldown = 1

var velocity = Vector2.ZERO
var is_blink_available = true

func process_input_movement(delta):
	velocity = Vector2.ZERO

	if Input.is_action_pressed("MoveRight"):
		velocity.x += base_velocity
	if Input.is_action_pressed("MoveLeft"):
		velocity.x += -base_velocity
	if Input.is_action_pressed("MoveDown"):
		velocity.y += base_velocity
	if Input.is_action_pressed("MoveUp"):
		velocity.y += -base_velocity


	if is_blink_available == true:
		if Input.is_action_just_pressed("DashRight"):
			velocity.x *= blink_multiplier
			player_blinked()
		if Input.is_action_just_pressed("DashLeft"):
			velocity.x *= blink_multiplier
			player_blinked()
		if Input.is_action_just_pressed("DashDown"):
			velocity.y *= blink_multiplier
			player_blinked()
		if Input.is_action_just_pressed("DashUp"):
			velocity.y *= blink_multiplier
			player_blinked()

	position += velocity * delta

func player_blinked():
	$BlinkCooldownTimer.start()
	is_blink_available = false
	$BlinkSFX.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input_movement(delta)

func _on_blink_cooldown_timer_timeout():
	is_blink_available = true
