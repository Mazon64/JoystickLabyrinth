extends CharacterBody2D

@export var walk_speed := 400
var movement_velocity := Vector2.ZERO

@onready var animated_sprite := $AnimatedSprite2D

func _physics_process(delta):
	var speed = walk_speed
	var input_direction = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		input_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		input_direction.y += 1
	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		input_direction.x += 1

	input_direction = input_direction.normalized()
	movement_velocity = input_direction * speed

	velocity = movement_velocity
	move_and_slide()

	if input_direction != Vector2.ZERO:
		if abs(input_direction.x) > abs(input_direction.y):
			if input_direction.x > 0:
				animated_sprite.play("walk_right")
			else:
				animated_sprite.play("walk_left")
		else:
			if input_direction.y > 0:
				animated_sprite.play("walk_down")
			else:
				animated_sprite.play("walk_up")
	else:
		if animated_sprite.animation == "walk_up":
			animated_sprite.play("idle_up")
		elif animated_sprite.animation == "walk_down":
			animated_sprite.play("idle_down")
		elif animated_sprite.animation == "walk_left":
			animated_sprite.play("idle_left")
		elif animated_sprite.animation == "walk_right":
			animated_sprite.play("idle_right")
