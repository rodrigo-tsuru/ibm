@rem begin_generated_IBM_copyright_prolog

@rem Licensed Materials - Property of IBM
@rem 
@rem 5724-N72 5655-WBS
@rem 
@rem Copyright IBM Corp. 2015 All Rights Reserved.
@rem 
@rem US Government Users Restricted Rights - Use, duplication or
@rem disclosure restricted by GSA ADP Schedule Contract with
@rem IBM Corp.

@rem end_generated_IBM_copyright_prolog

@echo off

SetLocal

SET server=""
SET file=""

:loop
IF NOT "%1"=="" (
	IF "%1"=="-h" (
        call:usage
        exit /B 0
    )
    IF "%1"=="-help" (
        call:usage
        exit /B 0
    )
    IF "%1"=="-server" (
        SET server=-server %2
        SHIFT
    )
    IF "%1"=="-file" (
        SET file=-file %2
        SHIFT
    )
    IF "%1"=="-port" (
        SET port=-port %2
        SHIFT
    )
    IF "%1"=="-prefix" (
    	SET prefix=-prefix %2
    	SHIFT
    )
    IF "%1"=="-username" (
        SET username=-username %2
        SHIFT
    )
    IF "%1"=="-password" (
        SET password=-password %2
        SHIFT
    )
    IF "%1"=="-nl" (
        SET lang=-nl %2
        SHIFT
    )
    IF "%1"=="-debug" (
    	SET debug=-debug    	
    )
    IF "%1"=="-acceptAllCertificates" (
    	SET acceptAllCertificates=-acceptAllCertificates
   	)
   	IF "%1"=="-truststore" (
    	SET truststore=-truststore %2
   	)
   	IF "%1"=="-truststorepassword" (
    	SET truststorepassword=-truststorepassword %2
   	)
    SHIFT
    GOTO :loop
)

SET error=false
IF "%file%" == "" (
	echo File not set
	set error=true
)
IF "%server%" == "" (
	echo Server not set
	set error=true
)
IF "%server%" == "-server " (
	echo Server not set
	set error=true
) 
IF "%error%"=="true" (
	call:usage
	EXIT /B 1
)
echo java -jar BulkLoadTool.jar %file% %prefix% %server% %port% %lang% %debug% %acceptAllCertificates% %truststore%
java -Djava.util.logging.config.file=logging.properties -jar BulkLoadTool.jar %file% %prefix% %server% %port% %username% %password% %lang% %debug% %acceptAllCertificates% %truststore% %truststorepassword%
GOTO:EOF

:usage
	echo "Valid options"
	echo "-file <filePath>"
	echo "-server <Server>"
	echo "-port <WSRR SOAP Port>"
	echo "-prefix <WSRR Prefix>"
	echo "-username <username>"
	echo "-password <password>"
	echo "-truststore <trust store file path>"
	echo "-truststorepassword <trust store password>"
	echo "-acceptAllCertificates"
	echo "-nl <language>"	
	echo "-debug"
	echo "bulkloader.bat -file C:\Users\Documents\Services\spreadsheet.xls -server localhost -port 8879 -prefix prefix -username wasadmin -password pword1 -nl en -truststore C:\Users\wsrr\trust.p12 -truststorepassword pword2"	
GOTO:EOF

EndLocal
