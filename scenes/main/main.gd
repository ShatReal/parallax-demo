extends Node2D


const SPEED := 200
const CAM_START := Vector2(240, 135)
const PATHS := {
	"aurora_borealis": "res://scenes/aurora_borealis/aurora_borealis.tscn",
	"beach": "res://scenes/beach/beach.tscn",
	"forest_snowy": "res://scenes/forest_snowy/forest_snowy.tscn",
	"forest_sunny": "res://scenes/forest_sunny/forest_sunny.tscn",
	"space": "res://scenes/space/space.tscn",
	"temple": "res://scenes/temple/temple.tscn",
}

var scroll_left := false
var scroll_right := false
var cur_scene:ParallaxBackground

onready var menu := $CanvasLayer/Menu
onready var scene_ui := $CanvasLayer/SceneUI
onready var player := $CanvasLayer/SceneUI/AnimationPlayer
onready var left := $CanvasLayer/Left
onready var right := $CanvasLayer/Right
onready var cam := $Camera2D


func _ready():
	set_process(false)
	left.get_child(0).disabled = true
	right.get_child(0).disabled = true


func _process(delta):
	var move := float(scroll_right) - float(scroll_left)
	cam.position.x += move * delta * SPEED


func _on_scene_selected(key):
	cur_scene = load(PATHS[key]).instance()
	add_child(cur_scene)
	left.get_child(0).disabled = false
	right.get_child(0).disabled = false
	menu.hide()
	scene_ui.show()
	player.play("move")
	set_process(true)


func _on_left_mouse_entered():
	scroll_left = true


func _on_left_mouse_exited():
	scroll_left = false


func _on_right_mouse_entered():
	scroll_right = true


func _on_right_mouse_exited():
	scroll_right = false


func _on_back_pressed():
	set_process(false)
	left.get_child(0).disabled = true
	right.get_child(0).disabled = true
	scroll_left = false
	scroll_right = false
	cur_scene.free()
	menu.show()
	scene_ui.hide()
	player.stop()
	cam.position = CAM_START
