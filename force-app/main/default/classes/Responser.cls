@RestResource(urlMapping='/responser/*')
global class Responser {
    /* *********************************************
    ** Method Name: doGet
    ** Description: Handles logic for Responser's GET
    ** Parameters: 
    ** Returns: void
    ** ********************************************* */   
    @HttpGet
    global static void doGet() {
        new HTTPResponseHandler(HTTPResponseHandler.GET_STRING).processCallin();
    }
    /* *********************************************
    ** Method Name: doGet
    ** Description: Handles logic for Responser's GET
    ** Parameters: 
    ** Returns: void
    ** ********************************************* */   
    @HttpPost
    global static void doPost() {
        new HTTPResponseHandler(HTTPResponseHandler.GET_STRING).processCallin();
    }
}