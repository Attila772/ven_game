extends Node

var success = false
var leaderboard
func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")



func http_request(username,time):
	var HTTP = HTTPClient.new()
	var HEADERS = ["User-Agent: Jeff", "Content-Type: application/json"]
	$HTTPRequest.request("http://167.86.96.99:6969/set",["Data:"+str(username)+"_"+str(time)])

func leaderboard():
	$HTTPRequest.request("http://167.86.96.99:6969/leaderboard")

func _on_request_completed(result, response_code, headers, body):
	leaderboard = JSON.parse(body.get_string_from_utf8())
	print(leaderboard.result)
	success = true
