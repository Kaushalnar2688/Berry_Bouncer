extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "RUNNING"
	else:
		sprite_2d.animation = "default"
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite_2d.animation = "JUMPING"
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 17)

	move_and_slide()
