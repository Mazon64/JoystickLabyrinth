extends CharacterBody2D

@export var walk_speed := 200
@export var run_speed := 400
var movement_velocity := Vector2.ZERO

@onready var animated_sprite := $AnimatedSprite2D

func _physics_process(delta):
	var speed = walk_speed
	var input_direction = Vector2.ZERO

	# Capturar movimiento de WASD
	if Input.is_action_pressed("move_up"):
		input_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		input_direction.y += 1
	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		input_direction.x += 1

	# Verificar si se presiona 'Shift' para correr
	if Input.is_action_pressed("move_sprint"):
		speed = run_speed

	# Normalizar dirección y ajustar velocidad
	input_direction = input_direction.normalized()
	movement_velocity = input_direction * speed

	# Movimiento del personaje (sin argumentos)
	velocity = movement_velocity
	move_and_slide()

	# Actualizar animaciones según la dirección
	if input_direction != Vector2.ZERO:
		if abs(input_direction.x) > abs(input_direction.y):
			if input_direction.x > 0:
				animated_sprite.play("run_right" if speed == run_speed else "walk_right")
			else:
				animated_sprite.play("run_left" if speed == run_speed else "walk_left")
		else:
			if input_direction.y > 0:
				animated_sprite.play("run_down" if speed == run_speed else "walk_down")
			else:
				animated_sprite.play("run_up" if speed == run_speed else "walk_up")
	else:
		# Animaciones idle
		if animated_sprite.animation == "walk_up" or animated_sprite.animation == "run_up":
			animated_sprite.play("idle_up")
		elif animated_sprite.animation == "walk_down" or animated_sprite.animation == "run_down":
			animated_sprite.play("idle_down")
		elif animated_sprite.animation == "walk_left" or animated_sprite.animation == "run_left":
			animated_sprite.play("idle_left")
		elif animated_sprite.animation == "walk_right" or animated_sprite.animation == "run_right":
			animated_sprite.play("idle_right")
