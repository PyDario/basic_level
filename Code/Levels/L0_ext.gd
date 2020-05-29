extends "res://Code/LevelRoot.gd"

func _on_LevelBorder0_body_entered(_body):
	emit_signal("change_level", "Level1")
