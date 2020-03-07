extends KinematicBody2D

const CELL_SIZE = 8
const SPEED = 64
const CELL_VECTOR = Vector2(CELL_SIZE, CELL_SIZE)

onready var sprite = $Sprite

var movement_direction = Vector2.RIGHT

func _ready():
    position = position.snapped(CELL_VECTOR)

func _physics_process(delta):
    move_and_slide(movement_direction * SPEED)

    update_movement_dir()

func _process(delta):
    update_sprite_rotation()

func update_movement_dir():
    var left = Input.is_action_pressed("ui_left")
    var right = Input.is_action_pressed("ui_right")
    var up = Input.is_action_pressed("ui_up")
    var down = Input.is_action_pressed("ui_down")

    var new_move = Vector2(int(right) - int(left), int(down) - int(up))

    if (up or down) != (left or right):
        position = position.snapped(CELL_VECTOR)
        movement_direction = new_move

func update_sprite_rotation():
    if movement_direction.x != 0:
        sprite.rotation = 0
        sprite.position = Vector2.ZERO
        sprite.flip_h = movement_direction.x < 0
    elif movement_direction.y != 0:
        sprite.flip_h = false
        if movement_direction.y > 0:
            sprite.position.x = 8
            sprite.position.y = 0
            sprite.rotation_degrees = 90
        else:
            sprite.position.x = 0
            sprite.position.y = 8
            sprite.rotation_degrees = -90
