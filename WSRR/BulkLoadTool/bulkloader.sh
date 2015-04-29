#!/bin/sh


# begin_generated_IBM_copyright_prolog

# Licensed Materials - Property of IBM
# 
# 5724-N72 5655-WBS
# 
# Copyright IBM Corp. 2015 All Rights Reserved.
# 
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with
# IBM Corp.

# end_generated_IBM_copyright_prolog

# BEGIN COPYRIGHT
# *************************************************************************
# Licensed Materials - Property of IBM 
# 5724-L01, 5655-N53, 5724-I82, 5655-R15
# Copyright IBM Corporation 2015. All rights reserved. 
# US Government Users Restricted Rights - Use, duplication, or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# *************************************************************************
# END COPYRIGHT

usage(){
	echo "Valid options"
	echo "-file <filePath>"
	echo "-server <ServerName>"
	echo "-port <WSRR SOAP Port>"
	echo "-prefix <prefix>"
	echo "-username <username>"
	echo "-password <password>"
	echo "-truststore <trust store file path>"
	echo "-truststorepassword <trust store password>"
	echo "-acceptAllCertificates"
	echo "-debug"
	echo "-nl <language>"
	echo "bulkloader.sh -file /home/root/spreadsheet.ods -server localhost -port 8879 -username wasadmin -password pword1 -truststore /home/wsrr/trust.p12 -truststorepassword pword2 -nl en"
}

#Get all entered options
while [ $# -gt 0 ]; do
    case $1 in
		-help|-?|-h) 	usage 
						exit 0                
						;;
		-file) 	shift
				FILE="-file $1"
				echo "filePath=$FILE"
				;;
		-acceptAllCertificates)	shift
				CERTIFICATES="-acceptAllCertificates"
				;;
		-truststore)	shift
				TRUSTSTORE="-truststore $1"				
				;;
		-truststorepassword)	shift
				TRUSTSTOREPASSWORD="-truststorepassword $1"				
				;;
		-port) 	shift
				PORT="-port $1"
				echo "port = $PORT"
				;;
		-server)	shift
					SERVER="-server $1"
					echo "server = $SERVER"
					;;     
		-prefix)	shift
					PREFIX="-prefix $1"
					echo "prefix = $PREFIX"
					;;     
		-username)	shift
				USER="-username $1"
				;;				
		-password)	shift
				PASSWORD="-password $1"
				;;
		-nl)	shift
				LANG="-nl $1"
				;;
		-debug)	
				DEBUG="-debug"
				;;
		-*) echo "Unsupported option"
			echo "$1"
			usage 
			exit 0                
			;;
	esac
	shift
done

#Check that all parameters have been set
ERROR="false"
if [ -z "$FILE" ]; then
	echo "File path for spreadsheet not set"
	ERROR="true"
fi
if [ -z "$SERVER" ]; then
	echo "Server Host name is not set"
	ERROR="true"
fi

if [ "$ERROR" == "true" ]; then
	usage
	exit 1
fi

echo java -jar BulkLoadTool.jar $FILE $SERVER $PORT $PREFIX $USER $LANG $DEBUG 
/usr/IBM/WebSphere/AppServer/java/bin/java -Djava.util.logging.config.file=logging.properties -jar BulkLoadTool.jar $FILE $SERVER $PORT $PREFIX $USER $PASSWORD $CERTIFICATES $TRUSTSTORE $TRUSTSTOREPASSWORD $LANG $DEBUG 
