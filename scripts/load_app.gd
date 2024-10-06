extends Node3D

var button_scene := preload("res://load_planet_button.tscn")

var star_scene := preload("res://star.tscn")

var exoplanets = {}
var stars = {}

signal exoplanet_data_loaded(data)
signal star_data_loaded(data)

func _ready():
	Global.exoplanet_changed.connect(_on_load_exoplanet)
	query_database("https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=SELECT+top+10+pl_name,ra,dec,sy_plx+FROM+ps+ORDER+BY+pl_name&format=json", "exoplanets")
	query_database("https://gea.esac.esa.int/tap-server/tap/sync?request=doQuery&lang=ADQL&query=SELECT+TOP+25+designation,ra,dec,parallax+FROM+gaiadr3.gaia_source+WHERE+parallax+IS+NOT+NULL+ORDER+BY+source_id&format=json", "stars")

func query_database(url, key):
	var headers = []
	var response = HTTPRequest.new()
	add_child(response)
	response.connect("request_completed", Callable(self, "_on_query_completed").bind(key))
	response.request(url, headers)

func _on_query_completed(_result, response_code, _headers, body, key):
	# print("Raw body: ", body.get_string_from_utf8())
	if response_code == 200:
		var json = JSON.new()
		var decoded_body = body.get_string_from_utf8()
		var error = json.parse(decoded_body)
		if error == OK:
			# print("Successfully parsed JSON: ", json.data)
			if key == "exoplanets":
				exoplanet_data_loaded.emit(json.data)
			elif key == "stars":
				star_data_loaded.emit(json.data)
		else:
			print("Error parsing JSON: ", error)
	else:
		print("Query failed with status: ", response_code)

func _on_exoplanet_data_loaded(data):
	for exoplanet in data:
		create_exoplanet_button(exoplanet["pl_name"])
		exoplanets[exoplanet["pl_name"]] = [exoplanet["ra"], exoplanet["dec"], exoplanet["sy_plx"]]
		# print("Exoplanet: ", exoplanet["pl_name"], " at (", exoplanet["ra"], ", ", exoplanet["dec"], ") with parallax: ", exoplanet["sy_plx"])

func _on_star_data_loaded(data):
	for star in data["data"]:
		stars[star[0]] = [star[1], star[2], star[3]]
		# print("Star: ", star[0], " at (", star[1], ", ", star[2], ") with parallax: ", star[3])

func create_exoplanet_button(planet_name):
	var button_instance = button_scene.instantiate()
	button_instance.text = planet_name
	$CanvasLayer/Control/ScrollContainer/VBoxContainer.add_child(button_instance)

func get_pos(ra, dec, parallax):
	var x = cos(dec) * cos(ra)/tan(parallax)
	var y = cos(dec) * sin(ra)/tan(parallax)
	var z = sin(dec)/tan(parallax)
	return Vector3(x,y,z)

func _on_load_exoplanet(planet_name):
	var pos = get_pos(exoplanets[planet_name][0], exoplanets[planet_name][1], exoplanets[planet_name][2])
	# print("Loading exoplanet: ", planet_name, " at ", pos)

	for child in $Node.get_children():
		child.queue_free()

	for star in stars:
		var star_pos = get_pos(stars[star][0], stars[star][1], stars[star][2])
		var new_star_scene = star_scene.instantiate()
		star_pos -= pos
		star_pos *= 10
		new_star_scene.translate(star_pos)
		
		$Node.add_child(new_star_scene)
		# print("Star: ", star, " at ", star_pos, " is close to exoplanet: ", planet_name, " at ", pos)
