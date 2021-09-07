@RestResource(urlMapping='/responser/*')
global class Responser {
    @HttpGet
    global static void doGet() {
        new HTTPResponseHandler().processCallin();
    }
}