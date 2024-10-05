extends Node3D

func _ready():
	var url = "https://gea.esac.esa.int/tap-server/tap/tables/sync?query=select+top+100+designation,ra,dec+from+gaiadr3.gaia_source+order+by+source_id&format=json"
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
			print(json_response)
		else:
			print("Error parsing JSON: ", json_response)
	else:
		print("Query failed with status: ", response_code)
