extends Node3D

var loading_scene := preload("res://scenes/loading_screen.tscn")
var loading

var button_scene := preload("res://scenes/load_planet_button.tscn")

var star_scene := preload("res://scenes/star.tscn")
var star_button_scene := preload("res://scenes/star_button.tscn")

var exoplanets = {}
var exoplanet_mass = {}

var stars = {}

var max_exoplanet_data := 80
var exoplanet_data_recieved := 0
@onready var max_star_data = Global.max_stars
var star_data_recieved := 0

signal exoplanet_data_loaded(data)
signal star_data_loaded(data)

func _ready():
	loading = loading_scene.instantiate()
	$CanvasLayer.add_child(loading)
	Global.exoplanet_changed.connect(_on_load_exoplanet)
	query_database("https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=SELECT+TOP+80+pl_name,ra,dec,sy_plx,pl_masse+FROM+ps+WHERE+pl_masse+IS+NOT+NULL+ORDER+BY+pl_name&format=json", "exoplanets")
	query_database("https://gea.esac.esa.int/tap-server/tap/sync?request=doQuery&lang=ADQL&query=SELECT+TOP+50+designation,ra,dec,parallax+FROM+gaiadr3.gaia_source+WHERE+parallax>0+ORDER+BY+parallax&format=json", "stars")

# begins a table access proticol query
func query_database(url, key):
	var headers = []
	var request = HTTPRequest.new()
	request.request_completed.connect(self._on_query_completed.bind(key, url))
	self.add_child(request)
	request.request(url, headers)

func _on_query_completed(_result, response_code, _headers, body, key, url):
	if response_code == 200:
		var json = JSON.new()
		var error = json.parse(body.get_string_from_utf8())
		if error == OK:
			if key == "exoplanets":
				exoplanet_data_loaded.emit(json.data)
			elif key == "stars":
				star_data_loaded.emit(json.data)
		else:
			print("Error parsing JSON: ", error)
	elif response_code == 0:
		print("Query failed with status 0, retrying...")
		query_database(url, key)
	else:
		print("Query failed with status: ", response_code)
	
	if exoplanet_data_recieved + star_data_recieved >= max_exoplanet_data + max_star_data:
		$CanvasLayer.remove_child(loading)

# executes after query for exoplanets
func _on_exoplanet_data_loaded(data):
	for exoplanet in data:
		create_exoplanet_button(exoplanet["pl_name"])
		exoplanets[exoplanet["pl_name"]] = [exoplanet["ra"], exoplanet["dec"], exoplanet["sy_plx"]]
		exoplanet_mass[exoplanet["pl_name"]] = exoplanet["pl_masse"]
		# print("Exoplanet: ", exoplanet["pl_name"], " at (", exoplanet["ra"], ", ", exoplanet["dec"], ") with parallax: ", exoplanet["sy_plx"])
		exoplanet_data_recieved += 1
	
	print("Loaded ", len(exoplanets), " exoplanets")

# executes after query for stars
func _on_star_data_loaded(data):
	var max_para
	for star in data["data"]:
		stars[star[0]] = get_pos(star[1], star[2], star[3])
		# print("Star: ", star[0], " at (", star[1], ", ", star[2], ") with parallax: ", star[3])
		max_para = star[3]
		star_data_recieved += 1
	
	print("Loaded ", len(stars), " stars")
	
	if (len(stars) < max_star_data):
		query_database("https://gea.esac.esa.int/tap-server/tap/sync?request=doQuery&lang=ADQL&query=SELECT+TOP+50+designation,ra,dec,parallax+FROM+gaiadr3.gaia_source+WHERE+parallax>"+str(max_para)+"+ORDER+BY+parallax&format=json", "stars")

func create_exoplanet_button(planet_name):
	var button_instance = button_scene.instantiate()
	button_instance.text = planet_name
	$CanvasLayer/Control/ScrollContainer/VBoxContainer.add_child(button_instance)

# math for possition based on earth
func get_pos(ra, dec, parallax):
	# real:
	var x = cos(deg_to_rad(dec)) * cos(deg_to_rad(ra))/tan(parallax)
	var y = cos(deg_to_rad(dec)) * sin(deg_to_rad(ra))/tan(parallax)
	var z = sin(deg_to_rad(dec))/tan(parallax)
	return Vector3(x, y, z)

# outside of main loading script so it can be acessed by reload
var pos

# instanciates the scene whenever the exoplanet is switched
func _on_load_exoplanet(planet_name):
	pos = get_pos(exoplanets[planet_name][0], exoplanets[planet_name][1], exoplanets[planet_name][2])
	
	$CanvasLayer/Control/Label2.change_info(exoplanet_mass[planet_name])
	
	print("Loading exoplanet: ", planet_name, " at ", pos)

	for child in $Stars.get_children():
		child.queue_free()

	for child in $CanvasLayer/Control/Control.get_children():
		child.queue_free()
	
	for child in $Constelations.get_children():
		child.queue_free()

	for star in stars:
		var star_pos = stars[star]
		star_pos -= pos
		star_pos /= 10000
		if (true): # (star_pos.length() < 100):
			var new_star_scene = star_scene.instantiate()
			new_star_scene.star_name = star
			new_star_scene.translate(star_pos)
			$Stars.add_child(new_star_scene)
			
			var new_star_button_scene = star_button_scene.instantiate()
			new_star_button_scene.star = new_star_scene
			$CanvasLayer/Control/Control.add_child(new_star_button_scene)
		# print("Star: ", star, " at ", star_pos, " is close to exoplanet: ", planet_name, " at ", pos)

# instanciates scene without switching exoplanets
func reload():
	for star in stars:
		
		print("reloading")

		for child in $Node.get_children():
			child.queue_free()

		for child in $CanvasLayer/Control/Control.get_children():
			child.queue_free()
			
		if (typeof(pos) == TYPE_INT):
			var star_pos = stars[star]
			star_pos -= pos
			star_pos /= 10000
			if (true): # (star_pos.length()<100):
				var new_star_scene = star_scene.instantiate()
				new_star_scene.translate(star_pos)
				$Node.add_child(new_star_scene)
				
				var new_star_button_scene = star_button_scene.instantiate()
				new_star_button_scene.star = new_star_scene
				$CanvasLayer/Control/Control.add_child(new_star_button_scene)
			# print("Star: ", star, " at ", star_pos, " is close to exoplanet: ", planet_name, " at ", pos)
