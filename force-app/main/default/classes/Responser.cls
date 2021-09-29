@RestResource(urlMapping='/responser/*')
global class Responser {
    @HttpGet
    global static void doGet() {
        new HTTPResponseHandler().processCallin();
    }
    @HttpPost
    global static void doPost() {
        RestContext.response.responseBody = Blob.valueOf('{"response": "some"}');
    }
}