extends Node3D

@onready var drip_particles: CPUParticles3D = $Hands/Skeleton3D/BoneAttachmentLeftHand/DripParticles
@onready var splash_particles: CPUParticles3D = $Hands/Skeleton3D/BoneAttachmentLeftHand/SplashParticles

func _ready():
	await get_tree().create_timer(1.9).timeout
	splash_particles.emitting = true

func _on_animation_tree_animation_started(anim_name:StringName):
	if anim_name == "Blood_Offering_Idle":
		drip_particles.emitting = true
