extends KinematicBody2D

const CELL_SIZE = 8
const CELL_VECTOR = Vector2(CELL_SIZE, CELL_SIZE)
const SPEED = 32

onready var sprite = $Sprite

var move_dir = Vector2.RIGHT
var prev_move_dir = move_dir

func _ready():
    position = position.snapped(CELL_VECTOR)

func _physics_process(delta):
    update_move_dir()

    var collided = move_and_slide(move_dir * SPEED) == Vector2.ZERO

    if collided:
        move_and_slide(prev_move_dir * SPEED)
    else:
        update_prev_move_dir()

func _process(delta):
    update_sprite_rotation()

func update_prev_move_dir():
    if move_dir == prev_move_dir:
        return
    position = position.snapped(CELL_VECTOR)
    prev_move_dir = move_dir

func update_move_dir():
    var left = Input.is_action_pressed("ui_left")
    var right = Input.is_action_pressed("ui_right")
    var up = Input.is_action_pressed("ui_up")
    var down = Input.is_action_pressed("ui_down")

    var move = Vector2( \
        int(right) - int(left), \
        int(down) - int(up))

    if (up or down) != (left or right):
        move_dir = move

func update_sprite_rotation():
    if prev_move_dir.x != 0:
        sprite.rotation = 0
        sprite.position = Vector2.ZERO
        sprite.flip_h = prev_move_dir.x < 0
    elif prev_move_dir.y != 0:
        sprite.flip_h = false
        if prev_move_dir.y > 0:
            sprite.position.x = 8
            sprite.position.y = 0
            sprite.rotation_degrees = 90
        else:
            sprite.position.x = 0
            sprite.position.y = 8
            sprite.rotation_degrees = -90
