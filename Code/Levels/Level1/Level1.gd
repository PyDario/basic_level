extends Node2D

signal change_level(next_scene)

func _ready():
	$PlayerDummy.visible = false
	get_node("../../Player").position = $PlayerDummy.position

func _on_Area2D_body_entered(_body):
	emit_signal("change_level", "Level0")

func _on_talk_to_npc(npc):
	if npc.has_talked == 0:
		npc.has_talked += 1
	else:
		if npc.has_alt_text == true:
			npc.get_node("RichTextLabel").text = npc.alt_text
	npc.get_node("RichTextLabel").visible = true
	npc.get_node("Timer").start()
