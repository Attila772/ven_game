extends Node



func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	var jstr = JSON.print({"faszparaszt":"200"})
	var HTTP = HTTPClient.new()
	var HEADERS = ["User-Agent: Jeff", "Content-Type: application/json"]
	$HTTPRequest.request("http://127.0.0.1:5000/set",["Fasz:pure;Segg:Fasz"])


	

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
