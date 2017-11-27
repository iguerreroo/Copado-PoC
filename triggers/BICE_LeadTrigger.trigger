trigger BICE_LeadTrigger on Lead (before delete, before insert, before update,
                                   after delete,  after insert,  after update){
/** START Add Date to Fecha Solicitud de Creacion and Owner **/
    List<Profile> pUsers = [SELECT Name, Id FROM Profile WHERE Name LIKE '%Banca Persona%'];
    List<Profile> eUsers = [SELECT Name, Id FROM Profile WHERE Name LIKE '%Banca Empresas%' OR Name LIKE '%EYC%'];
    if(Trigger.isBefore && !Trigger.isDelete){
        for(Lead l: Trigger.New){
            if(l.Request_to_Create_Client_Area__c == true){
                 // Check Owner Banca Personas
                Boolean checkP = false;
                for(Profile xP : pUsers){
                    if(l.Owner.ProfileId == xP.Id){
                        checkP = true;
                    }
                }
                if(checkP == true){
                    l.Customer_type_other_rating__c = 'Gerencia Finanzas';
                }
                //Check Owner Banca Empresas or EYC
                Boolean checkE = false;
                for(Profile xP : eUsers){
                    if(l.Owner.ProfileId == xP.Id){
                        checkE = true;
                    }
                }
                if(checkE == true){
                    l.Customer_type_other_rating__c = 'Gerencia Comercial';
                }
                l.Fecha_Solicitud_Crear_Cliente__c = System.today();
            }
        }
    }
/** END Add Date to Fecha Solicitud de Creacion **/
/* START Check Comuna */
    if(Trigger.isBefore && !Trigger.isDelete){
        Set<ID> ccomIds = new Set<ID>();
        List<Comuna__c> comunas = new List<Comuna__c>();
        List<Lead> lactualizar = new List<Lead>();
        for(Lead l: Trigger.New){
            if(l.Comuna_comercial__c != null){
                ccomIds.add(l.Comuna_comercial__c);
            //}else if(l.Pais_comercial__c == 'Chile'){
                l.Region_comercial__c = '';
                l.Ciudad_comercial__c = '';
                //l.Pais_comercial__c = '';
                lactualizar.add(l);
            }else{
                l.Region_comercial__c = '';
                lactualizar.add(l);
            }
            if(l.Comuna_particular__c != null){
                ccomIds.add(l.Comuna_particular__c);
            //}else if(l.Pais_particular__c == 'Chile'){
                l.Region_particular__c = '';
                l.Ciudad_particular__c = '';
                //l.Pais_particular__c = '';
                lactualizar.add(l);
            }else{
                l.Region_particular__c = '';
                lactualizar.add(l);
            }
        }
        comunas = [SELECT Id, GLS_CIUDAD__c, COD_CIUDAD__c, COD_COMUNA__c, COD_REGION__c, Pais__c, GLS_REGIONLARGA__c FROM Comuna__c WHERE Id IN:ccomIds];
        for(Lead l : Trigger.New){
            for(Comuna__c c : comunas){
                if(l.Comuna_comercial__c == c.Id){
                    l.Region_comercial__c = c.GLS_REGIONLARGA__c;
                    l.Ciudad_comercial__c = c.GLS_CIUDAD__c;
                    //l.Pais_comercial__c = c.Pais__c;
                    lactualizar.add(l);
                }
                if(l.Comuna_particular__c == c.Id){
                    l.Region_particular__c = c.GLS_REGIONLARGA__c;
                    l.Ciudad_particular__c = c.GLS_CIUDAD__c;
                    //l.Pais_particular__c = c.Pais__c;
                }
            }
        }
    }
/* END Check Comuna */
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
/** START Aviso Jefe Plataforma **/
        RecordType[] rc = [Select Id 
                           FROM RecordType 
                           WHERE Name='Lead Persona Jurídica (Fuerza Ventas)' 
                            OR Name ='Lead Persona Natural (Fuerza de Ventas)'];
        Set<Id> recordIds = new Set<Id>();
        for(RecordType r : rc){
            recordIds.add(r.Id);
        }
        for(Lead le: Trigger.New){
            // system.debug('QueryRc' + recordIds);
            // Database.DmlOptions options = new Database.DmlOptions();
            if(recordIds.contains(le.RecordTypeId) && le.Etapa__c == 'Aprobacion_Agente' && le.Aviso_email_de_cambio_de_propietario_env__c == false){
                // system.debug('HOLA');
                le.OwnerId = le.Jefe_Plataforma_Agente_Sucursal__c;
                le.Aviso_email_de_cambio_de_propietario_env__c = true; 
                system.debug('Datos' + le.Correo_Jefe_Plataforma_Agente_Sucursal__c +' '+ le.Id+' '+ le.Nombre_completo__c);
                // options.emailHeader.triggerUserEmail = true;
                enviarCorreo(le.Correo_Jefe_Plataforma_Agente_Sucursal__c, le.Id, le.Nombre_completo__c); //
            }
            // le.setOptions(options);
        }
/** END Aviso Jefe Plataforma **/
/** START Check Lead **/
        //for(Lead le: trigger.new){
        String IdActual = UserInfo.getUserId();
        String nombrert = 'Lead Empresas y Corporaciones';
        Integer lim = 50;
        List<Lead> leads = [SELECT Name, RecordTypeId, RecordType.Name FROM Lead WHERE RecordTypeId in (SELECT Id FROM RecordType WHERE Name =: nombrert) AND RecordTypeId <> ''];
        Set<ID> rtIds = new Set<ID>();
        for(Lead ll : leads){
            //System.debug('El record type de '+ll.Name+' es : '+ll.RecordType.Name);
            if(ll.RecordType.Name == nombrert){
                rtIds.add(ll.RecordTypeId);
                //System.debug('El RecordTypeId de '+ll.RecordType.Name+' es : '+rtid);
            }
        }
        List<Lead> lids = [SELECT Id, Name FROM Lead WHERE OwnerId =: IdActual AND RecordTypeId IN: rtIds AND IsConverted = FALSE AND Status != 'No califica'];
        if(lids.size() >= lim){
            for(Lead le : Trigger.new){
                le.addError('No puedes tener más de '+lim+' leads');
            }
        }
        //}
/** END Check Lead **/
    }else if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
/** START Convert Lead On Check *
        for(Lead le : trigger.new){
            if(le.IsConverted){
                System.debug('El lead ya ha sido convertido');
            }else{
                if(le.Convertir__c){ 
                    //invoco a la clase y el método
                    CustomLeadConversion conversion = new CustomLeadConversion();
                    conversion.MyLeadConversion(le.id, le.FirstName, le.LastName);
                    System.debug('El lead fue convertido');
                    System.debug('Aquí debo redireccionar... trabajando en esto');
                    //aqui debo redireccionar una vez que se haya convertido
                }else{
                    System.debug('El lead no fue convertido');
                }    
            }
        }
/** END Convert Lead On Check **/
    }
/** START enviarCorreo **/
    public void enviarCorreo(String correoAgente, Id IdLead, String NombreCandidato){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String emailAddr = correoAgente;
        String urlLead = URL.getSalesforceBaseUrl().toExternalForm() + '/' + IdLead;
        String[] toAddresses = new String[] {emailAddr} ;
        mail.setToAddresses(toAddresses);
        mail.Setsubject('Candidato: Se le ha asignado '+NombreCandidato);
        mail.SetplainTextBody('Candidato: '+NombreCandidato+' se le ha asignado.'+'\n\n'
        +'Para ver los detalles de este candidato en salesforce haga clic en el siguiente vínculo: '+ urlLead);
        if(!Test.isRunningTest()){
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
/** END enviarCorreo **/
}