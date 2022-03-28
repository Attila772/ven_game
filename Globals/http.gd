extends Node



func _ready():
	var jstr = JSON.print({"faszparaszt":"200"})
	var HTTP = HTTPClient.new()
	var HEADERS = ["User-Agent: Jeff", "Content-Type: application/json"]
	print("eeee")
	var RESPONSE = HTTP.request(HTTPClient.METHOD_POST, "http://127.0.0.1:5000/set", HEADERS, jstr)
	print(RESPONSE)
	pass
