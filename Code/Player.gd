extends KinematicBody2D

signal talk_to_npc(npc)

export var speed = 200
var screen_size = Vector2()
var in_front_of_npc
var npc

#########################################################
# Grundfunktionen

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2() #Movement Vector
	var _vector_dummy
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("ui_accept"):
		if in_front_of_npc:
			#2 = RichTextLabel || 3 = Timer
			#Text vom NPC wird angezeigt
			#npc.get_child(2).visible = true
			#npc.get_child(3).start()
			emit_signal("talk_to_npc", npc)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	velocity += velocity * delta
	_vector_dummy = move_and_slide(velocity)

#######################################################
# Signale

func _on_InteractiveArea_body_entered(body):
	if body.name.begins_with("NPC"):
		print("Ich habe einen NPC getroffen!")
		in_front_of_npc = true
		npc = body

func _on_InteractiveArea_body_exited(body):
	if body.name.begins_with("NPC"):
		print("Ich habe den NPC verlassen!")
		in_front_of_npc = false
		npc = null
