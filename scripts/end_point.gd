extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		get_parent().get_parent().get_node("AnimationPlayer").play("fade_in")
