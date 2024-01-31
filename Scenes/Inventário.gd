extends Node2D
@onready var CPF = $CPF
@onready var CarteiraVac = $CarteiraVac
@onready var CertNasc = $CertNasc
@onready var RGFrent = $RGFrente
@onready var RGVerso = $RGVerso
@onready var ReserFren = $ReserFren
@onready var ReserVer = $ReserVer

@onready var documento_array = [CPF, CarteiraVac, CertNasc, RGFrent, RGVerso, ReserFren, ReserVer]
var cycle = 0

func _on_EsquerdaSeta_pressed():
	if cycle > 0:
		cycle -= 1
		set_documento_visible()
		$Folheando.play()

func _on_DireitaSeta_pressed():
	if cycle < 6:
		cycle += 1
		set_documento_visible()
		$Folheando.play()

func set_documento_visible():
	documento_array[0].visible = false
	documento_array[1].visible = false
	documento_array[2].visible = false
	documento_array[3].visible = false
	documento_array[4].visible = false
	documento_array[5].visible = false
	documento_array[6].visible = false
	documento_array[cycle].visible = true
