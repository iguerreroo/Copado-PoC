global class BICE_LeadCTControllerExtension{
    public Lead tObj{get;set;}
    public String urlToRedirect{get;set;}
    public BICE_LeadCTControllerExtension(ApexPages.StandardController controller){
        this.tObj = (Lead)controller.getRecord();
    }
    public PageReference checkComplianceTracker(){
        Lead myObj = [SELECT Rut__c, Raz_n_Social__c, Company, FirstName, LastName, Apellido_materno__c, Nationality__c, CT_Result_Code__c, CT_Request_Date__c, CT_Request_Code__c FROM Lead WHERE Id =:this.tObj.Id];
        // Create the stub
        BICE_ComplianceTrackerWS.ComplianceTrackerSoapQSPort wservice = new BICE_ComplianceTrackerWS.ComplianceTrackerSoapQSPort();
        // Set the response var
        BICE_ComplianceTrackerWS.searchResponse_element response = new BICE_ComplianceTrackerWS.searchResponse_element();
        //Make the call
        String rCode;
        rCode = '0';
        try{            
            if(myObj.CT_Request_Code__c != null){
                rCode = myObj.CT_Request_Code__c;
            }
            if(myObj.Company != null){
                response = wservice.search_x(61, //id_usys
                                         myObj.RUT__c, //idemp
                                         myObj.Raz_n_Social__c, //nombres
                                         '', //apellidos
                                         myObj.Nationality__c, //nacionalidad
                                         '0', //tipo
                                         0, //estatus
                                         0, //autorizado
                                         Integer.valueOf(rCode), //id_requestws
                                         0, //id_emp
                                         '0'); //source
            }else{
                response = wservice.search_x(61, //id_usys
                                         myObj.RUT__c, //idemp
                                         myObj.FirstName, //nombres
                                         myObj.LastName+' '+myObj.Apellido_materno__c, //apellidos
                                         myObj.Nationality__c, //nacionalidad
                                         '0', //tipo
                                         0, //estatus
                                         0, //autorizado
                                         Integer.valueOf(rCode), //id_requestws
                                         0, //id_emp
                                         '0'); //source
            }
            System.debug('Response: '+response);
            System.debug('Autorizado = '+response.autorizado);
            System.debug('Status = '+response.estatus);
            myObj.CT_Request_Code__c = String.valueOf(response.id_requestws);
            myObj.CT_Result_Code__c = response.estatus;
            myObj.CT_Request_Date__c = System.today();
            try{
                update myObj;
            }catch(Exception e){
                System.debug('Exception updating lead: '+e.getMessage());
            }
        }catch(Exception e){
            System.debug('Exception getting response: '+e.getMessage());
        }
        urlToRedirect = '/apex/BICE_IntOnline_Redirect';
        PageReference myVFPage = new PageReference(urlToRedirect);
        myVFPage.getParameters().put('LID',this.tObj.Id);
        myVFPage.getParameters().put('msg','Completando validacion...');
        myVFPage.setRedirect(true);
        return myVFPage;
    }
}