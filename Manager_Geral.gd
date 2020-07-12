extends Control

signal button1
signal space

var button_pressed = ""
var lugar_fila = 10
var num_options = 0
var fase1_rolando = false

####
var cpf_na_nota
var num_rg
var num_reser
var nom_jogador
####

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
	yield(self, "button1")
	if button_pressed == "1":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		yield(self, "space")
		event_picker()
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		yield(self, "space")
		event_picker()
	if button_pressed == "3":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		yield(self, "space")
		event_picker()
	if button_pressed == "4":
		$PanelDialogo/DialogoText.text = ""
		$BarraDeFome.value += 0
		$BarraDeMoral.value += 0
		yield(self, "space")
		event_picker()

func evento0():
	num_options = 3
	get_node("PanelDialogo/DialogoText").text = eventos[0].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		if $BarraDeMoral.value >= 70:
			if tem_dado_em_casa() <= 70:
				$PanelDialogo/DialogoText.text = "SUCCESS! You managed to score a place in front of the staller, good for you!"
				lugar_fila += 1
				yield(self, "space")
				event_picker()
				
			else:
				var num_pos = randi() % 15 + 5
				$PanelDialogo/DialogoText.text = "FAILURE! People behind you got angry at you for trying to cut the line, you go back" + num_pos + "positions, serves you right."
				lugar_fila -= num_pos
				$BarraDeMoral.value -= 5
				yield(self, "space")
				event_picker()
				
		else:
			if tem_dado_em_casa() >= 30:
				$PanelDialogo/DialogoText.text = "SUCCESS! You managed to score a place in front of the staller, good for you!"
				lugar_fila += 1
				yield(self, "space")
				event_picker()
				
			else:
				var num_pos = randi() % 15 + 5
				$PanelDialogo/DialogoText.text = "FAILURE! People behind you got angry at you for trying to cut the line, you go back " + str(num_pos) + " positions, serves you right."
				lugar_fila -= num_pos
				$BarraDeMoral.value -= 5
				yield(self, "space")
				event_picker()
				
	
	elif button_pressed == "2":
		get_node("PanelDialogo/DialogoText").text = "GOOD JOB! You warned the person about the line and everyone is happy. You win nothing."
		yield(self, "space")
		event_picker()
		
		
	
	elif button_pressed == "3":
		var num_pes = randi() % 10 + 1
		get_node("PanelDialogo/DialogoText").text = "MEH! You did nothing and " + str(num_pes) +  " people went to the vacant spot. Could be worse."
		yield(self, "space")
		event_picker()
		
func evento1():
	num_options = 2
	$PanelDialogo/DialogoText.text = eventos[1].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		if $BarraDeMoral.value > 30:
			if tem_dado_em_casa() <= 40:
				$PanelDialogo/DialogoText.text = "SUCCESS! Believe it or not, the ticket actually won you some money. You decide to put it to good use, and purchase a spot ahead in the line, thank you Fortuna."
				yield(self, "space")
				event_picker()
				$BarraDeMoral.value += 20
				lugar_fila -= 90
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! Yeah, who would’ve thought that it was a scam, the dude took your place in line while you went to check the numbers on the ticket. Back to the end of the line it is. "
				yield(self, "space")
				lugar_fila = 500
				event_picker()
		elif $BarraDeMoral.value < 30:
			if tem_dado_em_casa() <= 10:
				$PanelDialogo/DialogoText.text = "SUCCESS! Believe it or not, the ticket actually won you some money. You decide to put it to good use, and purchase a spot ahead in the line, thank you Fortuna."
				yield(self, "space")
				event_picker()
				$BarraDeMoral.value += 20
				lugar_fila -= 90
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! Yeah, who would’ve thought that it was a scam, the dude took your place in line while you went to check the numbers on the ticket. Back to the end of the line it is. "
				yield(self, "space")
				lugar_fila = 500
				event_picker()	
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = "GOOD THINKING! There is no way that was legit. What a weird dude."
		yield(self, "space")
		event_picker()

func evento2():
	num_options = 2
	$PanelDialogo/DialogoText.text = eventos[2].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		var num_pos = randi() % 20 + 1
		lugar_fila += num_pos
		$BarraDeFome.value += 100
		$PanelDialogo/DialogoText.text = "YUMM! Your belly is full, but you lost" + str(num_pos) + "positions in line. I’d say it was worth it. "
		yield(self, "space")
		event_picker()
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = "BOOO! Your tummy growls at you as you stand firmly in line. Food can wait."	
		yield(self, "space")
		event_picker()
	

func evento3():
	num_options = 2
	$PanelDialogo/DialogoText.text = eventos[3].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		if tem_dado_em_casa() > 50:
			$BarraDeMoral.value += 10
			$PanelDialogo/DialogoText.text = "SUCCESS! You both decide to team up in a rare moment of camaraderie, motivated by your favorite team, and use a little bit of intimidation to secure a few spots ahead in line. Nobody was hurt, except for your honor of course."
			lugar_fila -= 50
			yield (self, "space")
			event_picker()
		else:
			if $BarraDeMoral.value <= 30:
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 30
				yield (self, "space")
				event_picker()
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 15
				yield (self, "space")
				event_picker()
	elif button_pressed == "2":
		if tem_dado_em_casa() > 50:
			$BarraDeMoral.value += 10
			$PanelDialogo/DialogoText.text = "SUCCESS! You both decide to team up in a rare moment of camaraderie, motivated by your favorite team, and use a little bit of intimidation to secure a few spots ahead in line. Nobody was hurt, except for your honor of course."
			lugar_fila -= 50
			yield (self, "space")
			event_picker()
		else:
			if $BarraDeMoral.value <= 30:
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 30
				yield (self, "space")
				event_picker()
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! Oh no, looks like you cheer for the greatest rival of the hooligan’s team. He is really angry and kindly asked you to go back a few spots in line. You kindly comply."
				lugar_fila += 15
				yield (self, "space")
				event_picker()

func evento4():
	num_options = 1
	$PanelDialogo/DialogoText.text = eventos[4].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		if $BarraDeMoral.value <= 30:
			$PanelDialogo/DialogoText.text = "FAILURE! The story was a tad too long and well, you may have slept a little. You wake up a few spots behind in line, and you can spot a sad grandma ahead, that just wanted to tell some stories. You monster."
			var num_pos = randi() % 15 + 5
			lugar_fila += num_pos
			yield(self, "space")
			event_picker()
		else:
			$PanelDialogo/DialogoText.text = "SUCCESS! You are moved to tears with the story. It fills you with joy, and the old nana is grateful for someone listening to her. What a beautiful moment."	
			$BarraDeMoral.value += 5
			yield(self, "space")
			event_picker()

func evento5():
	num_options = 1
	$PanelDialogo/DialogoText.text = eventos[5].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		$PanelDialogo/DialogoText.text = "Business as usual"
		yield(self, "space")
		event_picker()

func evento6():
	num_options = 3
	$PanelDialogo/DialogoText.text = eventos[6].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		$PanelDialogo/DialogoText.text = "GOOD JOB! Like a good citizen, you watched the person's spot untill they returned. They are incredibly grateful."
		$BarraDeMoral.value += 10
		yield(self, "space")
		event_picker()
	if button_pressed == "2":
		$PanelDialogo/DialogoText.text = "FAIR ENOUGH! You're not a line babysitter. Better luck next time random person."
		yield(self, "space")
		event_picker()
	if button_pressed == "3":
		if $BarraDeMoral.value > 30:
			if tem_dado_em_casa() > 20:
				lugar_fila -= 1
				$PanelDialogo/DialogoText.text = "SUCCESS! Booo you took their place in line. They sadly accept it and go to the end of the line. How dare you? "
				yield(self, "space")
				event_picker()
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! You try to be sly about stealing a spot but the person ain't having none of it. You are, justifiably, scolded."
				yield(self, "space")
				event_picker()
		else:
			if tem_dado_em_casa() > 50:
				lugar_fila -= 1
				$PanelDialogo/DialogoText.text = "SUCCESS! Booo you took their place in line. They sadly accept it and go to the end of the line. How dare you? "
				yield(self, "space")
				event_picker()
			else:
				$PanelDialogo/DialogoText.text = "FAILURE! You try to be sly about stealing a spot but the person ain't having none of it. You are, justifiably, scolded."
				yield(self, "space")
				event_picker()

func evento7():
	num_options = 1
	$PanelDialogo/DialogoText.text = eventos[7].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":	
		if $BarraDeMoral.value > 30:
			$PanelDialogo/DialogoText.text = "SUCCESS! You ain't having none of this ridiculous nonsense. You quickly alert the rest of the line, which then joins you in a chorus to stop the line cutter."
			yield(self, "space")
			event_picker()
		else:
			$PanelDialogo/DialogoText.text = "FAILURE! You're too tired to do something about it. Whatever."
			lugar_fila += 1
			yield(self, "space")
			event_picker()

func evento8():
	$PanelDialogo/DialogoText.text = eventos[8].Evento
	lugar_fila -= randi() % 30 + 10
	$BarraDeFome.value -= 5
	$BarraDeMoral.value -= 10
	yield(self, "button1")
	if button_pressed == "1":
		$PanelDialogo/DialogoText.text = "Life is hard."
		$BarraDeMoral.value -= 10
		yield(self, "space")
		event_picker()

func event_picker():
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
	var dado = rand_range(1, 100)
	return dado









func _on_BotaoInicio_pressed():
	event_picker()
	$BotaoInicio.visible = false
	$BotaoInicio/Label.visible = false
	$BotaoInicio/BotaoAudio.play()


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
