//create a mock class called AnimalLocatorMock to mock the callout response. response format is {animal={eats=chicken food, id=1, name=chicken, says=cluck cluck}}
@isTest
public class AnimalLocatorMock implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"animal":{"eats":"chicken food", "id":1, "name":"chicken", "says":"cluck cluck"}}');
        res.setStatusCode(200);
        return res;
    }
}