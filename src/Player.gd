extends KinematicBody2D

const CELL_SIZE = 8
const SPEED = 64

onready var sprite = $Sprite

var last_position = Vector2.ZERO
var target_position = Vector2.ZERO
var movement_direction = Vector2.ZERO

func _ready():
    position = position.snapped(Vector2(CELL_SIZE, CELL_SIZE))
    last_position = position
    target_position = position

func _physics_process(delta):
    position += movement_direction * SPEED * delta

    if position.distance_to(last_position) >= CELL_SIZE - SPEED * delta:
        position = target_position

    if position == target_position:
        update_movement_dir()
        last_position = position
        target_position += movement_direction * CELL_SIZE

    update_sprite_rotation()

func update_movement_dir():
    var left = Input.is_action_pressed("ui_left")
    var right = Input.is_action_pressed("ui_right")
    var up = Input.is_action_pressed("ui_up")
    var down = Input.is_action_pressed("ui_down")

    movement_direction.x = int(right) - int(left)
    movement_direction.y = int(down) - int(up)

    if movement_direction.x != 0 and movement_direction.y != 0:
        movement_direction = Vector2.ZERO

func update_sprite_rotation():
    if movement_direction.x != 0:
        sprite.rotation = 0
        sprite.flip_h = movement_direction.x < 0
    elif movement_direction.y != 0:
        sprite.flip_h = false
        if movement_direction.y > 0:
            sprite.rotation_degrees = 90
        else:
            sprite.rotation_degrees = -90
