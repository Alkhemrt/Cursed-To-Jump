extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("default")



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.velocity.y = -500.0
		animated_sprite_2d.play("boing")
		$Bounce.play()
		await get_tree().create_timer(1.0).timeout
		animated_sprite_2d.play("return")
