public class BICE_Lead_Int10lController{
    public String lid {get;set;}
    public Lead myLead;
    public String tipoPersona;
    public String COD_CANAL;
    public String GLOSA_APLICACION;
    public String COD_SUCURSAL;
    public String COD_OPERADOR;
    public String TIPO_IDEN_CLIENTE;
    public String IDEN_CLIENTE;
    public String FEC_CREACION;
    public String PNUM_ROL_EMPLEADO;
    public String PCOD_TIPO_JURIDI;
    public String PCOD_CLIENTE;
    public String PCOD_TIPO_CLIENTE;
    public String PCOD_SECTOR_ECONOM;
    public String PFEC_CLIENTE;
    public String PNUM_COR_DOMLEGAL;
    public String PCOD_ACTIVIDAD;
    public String PCOD_SECTOR;
    public String PCOD_CATDEU;
    public String PCOD_RELA_BICE;
    public String PCOD_GRUP_RELA;
    public String PCOD_ESTA_DEUD;
    public String PNUM_CARPETA;
    public String PNUM_CASI_INTE;
    public String PGLS_SINO_SBIF;
    public String PFEC_DECL_JURADA;
    public String PFEC_VERIF_DOMLEGAL;
    public String PFLG_FIRMA_COBPREJUD;
    public String PFEC_FIRMA_COBPREJUD;
    public String PNUM_TAX_ID;
    public String PCOD_SII_EXEIMP;
    public String PFLG_SII_CONTPRIMERACAT;
    public String PCOD_TIPO_ALERTA;
    public String PFEC_ALERTA;
    public String PFLAG_MANDATO_INVERSION;
    public String PCOD_GIROSII;
    public String PCOD_FRAUDE;
    public String PFLG_EMPLEADO;
    public String PNOM_PATERNO;
    public String PNOM_MATERNO;
    public String PNOM_NOMBRES;
    public String PNOM_NICKNAME;
    public String PCOD_NACION;
    public String PCOD_RESIDENCIA;
    public String PCOD_PROFESION;
    public String PFEC_NACIM;
    public String PCOD_SEXO;
    public String PCOD_NIV_EDUCAC;
    public String PCOD_ESTCIVIL;
    public String PCOD_SEPBIENES;
    public String PNUM_CARGAS;
    public String PFEC_ANTIG_VIV;
    public String PFEC_DEFUNCION;
    public String PFEC_CERT_ECIVI;
    public String PGLS_RAZON_SOCI;
    public String PGLS_RAZON_SOCIAL_LEGAL;
    public String PNOM_FANTASIA;
    public String PCOD_GRUPO_ECON;
    public String PFEC_CONSTITUCION;
    public String PCOD_TIPO_CLIEMPRESA;
    public String PGLS_WEB;
    //Nuevos campos 070317//
    public String PCOD_TIPOCLI;
    public String PCOD_SUBTIPOCLI;
    public String PCOD_TIP_CLI_CL;
    public String PCOD_CLAS_SEG;
    public String PCOD_TIPO_FATCA;
    public String PCOD_INTIN;
    public String PCOD_IDGIN;
    public String PCOD_CLARIE;
    public String PCOD_PAGA_IVA;
    public String PCOD_AGRUPACION;
    ///////////////////
    ////Nuevo Campo 16-08-2017/////
    public String PCOD_CLAS_EDAD; //Subsegmento
    ///////////////////
    public Boolean dir = false;
    public DIRECCION[] DIRECCIONES;
    public Boolean ema = false;
    public EMAIL[] EMAILS;
    public Boolean con = false;
    public CONTACTO[] CONTACTOS;
    public class DIRECCION{
        public String PCOD_CIUDAD;
        public String PCOD_COMUNA;
        public String PCOD_PAIS;
        //public String PCOD_POSTAL;
        public String PCOD_REGION;
        public String PCOD_TIPODIR;
        public String PGLS_DIRECCION;
        public String PGLS_OFI_POST;
        public String PNUM_CASILLA;
        public String PNUM_SECUENCIA;
        public TELEFONO[] TELEFONOS;
    }
    public class TELEFONO{
        public String CODIGO_FONO;
        public String PCOD_TIPO_FONO;
        public String PNUM_FONO;
    }
    public class EMAIL{
        public String PGLS_DIRMAIL;
        public String PNUM_SECUENCIA;
    }
    public class CONTACTO{
        public String PCOD_CARGO;
        public String PCOD_TIPO_CONTACTO;
        public String PGLS_EMAIL;
        public String PNOM_MATERNO;
        public String PNOM_NOMBRES;
        public String PNOM_PATERNO;
        public String PNUM_CELULAR;
        public String PNUM_CORRELATIVO;
        public String PNUM_FAX;
        public String PNUM_FONO;
    }
    //Nuevos en progreso
    public List<RecordType> rPN{get;set;}
    public List<RecordType> rPJ{get;set;}
    public List<RecordType> rEC{get;set;}
    public Lead L;
    
    public BICE_Lead_Int10lController(ApexPages.StandardController controller){
        tipoPersona = '';
        rPN = [SELECT Id, Name FROM RecordType WHERE Name LIKE '%Persona Natural%'];
        rPJ = [SELECT Id, Name FROM RecordType WHERE Name LIKE '%Persona Jur%'];
        rEC = [SELECT Id, Name FROM RecordType WHERE Name LIKE '%Empresas y Co%'];
        this.myLead = (Lead)controller.getRecord();
        lid = myLead.Id;
        for(RecordType r : rPN){ if(r.Id == myLead.RecordTypeId && tipoPersona == ''){ tipoPersona = '2'; } }
        for(RecordType r : rPJ){ if(r.Id == myLead.RecordTypeId && tipoPersona == ''){ tipoPersona = '3'; } }
        for(RecordType r : rEC){ if(r.Id == myLead.RecordTypeId && tipoPersona == ''){ tipoPersona = '3'; } }
        LeadFields();
    }
    
    public void LeadFields(){
        L = new Lead();
        if(tipoPersona == '2'){ //Persona Natural
            System.debug('Buscando Persona Natural');
            L = [SELECT OwnerId, Sucursal_de_Apertura_del__c, Rut__c, Customer_type_other_rating__c, Sub_Sector_Economico__c, 
                    Actividad_Economica_SBIF__c, SBIF_Sector__c, LastName, Apellido_Materno__c, FirstName, Nationality__c,
                    Profession__c, Birth_Date__c, Sex__c, Educational_Level__c, Estado_civil__c , Apartment__c, Office_Number__c,
                    Raz_n_Social__c, Socios_de_la_empresa_grupo_econ_mico__c, Ciudad_Particular__c, BICE_Classification__c, 
                    Comuna_Particular__r.Name, Pais_Particular__c, Region_Particular__c, Calle_Particular__c,
                    Numero_Particular__c, Ciudad_Comercial__c, Comuna_Comercial__r.Name, Pais_Comercial__c, Title, 
                    Region_Comercial__c, Calle_Comercial__c, Numero_Comercial__c, Phone, MobilePhone, Commercial_Cellphone__c,
                    Commercial_Phone_Other__c, Particular_Phone_Other__c, Phone_contact__c, Fax, Email, Commercial_Email__c, Website,
                    Segmentation__c, FATCA_Information__c,Numero_de_TIN__c, Numero_de_GIN__c,Fecha_Solicitud_Crear_Cliente__c,Conjugal_Regime__c,
                    Clasificacion_de_Riesgo_SBIF__c,Tipo_de_Persona__c,Account_Executive__r.ROL_Number__c,Commercial_Landline__c,Subsegmento__c,
                    Commercial_Classification__c,Particular_Landline__c,LastModifiedBy.ROL_Number__c,Segmentacion_Liquidez_Codigo__c,Segmentacion_Liquidez_Subcodigo__c
                 FROM Lead 
                 WHERE Id =:lid];
            //Obtain ROL NUMBER from User
            User u = [SELECT ROL_Number__c FROM User WHERE Id =:L.OwnerId];
            //Validacion de campos necesarios para la integracion
            if(L.Sucursal_de_Apertura_del__c != null){
                COD_SUCURSAL = L.Sucursal_de_Apertura_del__c.toUpperCase();
                IDEN_CLIENTE = (L.Rut__c.replace('-','')).replace('.','');
                PNUM_ROL_EMPLEADO = L.Account_Executive__r.ROL_Number__c;//'0';
               // if(L.Tipo_de_Persona__c == 'Persona Natural')
                    PCOD_TIPO_JURIDI = '1';
                //else{
                    
                //}            
                PCOD_CLIENTE = L.Customer_type_other_rating__c;
                PCOD_TIPO_CLIENTE = 'Personas Naturales';//L.BICE_Classification__c!=null?L.BICE_Classification__c.toUpperCase():'SIN DEFINIR';
                PCOD_SECTOR_ECONOM = L.Sub_Sector_Economico__c!=null?L.Sub_Sector_Economico__c.toUpperCase():'SIN CLASIFICAR'; //OK
                PCOD_ACTIVIDAD = 'Serv. Comunales, Sociales y Personales';//L.Actividad_Economica_SBIF__c!=null?L.Actividad_Economica_SBIF__c.toUpperCase():'SIN DEFINIR'; //OK
                PCOD_SECTOR = L.SBIF_Sector__c; //'Personas Naturales';
                //Nuevos Campos 07032017//
                PCOD_TIPOCLI = L.Segmentacion_Liquidez_Codigo__c; //'Minorista';
                PCOD_SUBTIPOCLI = L.Segmentacion_Liquidez_Subcodigo__c;//'Minoristas personas naturales'; 
                PCOD_TIP_CLI_CL = 'Personas';
                PCOD_CLAS_SEG = L.Segmentation__c;
                PCOD_CLAS_EDAD = L.Subsegmento__c;
                PCOD_TIPO_FATCA = L.FATCA_Information__c;
                PCOD_INTIN = L.Numero_de_TIN__c;
                PCOD_IDGIN = L.Numero_de_GIN__c;
                PCOD_CATDEU = 'Persona natural';
                PCOD_RELA_BICE = 'NO RELACIONADO';
                PCOD_GRUP_RELA = 'Sin Grupo';
                PCOD_ESTA_DEUD = 'DEM';
                //PFEC_CLIENTE = String.ValueOf(L.Fecha_Solicitud_Crear_Cliente__c);
                PCOD_SEPBIENES = L.Conjugal_Regime__c;
                PFLG_EMPLEADO = 'N';
                PCOD_CLARIE = L.Commercial_Classification__c;//L.Clasificacion_de_Riesgo_SBIF__c;
                PNUM_CARPETA = '0';
                PNUM_CASI_INTE = '0';
                COD_OPERADOR = L.LastModifiedBy.ROL_Number__c;
                ///////////////////////////
                PFEC_CLIENTE = FormatoFecha(L.Fecha_Solicitud_Crear_Cliente__c,PFEC_CLIENTE );
                if(L.LastName != null){
                    PNOM_PATERNO = L.LastName.toUpperCase();
                }
                if(L.Apellido_Materno__c != null){
                    PNOM_MATERNO = L.Apellido_Materno__c.toUpperCase();
                }
                if(L.FirstName != null){
                    PNOM_NOMBRES = L.FirstName.toUpperCase();
                }
                if(L.Nationality__c == null){
                    PCOD_NACION = 'NO DEFINIDO';
                }else{
                    PCOD_NACION = L.Nationality__c;
                }
                /*else if(L.Nationality__c == 'Chile'){
                    PCOD_NACION = 'NACIONAL';
                }else{
                    PCOD_NACION = 'EXTRANJERO';
                }*/
                if(L.Profession__c != null){
                    PCOD_PROFESION = L.Profession__c.toUpperCase();
                }
                
                if(L.Birth_Date__c != null){
                    Integer val = L.Birth_Date__c.day();
                    if(val < 10){ PFEC_NACIM = '0'+String.valueOf(val)+'/'; }else{ PFEC_NACIM = String.valueOf(val)+'/'; }
                    val = L.Birth_Date__c.month();
                    if(val < 10){ PFEC_NACIM = PFEC_NACIM + '0'+String.valueOf(val)+'/'; }else{ PFEC_NACIM = PFEC_NACIM + String.valueOf(val)+'/'; }
                    PFEC_NACIM = PFEC_NACIM + String.valueOf(L.Birth_Date__c.year());
                }else{
                    PFEC_NACIM = '';
                }
                
                if(L.Sex__c == null){
                    PCOD_SEXO = 'NO INFORMADO';
                }else if(L.Sex__c == 'Male'){
                    PCOD_SEXO = 'MASCULINO';
                }else if(L.Sex__c == 'Female'){
                    PCOD_SEXO = 'FEMENINO';
                }
                PCOD_NIV_EDUCAC = L.Educational_Level__c!=null?L.Educational_Level__c:'SIN ASIGNACION';
                if(L.Estado_civil__c != null){
                    if(L.Estado_civil__c == 'Divorciado'){
                        PCOD_ESTCIVIL = 'DIVORCIADO/SEPARADO';
                    }else if(L.Estado_civil__c == 'Ninguno'){
                        PCOD_ESTCIVIL = 'SIN INFORMACION';
                    }else{
                        PCOD_ESTCIVIL = L.Estado_civil__c.toUpperCase();
                    }
                }else{
                    PCOD_ESTCIVIL = 'SIN INFORMACION';
                }
                //PGLS_RAZON_SOCI = L.Raz_n_Social__c!=null?L.Raz_n_Social__c:'';
                //PGLS_RAZON_SOCIAL_LEGAL = L.Raz_n_Social__c!=null?L.Raz_n_Social__c:'';
                //PCOD_GRUPO_ECON = L.Socios_de_la_empresa_grupo_econ_mico__c;
                //PCOD_TIPO_CLIEMPRESA = L.Customer_type_other_rating__c;
                DIRECCIONES = new List<DIRECCION>();
                if(L.Calle_Particular__c != null){
                    dir = true;
                    DIRECCION dn = new DIRECCION();
                    dn.PCOD_CIUDAD = L.Ciudad_Particular__c.toUpperCase();
                    dn.PCOD_COMUNA = L.Comuna_Particular__r.Name.toUpperCase();
                    dn.PCOD_PAIS = L.Pais_Particular__c.toUpperCase();
                    dn.PCOD_REGION = L.Region_Particular__c.toUpperCase();
                    dn.PCOD_TIPODIR = '2';
                    if(L.Numero_Particular__c != null){
                        if(L.Apartment__c != null){
                            dn.PGLS_DIRECCION = L.Calle_Particular__c.toUpperCase() +' '+ L.Numero_Particular__c+', '+ L.Apartment__c.toUpperCase();
                        }else{
                            dn.PGLS_DIRECCION = L.Calle_Particular__c.toUpperCase() +' '+ L.Numero_Particular__c;
                        }
                    }else{
                        dn.PGLS_DIRECCION = L.Calle_Particular__c.toUpperCase();
                    }
                    dn.TELEFONOS = new List<TELEFONO>();
                    if(L.Particular_Landline__c != null){
                        TELEFONO t1 = new TELEFONO();
                        t1.CODIGO_FONO = '';
                        t1.PCOD_TIPO_FONO = 'FIJO';
                        t1.PNUM_FONO = L.Particular_Landline__c.replace(' ','');
                        dn.TELEFONOS.add(t1);
                    }
                    if(L.MobilePhone != null){
                        TELEFONO t2 = new TELEFONO();
                        t2.CODIGO_FONO = '';
                        t2.PCOD_TIPO_FONO = 'CELULAR';
                        t2.PNUM_FONO = L.MobilePhone.replace(' ','');
                        dn.TELEFONOS.add(t2);
                    }
                    if(L.Particular_Phone_Other__c != null){
                        TELEFONO t5 = new TELEFONO();
                        t5.CODIGO_FONO = '';
                        t5.PCOD_TIPO_FONO = 'OTRO';
                        t5.PNUM_FONO = L.Particular_Phone_Other__c.replace(' ','');
                        dn.TELEFONOS.add(t5);
                    }
                    
                    DIRECCIONES.add(dn);
                }
                if(L.Calle_Comercial__c != null){
                    dir = true;
                    DIRECCION dc = new DIRECCION();
                    dc.PCOD_CIUDAD = L.Ciudad_Comercial__c.toUpperCase();
                    dc.PCOD_COMUNA = L.Comuna_Comercial__r.Name.toUpperCase();
                    dc.PCOD_PAIS = L.Pais_Comercial__c.toUpperCase();
                    dc.PCOD_REGION = L.Region_Comercial__c.toUpperCase();
                    dc.PCOD_TIPODIR = '3';
                    if(L.Numero_Comercial__c != null){
                        if(L.Office_Number__c != null){
                            dc.PGLS_DIRECCION = L.Calle_Comercial__c.toUpperCase() +' '+ L.Numero_Comercial__c+', '+L.Office_Number__c.toUpperCase();
                        }else{
                            dc.PGLS_DIRECCION = L.Calle_Comercial__c.toUpperCase() +' '+ L.Numero_Comercial__c;
                        }
                    }else{
                        dc.PGLS_DIRECCION = L.Calle_Comercial__c.toUpperCase();
                    }
                    dc.TELEFONOS = new List<TELEFONO>();
                    if(L.Phone != null){
                        TELEFONO t3 = new TELEFONO();
                        t3.CODIGO_FONO = '';
                        t3.PCOD_TIPO_FONO = 'FIJO';
                        t3.PNUM_FONO = L.Phone.replace(' ','');
                        dc.TELEFONOS.add(t3);
                    }
                    if(L.Commercial_Cellphone__c != null){
                        TELEFONO t3 = new TELEFONO();
                        t3.CODIGO_FONO = '';
                        t3.PCOD_TIPO_FONO = 'CELULAR';
                        t3.PNUM_FONO = L.Commercial_Cellphone__c.replace(' ','');
                        dc.TELEFONOS.add(t3);
                    }
                    if(L.Commercial_Phone_Other__c != null){
                        TELEFONO t4 = new TELEFONO();
                        t4.CODIGO_FONO = '';
                        t4.PCOD_TIPO_FONO = 'OTRO';
                        t4.PNUM_FONO = L.Commercial_Phone_Other__c.replace(' ','');
                        dc.TELEFONOS.add(t4);
                    }
                    DIRECCIONES.add(dc);
                }
                EMAILS = new List<EMAIL>();
                if(L.Email != null){
                    ema = true;
                    EMAIL e1 = new EMAIL();
                    e1.PGLS_DIRMAIL = L.Email.toUpperCase();
                    EMAILS.add(e1);
                }
                if(L.Commercial_Email__c != null){
                    ema = true;
                    EMAIL e2 = new EMAIL();
                    e2.PGLS_DIRMAIL = L.Commercial_Email__c.toUpperCase();
                    EMAILS.add(e2);
                }
                System.debug('Listo para integrar');
            }else{
                // Los datos necesarios para la integracion no estan completos
                System.debug('Faltan datos');
                System.debug('Datos validados:');
                System.debug('Sucursal='+L.Sucursal_de_Apertura_del__c);
                System.debug('Clasificacion='+L.BICE_Classification__c);
                System.debug('Sub sector='+L.Sub_Sector_Economico__c);
                System.debug('Actividad='+L.Actividad_Economica_SBIF__c);
                System.debug('Sexo='+L.Sex__c);
            }
        }else if(tipoPersona == '3'){ //Persona Juridica
            System.debug('Buscando Persona Jurídica');
            L = [SELECT OwnerId, Sucursal_de_Apertura_del__c, Rut__c, Customer_type_other_rating__c, Sub_Sector_Economico__c, 
                    Actividad_Economica_SBIF__c, SBIF_Sector__c, LastName, Apellido_Materno__c, FirstName, Nationality__c,
                    Profession__c, Birth_Date__c, Sex__c, Educational_Level__c, Estado_civil__c , Company, Apartment__c, Office_Number__c,
                    Raz_n_Social__c, Socios_de_la_empresa_grupo_econ_mico__c, Ciudad_Particular__c, BICE_Classification__c, 
                    Comuna_Particular__r.Name, Pais_Particular__c, Region_Particular__c, Calle_Particular__c,
                    Numero_Particular__c, Ciudad_Comercial__c, Comuna_Comercial__r.Name, Pais_Comercial__c, Title, 
                    Region_Comercial__c, Calle_Comercial__c, Numero_Comercial__c, Phone, MobilePhone, Particular_Phone_Other__c, 
                    Particular_Mobile__c, Particular_FAX__c, Commercial_Cellphone__c, Phone_contact__c, 
                    Commercial_Phone_Other__c, Commercial_Landline__c, Commercial_FAX_Other__c, Fax, Email, Commercial_Email__c, Website,
                     Segmentation__c, FATCA_Information__c,Numero_de_TIN__c, Numero_de_GIN__c,Fecha_Solicitud_Crear_Cliente__c,Conjugal_Regime__c,
                     Clasificacion_de_Riesgo_SBIF__c,Clasificacion_submargen__c,Name,Fecha_Constitucion_Empresa__c,Tipo_de_cliente_empresa__c,Tipo_de_Persona__c,
                     Account_Executive__r.ROL_Number__c,Subsegmento__c,LastModifiedBy.ROL_Number__c,Segmentacion_Liquidez_Codigo__c,Segmentacion_Liquidez_Subcodigo__c,Taxes__c,
                     Customer_Legal_Person_Consumer__c, Cargo__c,Fecha_de_declaracion_de_margen__c 
                 FROM Lead 
                 WHERE Id =:lid];
            //Obtain ROL NUMBER from User
            User u = [SELECT ROL_Number__c FROM User WHERE Id =:L.OwnerId];
            //Validacion de campos necesarios para la integracion
            if(L.Sucursal_de_Apertura_del__c != null){
                COD_SUCURSAL = L.Sucursal_de_Apertura_del__c.toUpperCase();
                IDEN_CLIENTE = (L.Rut__c.replace('-','')).replace('.','');
                PNUM_ROL_EMPLEADO = L.Account_Executive__r.ROL_Number__c; //'0';
               // if(L.Tipo_de_Persona__c == 'Otras Instituciones Jurídicas')
                   PCOD_TIPO_JURIDI = '6';
                //else{
                   // PCOD_TIPO_JURIDI  = L.Tipo_de_Persona__c;
                //}    
                PCOD_CLIENTE = L.Customer_type_other_rating__c;
                PCOD_TIPO_CLIENTE = L.BICE_Classification__c;//L.BICE_Classification__c!=null?L.BICE_Classification__c.toUpperCase():'SIN DEFINIR';
                PCOD_SECTOR_ECONOM = L.Sub_Sector_Economico__c!=null?L.Sub_Sector_Economico__c.toUpperCase():'SIN CLASIFICAR'; //OK
                PCOD_ACTIVIDAD = L.Actividad_Economica_SBIF__c!=null?L.Actividad_Economica_SBIF__c.toUpperCase():'SIN DEFINIR'; //OK
                PCOD_SECTOR = L.SBIF_Sector__c; //'Personas Juridicas con fines de lucro';
                PCOD_PROFESION = L.Profession__c!=null?L.Profession__c.toUpperCase():'';
                //Nuevos campos 04072017
                PCOD_TIPOCLI = L.Segmentacion_Liquidez_Codigo__c;//'Minorista';
                PCOD_SUBTIPOCLI = L.Segmentacion_Liquidez_Subcodigo__c;//'Otros minoristas';
                PCOD_TIP_CLI_CL = L.Clasificacion_submargen__c;
                PCOD_CLAS_SEG = L.Segmentation__c;
                PCOD_CLAS_EDAD = L.Subsegmento__c;
                PCOD_TIPO_FATCA = L.FATCA_Information__c;
                PCOD_INTIN = L.Numero_de_TIN__c;
                PCOD_IDGIN = L.Numero_de_GIN__c;
                PCOD_CATDEU = 'Productiva';
                PCOD_RELA_BICE = 'NO RELACIONADO';
                PCOD_GRUP_RELA = 'Sin Grupo';
                PCOD_ESTA_DEUD = 'DEM';
                //PFEC_CLIENTE = String.ValueOf(L.Fecha_Solicitud_Crear_Cliente__c);
                PCOD_CLARIE = L.Clasificacion_de_Riesgo_SBIF__c;               
                PFEC_CLIENTE  = FormatoFecha(L.Fecha_Solicitud_Crear_Cliente__c,PFEC_CLIENTE);
                PFEC_CONSTITUCION = FormatoFecha(L.Fecha_Constitucion_Empresa__c,PFEC_CONSTITUCION);
                PNUM_CARPETA = '0';
                PNUM_CASI_INTE = '0';
                COD_OPERADOR = L.LastModifiedBy.ROL_Number__c;
                PCOD_AGRUPACION = L.Customer_Legal_Person_Consumer__c;
                if(L.Taxes__c)
                    PCOD_PAGA_IVA = '1';
                else
                    PCOD_PAGA_IVA = '0';
                /////////////////////////
                if(L.Birth_Date__c != null){
                    Integer val = L.Birth_Date__c.day();
                    if(val < 10){ PFEC_NACIM = '0'+String.valueOf(val)+'/'; }else{ PFEC_NACIM = String.valueOf(val)+'/'; }
                    val = L.Birth_Date__c.month();
                    if(val < 10){ PFEC_NACIM = PFEC_NACIM + '0'+String.valueOf(val)+'/'; }else{ PFEC_NACIM = PFEC_NACIM + String.valueOf(val)+'/'; }
                    PFEC_NACIM = PFEC_NACIM + String.valueOf(L.Birth_Date__c.year());
                }else{
                    PFEC_NACIM = '';
                }
                
                
                if(L.Sex__c == null){
                    PCOD_SEXO = 'NO INFORMADO';
                }else if(L.Sex__c == 'Male'){
                    PCOD_SEXO = 'MASCULINO';
                }else if(L.Sex__c == 'Female'){
                    PCOD_SEXO = 'FEMENINO';
                }
                PCOD_NIV_EDUCAC = L.Educational_Level__c!=null?L.Educational_Level__c.toUpperCase():'SIN ASIGNACION';
                if(L.Estado_civil__c != null){
                    if(L.Estado_civil__c == 'Divorciado'){
                        PCOD_ESTCIVIL = 'DIVORCIADO/SEPARADO';
                    }else if(L.Estado_civil__c == 'Ninguno'){
                        PCOD_ESTCIVIL = 'SIN INFORMACION';
                    }else{
                        PCOD_ESTCIVIL = L.Estado_civil__c.toUpperCase();
                    }
                }else{
                    PCOD_ESTCIVIL = 'SIN INFORMACION';
                }
                PGLS_RAZON_SOCI = L.Raz_n_Social__c!=null?(L.Raz_n_Social__c.toUpperCase()).replace('&','&amp;'):'';
                PNOM_FANTASIA = L.Company!=null?(L.Company.toUpperCase()).replace('&','&amp;'):''; //Company
                PGLS_RAZON_SOCIAL_LEGAL = L.Raz_n_Social__c!=null?(L.Raz_n_Social__c.toUpperCase().replace('&','&amp;')):'';
                PCOD_GRUPO_ECON = 'Sin Clasificar';//L.Socios_de_la_empresa_grupo_econ_mico__c!=null?L.Socios_de_la_empresa_grupo_econ_mico__c.toUpperCase():'';
                PCOD_TIPO_CLIEMPRESA = L.Tipo_de_cliente_empresa__c;//L.Customer_type_other_rating__c!=null?L.Customer_type_other_rating__c.toUpperCase():'';
                PGLS_WEB = L.Website!=null?L.Website.toUpperCase():'';
                PFEC_DECL_JURADA = FormatoFecha(l.Fecha_de_declaracion_de_margen__c,PFEC_DECL_JURADA);
                DIRECCIONES = new List<DIRECCION>();
                if(L.Calle_Comercial__c != null){
                    dir = true;
                    DIRECCION dc = new DIRECCION();
                    dc.PCOD_CIUDAD = L.Ciudad_Comercial__c.toUpperCase();
                    dc.PCOD_COMUNA = L.Comuna_Comercial__r.Name.toUpperCase();
                    dc.PCOD_PAIS = L.Pais_Comercial__c.toUpperCase();
                    dc.PCOD_REGION = L.Region_Comercial__c.toUpperCase();
                    dc.PCOD_TIPODIR = '3';
                    if(L.Numero_Comercial__c != null){
                        if(L.Office_Number__c != null){
                            dc.PGLS_DIRECCION = L.Calle_Comercial__c.toUpperCase().replace('&','&') +' '+ L.Numero_Comercial__c+', '+ L.Office_Number__c.toUpperCase();
                        }else{
                            dc.PGLS_DIRECCION = L.Calle_Comercial__c.toUpperCase().replace('&','&') +' '+ L.Numero_Comercial__c;
                        }
                    }else{
                        dc.PGLS_DIRECCION = L.Calle_Comercial__c.toUpperCase().replace('&','&');
                    }
                    dc.TELEFONOS = new List<TELEFONO>();
                    if(L.Phone != null){
                        TELEFONO t3 = new TELEFONO();
                        t3.CODIGO_FONO = '';
                        t3.PCOD_TIPO_FONO = 'FIJO';
                        t3.PNUM_FONO = L.Phone.replace(' ','');
                        dc.TELEFONOS.add(t3);
                    }
                    if(L.Commercial_Cellphone__c != null){
                        TELEFONO t4 = new TELEFONO();
                        t4.CODIGO_FONO = '';
                        t4.PCOD_TIPO_FONO = 'CELULAR';
                        t4.PNUM_FONO = L.Commercial_Cellphone__c.replace(' ','');
                        dc.TELEFONOS.add(t4);
                    }
                    if(L.Commercial_Phone_Other__c != null){
                        TELEFONO t5 = new TELEFONO();
                        t5.CODIGO_FONO = '';
                        t5.PCOD_TIPO_FONO = 'CELULAR';
                        t5.PNUM_FONO = L.Commercial_Phone_Other__c.replace(' ','');
                        dc.TELEFONOS.add(t5);
                    }
                    
                    DIRECCIONES.add(dc);
                }
                EMAILS = new List<EMAIL>();
                if(L.Email != null){
                    ema = true;
                    EMAIL e1 = new EMAIL();
                    e1.PGLS_DIRMAIL = L.Email.toUpperCase();
                    EMAILS.add(e1);
                }
                if(L.Commercial_Email__c != null){
                    ema = true;
                    EMAIL e2 = new EMAIL();
                    e2.PGLS_DIRMAIL = L.Commercial_Email__c.toUpperCase();
                    EMAILS.add(e2);
                }
                CONTACTOS = new List<CONTACTO>();
                if(L.FirstName != null){
                    con = true;
                    CONTACTO c1 = new CONTACTO();
                    c1.PCOD_CARGO = l.Cargo__c;//'SIN DEFINIR';//L.Title!=null?L.Title:'';
                    c1.PCOD_TIPO_CONTACTO = 'EJECUTIVO MÁXIMO';
                    if(L.Email!=null){ c1.PGLS_EMAIL = L.Email.toUpperCase(); }
                    if(L.Apellido_Materno__c!=null){ c1.PNOM_MATERNO = L.Apellido_Materno__c.toUpperCase(); }
                    if(L.FirstName!=null){ c1.PNOM_NOMBRES = L.FirstName.toUpperCase(); }
                    if(L.LastName!=null){ c1.PNOM_PATERNO = L.LastName.toUpperCase(); }
                    if(L.MobilePhone!=null){ c1.PNUM_CELULAR = L.MobilePhone; }
                    c1.PNUM_CORRELATIVO = '1';
                    if(L.Fax!=null){ c1.PNUM_FAX = L.Fax; }
                    if(L.Phone!=null){ c1.PNUM_FONO = L.Phone.replaceAll( '\\s+', ''); }
                    CONTACTOS.add(c1);
                }
                System.debug('Listo para integrar');
            }else{
                // Los datos necesarios para la integracion no estan completos
                System.debug('Faltan datos');
                System.debug('Datos validados:');
                System.debug('Sucursal='+L.Sucursal_de_Apertura_del__c);
                System.debug('Clasificacion='+L.BICE_Classification__c);
                System.debug('Sub sector='+L.Sub_Sector_Economico__c);
                System.debug('Actividad='+L.Actividad_Economica_SBIF__c);
                System.debug('Sexo='+L.Sex__c);
            }
        }
    }
    
    public void updateLead(String CifId){
        Lead myObj = [SELECT CIF_Id__c FROM Lead WHERE Id =:lid];
        If(CifId != '-1' && String.isBlank(CifId) == false){ //If(String.isBlank(CifId) == false)
            myObj.CIF_Id__c = CifId;
            myObj.Customer_Creation__c = 'Realizado';
            update myObj;
        }
        else
        {
            myObj.CIF_Id__c = CifId;
            myObj.Customer_Creation__c = 'No realizado';
            update myObj;
        }  
    }

    public PageReference callInt10L(){
        Endpoint_Setting__mdt xEx = [SELECT Id, Endpoint__c, Namespace__c FROM Endpoint_Setting__mdt WHERE MasterLabel = 'INT10L'];
        String soapNS = xEx.Namespace__c;
        //String endpoint = 'https://sfqa.bice.cl/bus/CrearClienteCifFacade/Crear';
        String endpoint = xEx.Endpoint__c;
        
        String testData = '';
        testData = testData + '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cif="'+soapNS+'">';
        testData = testData + '   <soapenv:Header/>';
        testData = testData + '   <soapenv:Body>';
        testData = testData + '      <cif:crearCliente>';
        testData = testData + '         <COD_CANAL>501</COD_CANAL>';
        testData = testData + '         <GLOSA_APLICACION>INGRESO POR CRM</GLOSA_APLICACION>';
        testData = testData + '         <COD_SUCURSAL>'+COD_SUCURSAL+'</COD_SUCURSAL>';
        testData = testData + '         <COD_OPERADOR>'+COD_OPERADOR+'</COD_OPERADOR>';
        testData = testData + '         <TIPO_IDEN_CLIENTE>1</TIPO_IDEN_CLIENTE>';
        testData = testData + '         <IDEN_CLIENTE>'+IDEN_CLIENTE+'</IDEN_CLIENTE>';
        //testData = testData + '         <FEC_CREACION></FEC_CREACION>';
        testData = testData + '         <PNUM_ROL_EMPLEADO>'+PNUM_ROL_EMPLEADO+'</PNUM_ROL_EMPLEADO>';
        testData = testData + '         <PCOD_TIPO_JURIDI>'+L.Tipo_de_Persona__c+'</PCOD_TIPO_JURIDI>';
        testData = testData + '         <PCOD_CLIENTE>'+PCOD_CLIENTE+'</PCOD_CLIENTE>';
        testData = testData + '         <PCOD_TIPO_CLIENTE>'+PCOD_TIPO_CLIENTE+'</PCOD_TIPO_CLIENTE>';
        if(PCOD_SECTOR_ECONOM != ''){
            testData = testData + '         <PCOD_SECTOR_ECONOM>'+PCOD_SECTOR_ECONOM+'</PCOD_SECTOR_ECONOM>';
        }
        if(PFEC_CLIENTE !=null)
            testData = testData + '         <PFEC_CLIENTE>'+PFEC_CLIENTE+'</PFEC_CLIENTE>';
        //testData = testData + '         <PNUM_COR_DOMLEGAL></PNUM_COR_DOMLEGAL>';
        testData = testData + '         <PCOD_ACTIVIDAD>'+PCOD_ACTIVIDAD+'</PCOD_ACTIVIDAD>';
        testData = testData + '         <PCOD_SECTOR>'+PCOD_SECTOR+'</PCOD_SECTOR>';
        testData = testData + '         <PCOD_CATDEU>'+PCOD_CATDEU+'</PCOD_CATDEU>';
        testData = testData + '         <PCOD_RELA_BICE>'+PCOD_RELA_BICE+'</PCOD_RELA_BICE>';
        testData = testData + '         <PCOD_GRUP_RELA>'+PCOD_GRUP_RELA+'</PCOD_GRUP_RELA>';
        testData = testData + '         <PCOD_ESTA_DEUD>'+PCOD_ESTA_DEUD+'</PCOD_ESTA_DEUD>';
        testData = testData + '         <PNUM_CARPETA>'+PNUM_CARPETA+'</PNUM_CARPETA>';
        testData = testData + '         <PNUM_CASI_INTE>'+PNUM_CASI_INTE+'</PNUM_CASI_INTE>';
        //testData = testData + '         <PGLS_SINO_SBIF></PGLS_SINO_SBIF>';
        if(PFEC_DECL_JURADA !=null)
            testData = testData + '         <PFEC_DECL_JURADA>'+PFEC_DECL_JURADA+'</PFEC_DECL_JURADA>';
        //testData = testData + '         <PFEC_VERIF_DOMLEGAL></PFEC_VERIF_DOMLEGAL>';
        //testData = testData + '         <PFLG_FIRMA_COBPREJUD></PFLG_FIRMA_COBPREJUD>';
        //testData = testData + '         <PFEC_FIRMA_COBPREJUD></PFEC_FIRMA_COBPREJUD>';
        //testData = testData + '         <PNUM_TAX_ID></PNUM_TAX_ID>';
        //testData = testData + '         <PCOD_SII_EXEIMP></PCOD_SII_EXEIMP>';
        //testData = testData + '         <PFLG_SII_CONTPRIMERACAT></PFLG_SII_CONTPRIMERACAT>';
        //testData = testData + '         <PCOD_TIPO_ALERTA></PCOD_TIPO_ALERTA>';
        //testData = testData + '         <PFEC_ALERTA></PFEC_ALERTA>';
        //testData = testData + '         <PFLAG_MANDATO_INVERSION></PFLAG_MANDATO_INVERSION>';
        //testData = testData + '         <PCOD_GIROSII></PCOD_GIROSII>';
        //testData = testData + '         <PCOD_FRAUDE></PCOD_FRAUDE>';
       // testData = testData + '         <PFLG_EMPLEADO>'+PFLG_EMPLEADO+'</PFLG_EMPLEADO>';
        if(PCOD_TIPO_JURIDI == '1'){
            testData = testData + '         <PFLG_EMPLEADO>'+PFLG_EMPLEADO+'</PFLG_EMPLEADO>';
            testData = testData + '         <PNOM_PATERNO>'+PNOM_PATERNO+'</PNOM_PATERNO>';
            testData = testData + '         <PNOM_MATERNO>'+PNOM_MATERNO+'</PNOM_MATERNO>';
            testData = testData + '         <PNOM_NOMBRES>'+PNOM_NOMBRES+'</PNOM_NOMBRES>';
            //testData = testData + '         <PNOM_NICKNAME></PNOM_NICKNAME>';
            testData = testData + '         <PCOD_NACION>'+PCOD_NACION+'</PCOD_NACION>';
            //testData = testData + '         <PCOD_RESIDENCIA></PCOD_RESIDENCIA>';
            testData = testData + '         <PCOD_PROFESION>'+PCOD_PROFESION+'</PCOD_PROFESION>';
            testData = testData + '         <PFEC_NACIM>'+PFEC_NACIM+'</PFEC_NACIM>';
            testData = testData + '         <PCOD_SEXO>'+PCOD_SEXO+'</PCOD_SEXO>';
            testData = testData + '         <PCOD_NIV_EDUCAC>'+PCOD_NIV_EDUCAC+'</PCOD_NIV_EDUCAC>';
            testData = testData + '         <PCOD_ESTCIVIL>'+PCOD_ESTCIVIL+'</PCOD_ESTCIVIL>';
            testData = testData + '         <PCOD_SEPBIENES>'+PCOD_SEPBIENES+'</PCOD_SEPBIENES>';
        }
        //testData = testData + '         <PCOD_SEPBIENES></PCOD_SEPBIENES>';
        //testData = testData + '         <PNUM_CARGAS></PNUM_CARGAS>';
        //testData = testData + '         <PFEC_ANTIG_VIV></PFEC_ANTIG_VIV>';
        //testData = testData + '         <PFEC_DEFUNCION></PFEC_DEFUNCION>';
        //testData = testData + '         <PFEC_CERT_ECIVI></PFEC_CERT_ECIVI>';
        if(PCOD_TIPO_JURIDI == '6'){
            testData = testData + '         <PGLS_RAZON_SOCI>'+PGLS_RAZON_SOCI+'</PGLS_RAZON_SOCI>';
            testData = testData + '         <PGLS_RAZON_SOCIAL_LEGAL>'+PGLS_RAZON_SOCIAL_LEGAL+'</PGLS_RAZON_SOCIAL_LEGAL>';
            testData = testData + '         <PNOM_FANTASIA>'+PNOM_FANTASIA+'</PNOM_FANTASIA>';
            testData = testData + '         <PCOD_GRUPO_ECON>'+PCOD_GRUPO_ECON+'</PCOD_GRUPO_ECON>';
            if(PFEC_CONSTITUCION!=null)
                testData = testData + '         <PFEC_CONSTITUCION>'+PFEC_CONSTITUCION+'</PFEC_CONSTITUCION>';
            testData = testData + '         <PCOD_TIPO_CLIEMPRESA>'+PCOD_TIPO_CLIEMPRESA+'</PCOD_TIPO_CLIEMPRESA>';
            testData = testData + '         <PGLS_WEB>'+PGLS_WEB+'</PGLS_WEB>';
        }
        if(dir){
            for(DIRECCION d : DIRECCIONES){
                testData = testData + '         <DIRECCION>';
                testData = testData + '            <PCOD_CIUDAD>'+d.PCOD_CIUDAD+'</PCOD_CIUDAD>';
                testData = testData + '            <PCOD_COMUNA>'+d.PCOD_COMUNA+'</PCOD_COMUNA>';
                testData = testData + '            <PCOD_PAIS>'+d.PCOD_PAIS+'</PCOD_PAIS>';
                //testData = testData + '            <PCOD_POSTAL>'+d.PCOD_POSTAL+'</PCOD_POSTAL>';
                testData = testData + '            <PCOD_REGION>'+d.PCOD_REGION+'</PCOD_REGION>';
                testData = testData + '            <PCOD_TIPODIR>'+d.PCOD_TIPODIR+'</PCOD_TIPODIR>';
                testData = testData + '            <PGLS_DIRECCION>'+d.PGLS_DIRECCION+'</PGLS_DIRECCION>';
                //testData = testData + '            <PGLS_OFI_POST></PGLS_OFI_POST>';
                //testData = testData + '            <PNUM_CASILLA></PNUM_CASILLA>';
                //testData = testData + '            <PNUM_SECUENCIA></PNUM_SECUENCIA>';
                //testData = testData + '            <!--Zero or more repetitions:-->';
               
                
                //testData = testData + '            <TELEFONO>';
               testData = testData + '<TELEFONO/>';
                    for(TELEFONO t : d.TELEFONOS){
                        if(t!= null){
                            testData = testData + '            <TELEFONO>';
                            //testData = testData + '               <CODIGO_FONO>'+t.CODIGO_FONO+'</CODIGO_FONO>';
                            testData = testData + '               <PCOD_TIPO_FONO>'+t.PCOD_TIPO_FONO+'</PCOD_TIPO_FONO>';
                            testData = testData + '               <PNUM_FONO>'+t.PNUM_FONO+'</PNUM_FONO>';                   
                            testData = testData + '            </TELEFONO>';
                         }
                         else{
                             testData = testData + '<TELEFONO/>';
                             }
                             
                    }
               
                
                //testData = testData + '            </TELEFONO>';
                testData = testData + '         </DIRECCION>';
            }
        }
        if(ema){
            for(EMAIL e : EMAILS){
                testData = testData + '         <EMAIL>';
                testData = testData + '            <PGLS_DIRMAIL>'+e.PGLS_DIRMAIL+'</PGLS_DIRMAIL>';
                //testData = testData + '            <PNUM_SECUENCIA></PNUM_SECUENCIA>';
                testData = testData + '         </EMAIL>';
            }
        }
        if(con){
            for(CONTACTO c : CONTACTOS){
                testData = testData + '         <CONTACTO>';
                if(PNOM_PATERNO != ''){
                    if(c.PCOD_CARGO != null){
                        testData = testData + '            <PCOD_CARGO>'+c.PCOD_CARGO+'</PCOD_CARGO>';
                    }
                    testData = testData + '            <PCOD_TIPO_CONTACTO>'+c.PCOD_TIPO_CONTACTO+'</PCOD_TIPO_CONTACTO>';
                    if(c.PGLS_EMAIL != null){
                        testData = testData + '            <PGLS_EMAIL>'+c.PGLS_EMAIL+'</PGLS_EMAIL>';
                    }
                    testData = testData + '            <PNOM_MATERNO>'+c.PNOM_MATERNO+'</PNOM_MATERNO>';
                    testData = testData + '            <PNOM_NOMBRES>'+c.PNOM_NOMBRES+'</PNOM_NOMBRES>';
                    testData = testData + '            <PNOM_PATERNO>'+c.PNOM_PATERNO+'</PNOM_PATERNO>';
                    if(c.PNUM_CELULAR != null){
                        testData = testData + '            <PNUM_CELULAR>'+c.PNUM_CELULAR+'</PNUM_CELULAR>';
                    }
                    if(c.PNUM_FAX != null){
                        testData = testData + '            <PNUM_FAX>'+c.PNUM_FAX+'</PNUM_FAX>';
                    }
                    if(c.PNUM_FONO != null){
                        testData = testData + '            <PNUM_FONO>'+c.PNUM_FONO+'</PNUM_FONO>';
                    }
                }
                testData = testData + '         </CONTACTO>';
            }
        }
        //Nuevos campos 04072017//
        if(PCOD_TIPOCLI != null)
            testData = testData + '<PCOD_TIPOCLI>'+PCOD_TIPOCLI+'</PCOD_TIPOCLI>';
        if(PCOD_SUBTIPOCLI != null)
            testData = testData + '<PCOD_SUBTIPOCLI>'+PCOD_SUBTIPOCLI+'</PCOD_SUBTIPOCLI>';
        if(PCOD_CLAS_SEG != null)
            testData = testData + '<PCOD_CLAS_SEG>'+PCOD_CLAS_SEG+'</PCOD_CLAS_SEG>';
        if(PCOD_CLAS_EDAD != null)
            testData = testData + '<PCOD_CLAS_EDAD>'+PCOD_CLAS_EDAD+'</PCOD_CLAS_EDAD>';   
        if(PCOD_TIP_CLI_CL != null)
            testData = testData + '<PCOD_TIP_CLI_CL>'+PCOD_TIP_CLI_CL+'</PCOD_TIP_CLI_CL>';
        if(PCOD_TIPO_FATCA != null)
            testData = testData + '<PCOD_TIPO_FATCA>'+PCOD_TIPO_FATCA+'</PCOD_TIPO_FATCA>';
        if(PCOD_INTIN != null)
            testData = testData + '<PCOD_INTIN>'+PCOD_INTIN+'</PCOD_INTIN>';
        if(PCOD_IDGIN != null)
            testData = testData + '<PCOD_IDGIN>'+PCOD_IDGIN+'</PCOD_IDGIN>';
        if(PCOD_CLARIE != null)
            testData = testData + '<PCOD_CLARIE>'+PCOD_CLARIE +'</PCOD_CLARIE>';           
        //////////////////////////
        if(PCOD_PAGA_IVA != null)
            testData = testData + '<PCOD_PAGA_IVA>'+PCOD_PAGA_IVA+'</PCOD_PAGA_IVA>';
        if(PCOD_AGRUPACION != null)
            testData = testData + '<PCOD_AGRUPACION>'+PCOD_AGRUPACION+'</PCOD_AGRUPACION >';     
        testData = testData + '      </cif:crearCliente>';
        testData = testData + '   </soapenv:Body>';
        testData = testData + '</soapenv:Envelope>';
        
        Dom.Document doc = new Dom.Document();
        doc.load(testData);
        
        System.debug(doc.toXmlString());
        
        // Send the request
        HttpRequest req = new HttpRequest();
        //req.setClientCertificateName('sfqabice');
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('Content-Type', 'text/xml;charset=utf-8');
        req.setBody(doc.toXmlString());
        req.setTimeout(120000);
        //req.setBodyDocument(doc);
        System.debug('Request: '+req);
        try{
            Http http = new Http();
            HttpResponse res = http.send(req);
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
            updateLead(ret.getChildElement('n_CIF_ID', null).getText());
            return Redireccionar();
        }catch(Exception e){
            system.debug('Exception Service: '+e);
            return RedirectError('El servicio está teniendo problemas... intente nuevamente.');
        }
        return null;
    }
   
    
    public String FormatoFecha(Date fecha, String salida){
    
        if(fecha != null){
                    Integer val = fecha.day();
                    if(val < 10){ salida = '0'+String.valueOf(val)+'/'; }else{ salida = String.valueOf(val)+'/'; }
                    val = fecha.month();
                    if(val < 10){ salida = salida + '0'+String.valueOf(val)+'/'; }else{ salida = salida + String.valueOf(val)+'/'; }
                    salida = salida + String.valueOf(fecha.year());
                    return salida;
                }else{
                    salida = '';
                }
                return salida;
    }
    
    
    public PageReference start(){
        return callInt10L();
    }
    
    public PageReference Redireccionar(){
        String urlToRedirect = '/apex/BICE_IntOnline_Redirect';
        PageReference myVFPage = new PageReference(urlToRedirect);
        myVFPage.getParameters().put('LID',lid);
        myVFPage.getParameters().put('msg','Validando datos...');
        myVFPage.setRedirect(true);
        return myVFPage;
    }
    
    public PageReference RedirectError(String mensaje){
        String urlToRedirect = '/apex/BICE_IntOnline_Redirect';
        PageReference myVFPage = new PageReference(urlToRedirect);
        myVFPage.getParameters().put('LID',lid);
        myVFPage.getParameters().put('msg', mensaje);
        myVFPage.setRedirect(true);
        return myVFPage;
    }
}