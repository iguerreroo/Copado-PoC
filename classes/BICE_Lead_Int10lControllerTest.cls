@isTest(seealldata=true)
public class BICE_Lead_Int10lControllerTest{
    

    
    public static testMethod void testMyController() {
        Comuna__c c = [SELECT Id FROM Comuna__c WHERE Name = 'SANTIAGO' LIMIT 1];
        User u = [SELECT Id, Name FROM User WHERE Name = 'SAMUEL BRAVO' LIMIT 1];
        System.runAs(u) {
            RecordType rPN = [SELECT Id, Name FROM RecordType WHERE Name LIKE '%Persona Natural%' LIMIT 1];
            RecordType rPJ = [SELECT Id, Name FROM RecordType WHERE Name LIKE '%Persona Jur%' LIMIT 1];
            Lead l = new Lead();
            l.Sucursal_de_Apertura_del__c = 'Apoquindo';
            l.Rut__c = '70123130-9';
            l.Customer_type_other_rating__c = '';
            l.Sub_Sector_Economico__c = '';
            l.Actividad_Economica_SBIF__c = ''; 
            l.SBIF_Sector__c = '';
            l.LastName = 'Apellido Paterno1';
            l.Apellido_Materno__c = 'Apellido Materno1';
            l.FirstName = 'Nombre1';
            l.Nationality__c = 'Chile';
            l.Profession__c = 'ACTOR';
            l.Birth_Date__c = null;
            l.Sex__c = 'Male';
            l.Educational_Level__c = 'Basico';
            l.Estado_civil__c = 'Soltero';
            l.Raz_n_Social__c = 'RAZON SOCIAL';
            l.Socios_de_la_empresa_grupo_econ_mico__c = '';
            l.BICE_Classification__c = '';
            l.Calle_Particular__c = 'Teatinos';
            l.Comuna_Particular__c = c.Id;
            l.Region_Particular__c = 'Region Metropolitana';
            l.Ciudad_Particular__c = 'SANTIAGO';
            l.Pais_particular__c = 'Chile';
            l.Numero_particular__c = '1212';
            l.Calle_Comercial__c = 'Teatinos';
            l.Comuna_Comercial__c = c.Id;
            l.Region_Comercial__c = 'Region Metropolitana';
            l.Ciudad_Comercial__c = 'SANTIAGO';
            l.Pais_comercial__c = 'Chile';
            l.Numero_comercial__c  = '12321';
            l.Phone = '+56912312312';
            l.MobilePhone= '+56912312312';
            l.Commercial_Cellphone__c= '+56912312312';
            l.Commercial_Phone_Other__c= '+56912312312';
            l.Particular_Phone_Other__c= '+56912312312';
            l.Phone_contact__c= '+56912312312';
            l.Fax= '+56912312312';
            l.Email = 'test@test.cl';
            l.Commercial_Email__c = 'test@test.cl';
            l.Website = 'http://www.test.cl';
            l.RecordTypeId = rPN.Id;
            insert l;
            ApexPages.StandardController sc = new ApexPages.standardController(l);
            BICE_Lead_Int10lController ext = new BICE_Lead_Int10lController(sc);
            System.assertEquals(ext.lid, l.id);
            ext.callInt10L();
            ext.updateLead('142');
            ext.Redireccionar();
            
            Lead l2 = new Lead();
            l2.Sucursal_de_Apertura_del__c = 'Apoquindo';
            l2.Rut__c = '70123129-5';
            l2.Customer_type_other_rating__c = '';
            l2.Sub_Sector_Economico__c = '';
            l2.Actividad_Economica_SBIF__c = ''; 
            l2.SBIF_Sector__c = '';
            l2.LastName = 'Apellido Paterno2';
            l2.Apellido_Materno__c = 'Apellido Materno2';
            l2.FirstName = 'Nombre2';
            l2.Nationality__c = 'Chile';
            l2.Profession__c = 'ACTOR';
            l2.Birth_Date__c = null;
            l2.Sex__c = 'Male';
            l2.Educational_Level__c = 'Basico';
            l2.Estado_civil__c = 'Soltero';
            l2.Raz_n_Social__c = 'RAZON SOCIAL2';
            l2.Socios_de_la_empresa_grupo_econ_mico__c = '';
            l2.BICE_Classification__c = '';
            l2.Calle_Particular__c = 'Teatinos';
            l2.Comuna_Particular__c = c.Id;
            l2.Region_Particular__c = 'Region Metropolitana';
            l2.Ciudad_Particular__c = 'SANTIAGO';
            l2.Pais_particular__c = 'Chile';
            l2.Numero_particular__c = '1212';
            l2.Calle_Comercial__c = 'Teatinos';
            l2.Comuna_Comercial__c = c.Id;
            l2.Region_Comercial__c = 'Region Metropolitana';
            l2.Ciudad_Comercial__c = 'SANTIAGO';
            l2.Pais_comercial__c = 'Chile';
            l2.Numero_comercial__c  = '12321';
            l2.Phone = '+56912312312';
            l2.MobilePhone= '+56912312312';
            l2.Commercial_Cellphone__c= '+56912312312';
            l2.Commercial_Phone_Other__c= '+56912312312';
            l2.Particular_Phone_Other__c= '+56912312312';
            l2.Phone_contact__c= '+56912312312';
            l2.Fax= '+56912312312';
            l2.Email = 'test1@test.cl';
            l2.Commercial_Email__c = 'test1@test.cl';
            l2.Commercial_FAX_Other__c=  '+56912312312';
            l2.Commercial_Landline__c =  '+56912312312';
            l2.Website = 'http://www.test.cl';
            l2.RecordTypeId = rPJ.Id;
            insert l2;
            ApexPages.StandardController sc2 = new ApexPages.standardController(l2);
            ext = new BICE_Lead_Int10lController(sc2);
            System.assertEquals(ext.lid, l2.id);
            ext.callInt10L();
            ext.updateLead('123');
            ext.Redireccionar();
            
            
            l2 = new Lead();
            l2.Sucursal_de_Apertura_del__c = 'Apoquindo';
            l2.Rut__c = '10085221-7';
            l2.Customer_type_other_rating__c = '';
            l2.Sub_Sector_Economico__c = '';
            l2.Actividad_Economica_SBIF__c = ''; 
            l2.SBIF_Sector__c = '';
            l2.LastName = 'Apellido Paterno6';
            l2.Apellido_Materno__c = 'Apellido Materno7';
            l2.FirstName = 'Nombre8';
            l2.Nationality__c = 'Chile';
            l2.Profession__c = 'ACTOR';
            l2.Birth_Date__c = null;
            l2.Sex__c = 'Male';
            l2.Educational_Level__c = 'Basico';
            l2.Estado_civil__c = 'Soltero';
            l2.Raz_n_Social__c = 'RAZON SOCIAL5';
            l2.Socios_de_la_empresa_grupo_econ_mico__c = '';
            l2.BICE_Classification__c = '';
            l2.Calle_Particular__c = 'Teatinos';
            l2.Comuna_Particular__c = c.Id;
            l2.Region_Particular__c = 'Region Metropolitana';
            l2.Ciudad_Particular__c = 'SANTIAGO';
            l2.Pais_particular__c = 'Chile';
            l2.Numero_particular__c = '1212';
            l2.Calle_Comercial__c = 'Teatinos';
            l2.Comuna_Comercial__c = c.Id;
            l2.Region_Comercial__c = 'Region Metropolitana';
            l2.Ciudad_Comercial__c = 'SANTIAGO';
            l2.Pais_comercial__c = 'Chile';
            l2.Numero_comercial__c  = '12321';
            l2.Phone = '+56912312312';
            l2.MobilePhone= '+56912312312';
            l2.Commercial_Cellphone__c= '+56912312312';
            l2.Commercial_Phone_Other__c= '+56912312312';
            l2.Particular_Phone_Other__c= '+56912312312';
            l2.Phone_contact__c= '+56912312312';
            l2.Fax= '+56912312312';
            l2.Email = 'test4@test.cl';
            l2.Commercial_Email__c = 'test5@test.cl';
            l2.Commercial_FAX_Other__c=  '+56912312312';
            l2.Commercial_Landline__c =  '+56912312312';
            l2.Website = 'http://www.test.cl';
            insert l2;
        }
    }
    
}
    

        
        /*Comuna__c c = [SELECT Id FROM Comuna__c WHERE Name = 'SANTIAGO' LIMIT 1];
        Lead l = new Lead();
        l.Rut__c = '18126170-6';
        l.FirstName = 'Nombre1';
        l.LastName = 'Apellido Paterno';
        l.Apellido_Materno__c = 'Apellido Materno';
        l.Calle_Particular__c = 'Teatinos';
        l.Comuna_Particular__c = c.Id;
        l.Region_Particular__c = 'Region Metropolitana';
        l.Ciudad_Particular__c = 'SANTIAGO';
        l.Pais_particular__c = 'Chile';
        l.Phone = '+56912312312';
        l.Email = 'test2@test.cl';
        insert l;
        ApexPages.StandardController sc = new ApexPages.standardController(l);
        BICE_Lead_Int10lController ext = new BICE_Lead_Int10lController(sc);
        System.assertEquals(ext.lid, l.id);
        ext.callInt10L();
        ext.updateLead('142');
        ext.Redireccionar();
        
        Lead l2 = new Lead();
        l2.Rut__c = '11114936-4';
        l2.FirstName = 'Nombre2';
        l2.LastName = 'Apellido Paterno3';
        l2.Apellido_Materno__c = 'Apellido Materno4';
        l2.Calle_Particular__c = 'Teatinos';
        l2.Comuna_Particular__c = c.Id;
        l2.Region_Particular__c = 'Region Metropolitana';
        l2.Ciudad_Particular__c = 'SANTIAGO';
        l2.Pais_particular__c = 'Chile';
        l2.Phone = '+56912312312';
        l2.Email = 'test@test.cl';
        insert l2;
        ApexPages.StandardController sc2 = new ApexPages.standardController(l2);
        ext = new BICE_Lead_Int10lController(sc2);
        System.assertEquals(ext.lid, l2.id);
        ext.callInt10L();
        ext.updateLead('123');
        ext.Redireccionar();*/