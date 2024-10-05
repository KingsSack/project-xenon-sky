extends Node3D

var data

# Called when the node enters the scene tree for the first time.
func _ready():
	query_database("https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+top+100+pl_name,ra,dec,parallax+from+ps&format=json")
	var exoplanet_data = data
	
	query_database("https://gea.esac.esa.int/tap-server/tap/tables/sync?query=select+top+100+designation,ra,dec,parallax+from+gaiadr3.gaia_source+order+by+source_id&format=json")
	var star_data = data

func query_database(url):
	var headers = []  # No headers needed
	
	var response = HTTPRequest.new()
	add_child(response)
	response.connect("request_completed", Callable(self, "_on_query_completed"))
	response.request(url, headers)

func _on_query_completed(_result, response_code, _headers, body):
	print("Raw response code: ", response_code)
	print("Raw body: ", body.get_string_from_utf8())
	
	if response_code == 200:
		var json = JSON.new()
		var json_response = json.parse(body.get_string_from_utf8())
		if json_response == OK:
			data = json_response
		else:
			print("Error parsing JSON: ", json_response)
	else:
		print("Query failed with status: ", response_code)
