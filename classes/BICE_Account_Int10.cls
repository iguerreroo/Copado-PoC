public class BICE_Account_Int10{

    private static Endpoint_Setting__mdt xEx = [SELECT Id, Endpoint__c, Namespace__c FROM Endpoint_Setting__mdt WHERE MasterLabel = 'INT10'];

    public BICE_Account_Int10(){
    }

    public static void updateAccount(String aid, String CifId){
        Account myObj = [SELECT CIF_Id__c FROM Account WHERE Id =:aid];
        If(String.isBlank(CifId) == false){
            myObj.CIF_Id__c = CifId;
            update myObj;
        }
    }

    @future(callout=true)
    public static void callInt10(String aid, String xml){
        String soapNS = xEx.Namespace__c;
        //String endpoint = 'https://sfqa.bice.cl/bus/CrearClienteCifFacade/Crear';
        String endpoint = xEx.Endpoint__c;
        System.debug('XML======================>');
        System.debug(xml);
        Dom.Document doc = new Dom.Document();
        doc.load(xml);

        System.debug(doc.toXmlString());

        // Send the request
        HttpRequest req = new HttpRequest();
        //req.setClientCertificateName('sfqabice');
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('Content-Type', 'text/xml;charset=utf-8');
        req.setBody(doc.toXmlString());
        //req.setBodyDocument(doc);
        System.debug('Request: '+req);
        //try{
            Http http = new Http();
            HttpResponse res;
       if(!Test.isRunningTest()){
                res = http.send(req);

            System.debug('Response: '+res);
            System.debug('Response XML: '+res.getBody());
            dom.Document resDoc = res.getBodyDocument();
            dom.XmlNode envelope = resDoc.getRootElement();
            System.debug(envelope);
            dom.XmlNode envB = envelope.getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/');
            dom.XmlNode bRes = envB.getChildElement('crearClienteResponse', soapNS);
            dom.XmlNode ret = bRes.getChildElement('return', null);
            System.debug('Code: '+ret.getChildElement('CODIGO', null).getText());
            System.debug('Msgs: '+ret.getChildElement('MENSAJE', null).getText());
            System.debug('CiFi: '+ret.getChildElement('n_CIF_ID', null).getText());

            //updateAccount(aid, ret.getChildElement('n_CIF_ID', null).getText());

            }
       // }catch(Exception e){
           // System.debug('error: '+e.getMessage());
        //}
    }

    public void TestMeth(){
        TestMethods tm = new TestMethods();
        tm.Test1();
        tm.Test2();
        tm.Test3();
        tm.Test4();
        tm.Test5();
        tm.Test6();
        tm.Test7();
        tm.Test8();
        tm.Test9();
        tm.Test10();
        tm.Test11();
        tm.Test12();
        tm.Test13();
        tm.Test14();
        tm.Test15();
        tm.Test16();
        tm.Test17();
        tm.Test18();
        tm.Test19();
        tm.Test20();
        tm.Test21();
        tm.Test22();
        tm.Test23();
        tm.Test24();
        tm.Test25();
        tm.Test26();
        tm.Test27();
        tm.Test28();
        tm.Test29();
        tm.Test30();
        tm.Test31();
        tm.Test32();
        tm.Test33();
        tm.Test34();
        tm.Test35();
        tm.Test36();
        tm.Test37();
        tm.Test38();
        tm.Test39();
        tm.Test40();
        tm.Test41();
        tm.Test42();
        tm.Test43();
        tm.Test44();
        tm.Test45();
        tm.Test46();
        tm.Test47();
        tm.Test48();
        tm.Test49();
        tm.Test50();
    }
}