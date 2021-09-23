@RestResource(urlMapping='/responser/*')
global class Responser {
    @HttpGet
    global static void doGet() {
        //System.debug(RestContext.request.headers);
        new HTTPResponseHandler().processCallin();
    }
    @HttpPost
    global static void doPost() {
        new HTTPResponseHandler().processCallin();
    }
}