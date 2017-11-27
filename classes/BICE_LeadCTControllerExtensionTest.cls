@isTest
public class BICE_LeadCTControllerExtensionTest {

    public static testMethod void testMyController() {
        Lead l = new Lead();
        l.FirstName = 'Nombre';
        l.LastName = 'Apellido';
        l.Phone = '+5699999999';
        l.Nationality__c = 'Chile';
        insert l;
        ApexPages.StandardController sc = new ApexPages.standardController(l);
        BICE_LeadCTControllerExtension ext = new BICE_LeadCTControllerExtension(sc);
        System.assertEquals(ext.tObj, l);
        PageReference page = ext.checkComplianceTracker();
        
        
        Lead l2 = new Lead();
        l2.Company = 'Mi Empresa';
        l2.Raz_n_Social__c = '11121231-1';
        l2.FirstName = 'Nombre';
        l2.LastName = 'Apellido';
        l2.Phone = '+5699999999';
        l2.Nationality__c = 'Chile';
        insert l2;
        ApexPages.StandardController sc2 = new ApexPages.standardController(l2);
        ext = new BICE_LeadCTControllerExtension(sc2);
        System.assertEquals(ext.tObj, l2);
        page = ext.checkComplianceTracker();
    }
}