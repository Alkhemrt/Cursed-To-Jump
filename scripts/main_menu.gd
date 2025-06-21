extends Node2D

@onready var start: Label = $CanvasLayer/Start
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("fade_out")


func _process(delta: float) -> void:
	if start.visible == true:
		await get_tree().create_timer(0.5).timeout
		start.visible = false
	elif start.visible == false:
		await get_tree().create_timer(0.5).timeout
		start.visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		animation_player.play("fade_in")
		$Audio/StartSfx.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/levels/level_one.tscn")
