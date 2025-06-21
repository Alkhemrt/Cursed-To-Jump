extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.is_flipped == true:
			body.is_flipped = false
		elif body.is_flipped == false:
			body.is_flipped = true
