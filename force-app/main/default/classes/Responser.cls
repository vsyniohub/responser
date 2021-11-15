@RestResource(urlMapping='/responser/*')
global class Responser {
    @HttpGet
    global static void doGet() {
        new HTTPResponseService(HTTPResponseService.GET_STRING).processCallin();
    }
    @HttpPost
    global static void doPost() {
        new HTTPResponseService(HTTPResponseService.GET_STRING).processCallin();
    }
}