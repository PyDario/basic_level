extends Node

func _ready():
	$Timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	$Sprite.visible = !$Sprite.visible
