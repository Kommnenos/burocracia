extends Control

signal button1
signal button2
signal button3
signal button4
signal button5

var inputado = false

var eventos = [{
	"Evento" : "Um maluco na sua frente ta moscando no celular e segurando a fila, o que fazes?\n1 - Passa na frente do moscão\n2 - Faz nada\n3 - Avisa o djow"
},
{
	"Evento": "I'm gonna say the n-word \n 1- No you can't say the n-word that's racist \n 2- MRS. OBAMA GET DOWN! \n 3-Nig... *dies*"
}]



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func Barra_de_Fome(modificador):
	get_node("BarraDeFome").value = modificador

func Barra_de_Moral(modificador):
	get_node("BarraDeMoral").value = modificador
	
	
func Setup():
	$BarraDeFome.value = 100
	$BarraDeMoral.value = 100
	$PanelDialogo/DialogoText.text = "Texto Introdutório mais curto que a tragédia de Darto Praga o sábio"

func _on_BotaoReset_pressed():
	Setup()


	
	
func evento_modelo():
	get_node("PanelDialogo/DialogoText").text = ""
	if Input.is_action_pressed("option_1"):
		get_node("PanelDialogo/DialogoText").text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
	if Input.is_action_pressed("option_2"):
		get_node("PanelDialogo/DialogoText").text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
	if Input.is_action_pressed("option_3"):
		get_node("PanelDialogo/DialogoText").text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
	if Input.is_action_pressed("option_4"):
		get_node("PanelDialogo/DialogoText").text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
	if Input.is_action_pressed("option_5"):
		get_node("PanelDialogo/DialogoText").text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0

func evento0():
	get_node("PanelDialogo/DialogoText").text = eventos[0].Evento
	if Input.is_action_pressed("option_1"):
		get_node("PanelDialogo/DialogoText").text = "Vc passa na frente do tio >:c"
		$BarraDeFome.value += 10
		$BarraDeMoral.value += 10
		
	elif Input.is_action_pressed("option_2"):
		get_node("PanelDialogo/DialogoText").text = "Covardao kkkjjjjjjjjjjjjjjjjjjjjjj"
		$BarraDeFome.value -= 10
		$BarraDeMoral.value -= 20
	elif Input.is_action_pressed("option_3"):
		get_node("PanelDialogo/DialogoText").text = "Tuconvence o malandro sla"
		$BarraDeFome.value -= 5
		$BarraDeMoral.value -= 5
	
func evento1():
	get_node("PanelDialogo/DialogoText").text = eventos[1].Evento
	if Input.is_action_pressed("option_1"):
		get_node("PanelDialogo/DialogoText").text = "Vc detona o cara"
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		
	if Input.is_action_pressed("option_2"):
		get_node("PanelDialogo/DialogoText").text = "RIP MRS. OBAMA"
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		
	if Input.is_action_pressed("option_3"):
		get_node("PanelDialogo/DialogoText").text = "VC FALHOU EM CONSEGUIR O PASSE"
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		
	
		
func _on_BotaoReset2_pressed():
	evento0()


func _on_BotaoReset3_pressed():
	evento1()
