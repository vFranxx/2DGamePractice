extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_jump = false
var sound_playing = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var coyote_timer = $CoyoteTimer
@onready var jump_sound = $JumpSound
@onready var run_sound = $RunSound
@onready var run_timer = $RunSound/RunTimer

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	# Get the input direction {-1; 0; 1} and handle the movement/deceleration.
	var direction = Input.get_axis("Move_left", "Move_right")
	handle_player_visuals(direction)
	handle_player_movement(direction)
	coyote_jump()
	move_and_slide()

func apply_gravity(delta):
	# Apply gravity.
	if !is_on_floor():
		velocity.y += gravity * delta

func handle_player_movement(direction):
	if direction != 0:
		velocity.x = direction * SPEED
		
		if is_on_floor() and not sound_playing:
			run_sound.play()
			run_timer.start()
			sound_playing = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _on_run_timer_timeout(): # Controls the sound while running
	sound_playing = false	

func handle_jump():
	# Handle jump.
	if Input.is_action_just_pressed("Jump") && (is_on_floor() || can_jump):
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		can_jump = false

func handle_player_visuals(direction):
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	if direction < 0:
		animated_sprite.flip_h = true
	
	#Play animations
	if is_on_floor():
		animated_sprite.play("animation_idle" if direction == 0 else ("animation_run"))
	else: 
		animated_sprite.play("animation_jump")

func coyote_jump():
	var was_on_floor = is_on_floor()
	
	if was_on_floor && !Input.is_action_just_pressed("Jump"):
		coyote_timer.start()
		can_jump = true
	elif coyote_timer.is_stopped():
		can_jump = false
