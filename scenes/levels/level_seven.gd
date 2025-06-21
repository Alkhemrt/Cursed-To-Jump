extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_out")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player = get_tree().get_first_node_in_group("player")
		player.position = Vector2(-152, 280) 
		$Audio/Fall.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/levels/level_eight.tscn")
