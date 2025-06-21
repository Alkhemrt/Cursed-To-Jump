extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Objects/Area2D/AnimatedSprite2D
@onready var color_flash: ColorRect = $CanvasLayer/ColorFlash
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_out")
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		color_flash.visible = true
		var player = get_tree().get_first_node_in_group("player")
		player.is_moving = false
		player.final_level = true
		player.animated_sprite_2d.play("holding")
		player.items_holding.visible = true
		$Audio/Boost.play()
		animated_sprite_2d.play("opened")
		await get_tree().create_timer(0.1).timeout
		color_flash.visible = false
		await get_tree().create_timer(3).timeout
		color_flash.visible = true
		player.is_moving = true
		player.final_level = false
		player.animated_sprite_2d.play("run")
		player.items_holding.visible = false
		$Audio/Second.play()
		await get_tree().create_timer(0.1).timeout
		color_flash.visible = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
