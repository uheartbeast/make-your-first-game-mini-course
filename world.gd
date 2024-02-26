extends Node2D

const SawBladeTelegraphScene = preload("res://saw_blade_telegraph.tscn")

@onready var timer: Timer = $Timer
@onready var spawn_zone: ColorRect = $SpawnZone
@onready var saw_count_label: Label = $SawCountLabel

var saw_count = 0

func _ready():
	spawn_zone.hide()
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)
	Events.saw_blade_added.connect(update_saw_count)

func update_saw_count():
	saw_count += 1
	saw_count_label.text = "Blades\n" + str(saw_count)

func _on_timer_timeout():
	var saw_blade_telegraph = SawBladeTelegraphScene.instantiate()
	var rect = spawn_zone.get_global_rect()
	var saw_x = randf_range(rect.position.x, rect.end.x)
	var saw_y = randf_range(rect.position.y, rect.end.y)
	saw_blade_telegraph.position = Vector2(saw_x, saw_y)
	add_child(saw_blade_telegraph)
