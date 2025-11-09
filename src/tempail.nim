import asyncdispatch, httpclient, json

const api = "https://tempail.top/api"
var headers = newHttpHeaders({
  "Connection": "keep-alive", 
  "Host": "tempail.top",
  "Content-Type": "application/json", 
  "accept": "application/json", 
  "user-agent": "Dalvik/2.1.0 (Linux; U; Android 7.1.2; SM-G965N Build/QP1A.190711.020)"
})
var token=""
proc create_email*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.post(api & "/email/create/ApiTempail",body="")
    let body = await response.body
    let json = parseJson(body)
    token = json["data"]["email_token"].getStr()
    result = json
  finally:
    client.close()

proc get_messages*(emailtoken:string=""): Future[JsonNode] {.async.} =
  if token=="":token=emailtoken
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/messages/" & token & "/messages")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
