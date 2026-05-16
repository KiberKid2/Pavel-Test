extends CharacterBody2D

@export var jump_force: float = -350.0
@export var gravity: float = 1000.0
@export var rotation_speed: float = 5.0

var is_alive: bool = true

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	velocity.y += gravity * delta
	move_and_slide()
	
	rotate_towards_target(delta)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_alive:
		jump()


func jump() -> void:
	velocity.y = jump_force


func rotate_towards_target(delta: float) -> void:
	var target_rotation: float
	if velocity.y < 0:
		target_rotation = deg_to_rad(-25)
	else:
		target_rotation = deg_to_rad(90)
	
	rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)


func die() -> void:
	is_alive = false
	collision_shape.set_deferred("disabled", true)


func reset() -> void:
	position = Vector2(100, 360)
	velocity = Vector2.ZERO
	rotation = 0
	is_alive = true
	collision_shape.set_deferred("disabled", false)
