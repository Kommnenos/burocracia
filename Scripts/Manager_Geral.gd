extends Control

signal button1
signal space

var button_pressed = ""
var lugar_fila = 10
var num_options = 0
var fase1_rolando = false
var fase2_rolando = false

var num_fase2 = 1
var deu_bom = 0
####
var cpf_na_nota
var num_rg
var num_reser
var nom_jogador
var vac_dat = "06/09/1996"
var dat_nasc = "27/05/1992"

var cpf_na_nota_jog: String
var num_rg_jog: String
var num_reser_jog: String
var nom_jogador_jog: String
var vac_dat_jog: String
var dat_nasc_jog: String

####
var timer_start = false
var eventos = [{
	"Evento" : "The person in front of you is distracted by  the newest mobile game and is holding the line, what do you do? \n 1 – Try and cut the line \n 2 – Warn him about it \n 3 – Do nothing"
},
{
	"Evento": "A shady dude approaches you with a lottery ticket that he swears will win. He wants to give it to you since he believes money is evil, what will you do? \n1 – Might as well take the ticket \n 2 – SHOO STRANGER DANGER"
},
{
	"Evento": "You are really hungry. Do you want to risk it and go to the snack machine? \n1 – Pizza time \n2 – I’d rather starve "
},
{
	"Evento": "An excited hooligan asks you if you saw the game of sports last night. \n1 – HECK YEAH, GO DUCKS \n2 – HECK YEAH, GO GEESE"
},
{
	"Evento": "An old lady starts to tell you a tale about her grandchildren. You have no choice but to listen. \n1 - You try to listen intently" 
},
{
	"Evento": "You hear a distant rumble. Suddenly a meteor crashes through the roof, wrecking havoc everywhere. Chairs, desks and office supplies take off, flying violently. You wait for the dust to settle. Everyone seems safe, and the line goes back to normal. Oh well, business as usual. \n 1 - Resume the suffering"
},
{
	"Evento": "The person in front of you needs to leave for a while, and asks you if you can watch their spot untill they come back.What will you do? \n 1 - Yeah sure, no problem. \n 2 - Nah mate, ain't gonna happen \n 3 - Hehe sure (try and take their spot while they're gone)"
},
{
	"Evento": "A random dude tries and cut the line in front of you. The audacity. \n 1 - How dare they."
},
{
	"Evento": "A daring pidgeon performs an impressive show of dexterity. Too bad you were its target. \n 1- Sigh..."
}
]


func _input(event):
	if Input.is_action_pressed("option_1"):
		button_pressed = "1"
		emit_signal("button1")
	if Input.is_action_pressed("option_2") and num_options > 1:
		button_pressed = "2"
		emit_signal("button1")
	if Input.is_action_pressed("option_3") and num_options > 2:
		button_pressed = "3"
		emit_signal("button1")
	if Input.is_action_pressed("option_4") and num_options > 3:
		button_pressed = "4"
		emit_signal("button1")
	if Input.is_action_pressed("espaço"):
		emit_signal("space")
# Called when the node enters the scene tree for the first time.
func _ready():
	lugar_fila = randi() % 500 + 400
	gerar_num_doc()
	
	

func _process(delta):
	$NumeroFila/NumeroFilaTexto.text = str(lugar_fila)	
	$Prompt/Panel/Label2.text = str($Prompt/Timer2.time_left)
	if Input.is_action_just_pressed("escape"):
		if $MenuEscape.visible == false:
			$MenuEscape.visible = true
			$MenuEscape/AudioStreamAbrir.play()
		elif $MenuEscape.visible == true:
			$MenuEscape.visible = false
			$MenuEscape/AudioStreamFechar.play()
	if $BarraDeFome.value == 0:
		lugar_fila = 500
		$BarraDeFome.value = 100
		$PopUpFome.visible = true
	if lugar_fila < 0:
		$NumeroFila/NumeroFilaTexto.text = "0"
		fase1_rolando = false
		fase2_rolando = true
	if fase2_rolando == true:
		fase2_iniciar()
	if $Prompt/Timer2.time_left == 0 and timer_start:
		get_tree().change_scene_to_file("res://Scenes/CenaFinalDerrota.tscn")
		
func Barra_de_Fome(modificador):
	get_node("BarraDeFome").value += modificador

func Barra_de_Moral(modificador):
	get_node("BarraDeMoral").value += modificador
	
	
func Setup():
	$BarraDeFome.value = 100
	$BarraDeMoral.value = 100
	$PanelDialogo/DialogoText.text = "It has been a few years since your last vacation. In the heat of the moment, you purchase tickets to the Ursal Republic, a paradise of lush green forests and beautiful beaches. Soon after clicking on buy, you remember you do not have a passport. No biggie, right? A quick trip to the Federal Passport Agency should solve this. Right? Right?"
	fase1_rolando = true
func _on_BotaoReset_pressed():
	evento8()


	
	
func evento_modelo():
	$PanelDialogo/DialogoText.text = ""
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		await self.space
		event_picker()
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		await self.space
		event_picker()
	if button_pressed == "3":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		await self.space
		event_picker()
	if button_pressed == "4":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		await self.space
		event_picker()

func evento0():
	#Cara moscando
	num_options = 3
	$Fundo.texture = load("res://Assets/Sprites_UI/cena_2_-_Fila.jpg")
	get_node("PanelDialogo/DialogoText").text = eventos[0].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		if $BarraDeMoral.value >= 70:
			if tem_dado_em_casa() <= 70:
				$PanelDialogo/DialogoText.text = "SUCCESS! You managed to score a place in front of the staller, good for you!"
				lugar_fila += 1
				$BarraDeMoral.value += 20
				await self.space
				event_picker()
				
			else:
				var num_pos = randi() % 15 + 5
				$PanelDialogo/DialogoText.text = "FAILURE! People behind you got angry at you for trying to cut the line, you go back" + str(num_pos) + "positions, serves you right."
				lugar_fila -= num_pos
				$BarraDeMoral.value -= 5
				await self.space
				event_picker()
				
		else:
			if tem_dado_em_casa() >= 30:
				$PanelDialogo/DialogoText.text = "SUCCESS! You managed to score a place in front of the staller, good for you!"
				lugar_fila += 1
				$BarraDeMoral.value += 20
				await self.space
				event_picker()
				
			else:
				var num_pos = randi() % 15 + 5
				$PanelDialogo/DialogoText.text = "FAILURE! People behind you got angry at you for trying to cut the line, you go back " + str(num_pos) + " positions, serves you right."
				lugar_fila -= num_pos
				$BarraDeMoral.value -= 5
				await self.space
				event_picker()
				
	
	elif button_pressed == "2":
		get_node("PanelDialogo/DialogoText").text = "GOOD JOB! You warned the person about the line and everyone is happy. You win nothing."
		$BarraDeMoral.value += 15
		await self.space
		event_picker()
		
		
	
	elif button_pressed == "3":
		var num_pes = randi() % 10 + 1
		get_node("PanelDialogo/DialogoText").text = "MEH! You did nothing and " + str(num_pes) +  " people went to the vacant spot. Could be worse."
		await self.space
		event_picker()
		
func evento1():
	#Loteria
	num_options = 2
	$Fundo.texture = load("res://Assets/Sprites_UI/iniciar_depois.jpg")
	$Fundo/Fundo2.texture = load("res://Assets/Sprites_UI/vendedor-de-bilete_03.png")
	$Fundo/Fundo2.visible = true
	$PanelDialogo/DialogoText.text = eventos[1].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		if $BarraDeMoral.value > 30:
			if tem_dado_em_casa() <= 40:
				$PanelDialogo/DialogoText.text = "SUCCESS! Believe it or not, the ticket actually won you some money. You decide to put it to good use, and purchase a spot ahead in the line, thank you Fortuna."
				await self.space
				event_picker()
				$BarraDeMoral.value += 50
				lugar_fila -= 90
				$Fundo/Fundo2.visible = false
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! Yeah, who would’ve thought that it was a scam, the dude took your place in line while you went to check the numbers on the ticket. Back to the end of the line it is. "
				await self.space
				lugar_fila = 500
				event_picker()
				$Fundo/Fundo2.visible = false
		elif $BarraDeMoral.value < 30:
			if tem_dado_em_casa() <= 10:
				$PanelDialogo/DialogoText.text = "SUCCESS! Believe it or not, the ticket actually won you some money. You decide to put it to good use, and purchase a spot ahead in the line, thank you Fortuna."
				await self.space
				event_picker()
				$Fundo/Fundo2.visible = false
				$BarraDeMoral.value += 50
				lugar_fila -= 90
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! Yeah, who would’ve thought that it was a scam, the dude took your place in line while you went to check the numbers on the ticket. Back to the end of the line it is. "
				await self.space
				lugar_fila = 500
				event_picker()	
				$Fundo/Fundo2.visible = false
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = "GOOD THINKING! There is no way that was legit. What a weird dude."
		await self.space
		event_picker()
		$Fundo/Fundo2.visible = false

func evento2():
	#Comida
	num_options = 2
	$Fundo.texture = load("res://Assets/Sprites_UI/maquina.png")
	$PanelDialogo/DialogoText.text = eventos[2].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		var num_pos = randi() % 70 + 20
		lugar_fila += num_pos
		$BarraDeFome.value += 100
		$BarraDeMoral.value += 60
		$PanelDialogo/DialogoText.text = "YUMM! Your belly is full, but you lost " + str(num_pos) + " positions in line. I’d say it was worth it. "
		await self.space
		event_picker()
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = "BOOO! Your tummy growls at you as you stand firmly in line. Food can wait."	
		await self.space
		event_picker()	

func evento3():
	#Futebol
	num_options = 2
	$PanelDialogo/DialogoText.text = eventos[3].Evento
	$Fundo.texture = load("res://Assets/Sprites_UI/iniciar_depois.jpg")
	$Fundo/Fundo2.texture = load("res://Assets/Sprites_UI/desconhecido_03.png")
	$Fundo/Fundo2.visible = true
	lugar_fila -= randi() % 30 - 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		if tem_dado_em_casa() > 50:
			$Fundo/Fundo2.visible = false
			$BarraDeMoral.value += 20
			$PanelDialogo/DialogoText.text = "SUCCESS! You both decide to team up in a rare moment of camaraderie, motivated by your favorite team, and use a little bit of intimidation to secure a few spots ahead in line. Nobody was hurt, except for your honor of course."
			lugar_fila -= 50
			await self.space
			event_picker()
		else:
			if $BarraDeMoral.value <= 30:
				$Fundo/Fundo2.visible = false
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 30
				await self.space
				event_picker()
			else:
				$Fundo/Fundo2.visible = false
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 15
				await self.space
				event_picker()
	elif button_pressed == "2":
		if tem_dado_em_casa() > 50:
			$Fundo/Fundo2.visible = false
			$BarraDeMoral.value += 20
			$PanelDialogo/DialogoText.text = "SUCCESS! You both decide to team up in a rare moment of camaraderie, motivated by your favorite team, and use a little bit of intimidation to secure a few spots ahead in line. Nobody was hurt, except for your honor of course."
			lugar_fila -= 50
			await self.space
			event_picker()
		else:
			if $BarraDeMoral.value <= 30:
				$Fundo/Fundo2.visible = false
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 30
				await self.space
				event_picker()
			else:
				$Fundo/Fundo2.visible = false
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 15
				await self.space
				event_picker()

func evento4():
	#Veia
	num_options = 1
	$PanelDialogo/DialogoText.text = eventos[4].Evento
	$Fundo.texture = load("res://Assets/Sprites_UI/iniciar_depois.jpg")
	$Fundo/Fundo2.visible = true
	$Fundo/Fundo2.texture = load("res://Assets/Sprites_UI/vovo-e-desconhecido_06.png")
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		if $BarraDeMoral.value <= 30:
			$Fundo/Fundo2.visible = false
			$PanelDialogo/DialogoText.text = "FAILURE! The story was a tad too long and well, you may have slept a little. You wake up a few spots behind in line, and you can spot a sad grandma ahead, that just wanted to tell some stories. You monster."
			var num_pos = randi() % 15 + 5
			lugar_fila += num_pos
			await self.space
			event_picker()
		else:
			$Fundo/Fundo2.visible = false
			$PanelDialogo/DialogoText.text = "SUCCESS! You are moved to tears with the story. It fills you with joy, and the old nana is grateful for someone listening to her. What a beautiful moment."	
			$BarraDeMoral.value += 15
			await self.space
			event_picker()

func evento5():
	#Meteoro da paixao
	num_options = 1
	$Fundo.texture = load("res://Assets/Sprites_UI/meteoro.png")
	$PanelDialogo/DialogoText.text = eventos[5].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		$Fundo.texture = load("res://Assets/Sprites_UI/iniciar_depois.jpg")
		$PanelDialogo/DialogoText.text = "Business as usual"
		await self.space
		event_picker()
		

func evento6():
	#maluco pede pra guardar fila
	num_options = 3
	$Fundo.texture = load("res://Assets/Sprites_UI/cena_2_-_Fila.jpg")
	$Fundo/Fundo2.texture = load("res://Assets/Sprites_UI/desconhecido_03.png")
	$Fundo/Fundo2.visible = true
	$PanelDialogo/DialogoText.text = eventos[6].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		$PanelDialogo/DialogoText.text = "GOOD JOB! Like a good citizen, you watched the person's spot untill they returned. They are incredibly grateful."
		$Fundo/Fundo2.visible = false
		$BarraDeMoral.value += 20
		await self.space
		event_picker()
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = "FAIR ENOUGH! You're not a line babysitter. Better luck next time random person."
		$Fundo/Fundo2.visible = false
		await self.space
		event_picker()
	if button_pressed == "3":
		if $BarraDeMoral.value > 30:
			if tem_dado_em_casa() > 20:
				$Fundo/Fundo2.visible = false
				lugar_fila -= 1
				$BarraDeMoral.value += 20
				$PanelDialogo/DialogoText.text = "SUCCESS! Booo you took their place in line. They sadly accept it and go to the end of the line. How dare you? "
				await self.space
				event_picker()
			else:
				$Fundo/Fundo2.visible = false
				$PanelDialogo/DialogoText.text = "FAILURE! You try to be sly about stealing a spot but the person ain't having none of it. You are, justifiably, scolded."
				await self.space
				event_picker()
		else:
			if tem_dado_em_casa() > 50:
				$Fundo/Fundo2.visible = false
				lugar_fila -= 1
				$BarraDeMoral.value += 20
				$PanelDialogo/DialogoText.text = "SUCCESS! Booo you took their place in line. They sadly accept it and go to the end of the line. How dare you? "
				await self.space
				event_picker()
			else:
				$Fundo/Fundo2.visible = false
				$PanelDialogo/DialogoText.text = "FAILURE! You try to be sly about stealing a spot but the person ain't having none of it. You are, justifiably, scolded."
				await self.space
				event_picker()

func evento7():
	#corta fila
	num_options = 1
	$Fundo.texture = load("res://Assets/Sprites_UI/cena_2_-_Fila.jpg")
	$PanelDialogo/DialogoText.text = eventos[7].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":	
		if $BarraDeMoral.value > 30:
			$PanelDialogo/DialogoText.text = "SUCCESS! You ain't having none of this ridiculous nonsense. You quickly alert the rest of the line, which then joins you in a chorus to stop the line cutter."
			await self.space
			event_picker()
		else:
			$PanelDialogo/DialogoText.text = "FAILURE! You're too tired to do something about it. Whatever."
			lugar_fila += 1
			await self.space
			event_picker()

func evento8():
	#Pombo
	$PanelDialogo/DialogoText.text = eventos[8].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	await self.button1
	if button_pressed == "1":
		$PanelDialogo/DialogoText.text = "Life is hard."
		$BarraDeMoral.value -= 10
		await self.space
		event_picker()

func event_picker():
	if fase1_rolando == true:
		randomize()
		var rngesus = randi() % 80 + 1
		if rngesus <= 10:
			evento0()
		elif rngesus <= 20 and rngesus > 10:
			evento1()
		elif rngesus <= 35 and rngesus > 20:
			evento2()
		elif rngesus <= 45 and rngesus > 35:
			evento3()
		elif rngesus <= 55 and rngesus > 45:
			evento4()
		elif rngesus <= 60 and rngesus > 55:
			evento5()
		elif rngesus <= 70 and rngesus > 60:
			evento6()
		elif rngesus <= 80 and rngesus > 70:
			evento7()
	

func tem_dado_em_casa():
	randomize()
	var dado = randf_range(1, 100)
	return dado









func _on_BotaoInicio_pressed():
	if fase1_rolando:	
		event_picker()
		$BotaoInicio.visible = false
		$BotaoInicio/Label.visible = false
		$BotaoInicio/BotaoAudio.play()
		$Fundo.texture = load("res://Assets/Sprites_UI/iniciar_depois.jpg")
	elif fase2_rolando:
		$BotaoInicio.visible = false
		$BotaoInicio/Label.visible = false
		$Prompt.visible = true

func _on_InventarioBotao_pressed():
	if $Inventario.visible == true:
		$Inventario.visible = false
		$InventarioBotao/Folhado.play()
	else:
		$Inventario.visible = true
		$InventarioBotao/Folhado.play()

func gerar_num_doc():
	randomize()
	cpf_na_nota = randi() % 999999 + 100000
	num_rg = randi() % 999999 + 100000
	num_reser = randi() % 999999 + 100000
	$PromptInicia/Label.text = str(num_rg)
	$Inventario/RGVerso/RGNum.text = str(num_rg)
	$Inventario/CPF/CPFNum.text = str(cpf_na_nota)
	$Inventario/ReserFren/ReserNum.text = str(num_reser)


func _on_LineEdit_text_entered(new_text):
	$Fundo.texture = load("res://Assets/Sprites_Jogador/Cena_1_-_Sono.png")
	randomize()
	nom_jogador = new_text
	$Inventario/CPF/CPFNome.text = new_text
	$Inventario/CertNasc/CartNascNom.text = new_text
	$Inventario/RGVerso/RGNom.text = new_text
	$PromptInicia.visible = false
	$PanelDialogo.visible = true
	$BarraDeFome.visible = true
	$BarraDeMoral.visible = true
	$InventarioBotao.visible = true
	$NumeroFila.visible = true
	$Jogador.visible = true
	$BotaoInicio.visible = true
	Setup()
	
	
	


func _on_TextureButton_pressed():
	$PopUpFome.visible = false


func _on_Button_pressed():
	lugar_fila = 0

func fase2_iniciar():
	$BarraDeFome.visible = false
	$BarraDeMoral.visible = false
	
	$NumeroFila.visible = false
	$Jogador.visible = false
	$BotaoInicio.visible = true
	$BotaoInicio/Label.visible = true
	$PanelDialogo/DialogoText.text = "Finally, you arrive at the booth, now you must provide the kindly old bureaucrat your id numbers and name, beware though, the kindly old lady is in a bad mood, if you make a mistake you will be sent to the back of the line!"


func _on_Prompt_text_entered(new_text):
	#rg, cpf, reser, vac dose jaré,
	if num_fase2 == 1:
		timer_start = true
		$Prompt/Timer2.start()
		nom_jogador_jog = new_text
		$Prompt.clear()
		num_fase2 += 1
		$Prompt/Panel/Label.text = "Your draft certificate id number, please."
	elif num_fase2 == 2:
		num_reser_jog = new_text
		$Prompt.clear()
		num_fase2 += 1
		$Prompt/Panel/Label.text = "Your id number, please."
	elif num_fase2 == 3:
		num_rg_jog = new_text
		$Prompt.clear()
		num_fase2 += 1
		$Prompt/Panel/Label.text = "Your financial id number, please."
	elif num_fase2 == 4:
		cpf_na_nota_jog = new_text
		$Prompt.clear()
		num_fase2 += 1
		$Prompt/Panel/Label.text = "Your date of birth please, type it just like in your documents dearie, in a dd/mm/yyyy format."
	elif num_fase2 == 5:
		dat_nasc_jog = new_text
		$Prompt.clear()
		num_fase2 += 1
		$Prompt/Panel/Label.text = "Now look in your vaccination card and look for the date of your most recent Lambimia shot, write the date just like the previous one in a dd/mm/yyyy format"
	elif num_fase2 == 6:
		vac_dat_jog = new_text
		$Prompt.clear()
		$Prompt.visible = false
		num_fase2 += 1
		print(cpf_na_nota_jog)
		print(num_reser_jog)
		print(num_rg_jog)
		print(vac_dat_jog)
		print(nom_jogador_jog)
		resultado_check()
		
func resultado_check():
	cpf_na_nota = str(cpf_na_nota)
	num_rg = str(num_rg)
	num_reser = str(num_reser)
	if nom_jogador == nom_jogador_jog:
		print("Nome do jogador deu bom")
		deu_bom += 1
	elif not nom_jogador == nom_jogador_jog:
		print("Nome do jogador deu ruim")
	if cpf_na_nota == cpf_na_nota_jog:
		print("cpf deu bom")
		deu_bom += 1
	elif not cpf_na_nota == cpf_na_nota_jog:
		print("cpf deu ruim")
	if num_reser == num_reser_jog:
		print("reser deu bom")
		deu_bom += 1
	elif not num_reser == num_reser_jog:
		print("reser n deu bom")
	if num_rg == num_rg_jog:
		print("rg deu bom")
		deu_bom += 1
	if not num_rg == num_rg_jog:
		print("rg n deu bom")
	if vac_dat == vac_dat_jog:
		print("vac deu bom")
		deu_bom += 1
	elif not vac_dat == vac_dat_jog:
		print("vac n deu bom")
	if dat_nasc == dat_nasc_jog:
		print("dat nasc deu bom kkkj")
		deu_bom += 1
	elif not dat_nasc == dat_nasc_jog:
		print("dat nasc n deu bom lesk")
	if deu_bom == 6:
		get_tree().change_scene_to_file("res://Scenes/CenaFinal.tscn")
	elif not deu_bom == 6:
		get_tree().change_scene_to_file("res://Scenes/CenaFinalDerrota.tscn")
	
	
	
	
	
	
	
	
