public with sharing class AnimalLocator {
    public static String getAnimalNameById(Integer id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //The method must call https://th-apex-http-callout.herokuapp.com/animals/<id>, replacing <id> with the ID passed into the method 
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        // The method returns the value of the name property (i.e., the animal name)
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // Deserialize the JSON string into collections of primitive data types.
        Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        Map<String, Object> animal = (Map<String, Object>)result.get('animal');
        System.debug(result);
        System.debug('name: '+String.valueOf(animal.get('name')));
		return String.valueOf(animal.get('name'));
    }
}