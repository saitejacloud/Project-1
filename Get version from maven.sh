import groovy.json.JsonSlurper

def json = new JsonSlurper().parseText( new URL( 'http api maven').text )
def list = []
json.each { json_obj ->
    list << json_obj.value /name
}
return list