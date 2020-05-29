extends KinematicBody2D

export var conv_loop = true
var conv_count = 0

func _ready():
	$RichTextLabel.visible = false

func _on_Timer_timeout():
	$RichTextLabel.visible = false
