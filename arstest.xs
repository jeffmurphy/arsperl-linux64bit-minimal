#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


#include "ar.h"
#include "arerrno.h"
#include "arextern.h"
#include "arstruct.h"
#include "arfree.h"

MODULE = arstest		PACKAGE = arstest		

ARControlStruct *
ars_Login(server, username, password, lang=NULL, authString=NULL, tcpport=0, rpcnumber=0, ...)
        char *          server
        char *          username
        char *          password
        char *          lang
        char *          authString
        unsigned int    tcpport
        unsigned int    rpcnumber
        CODE:
        {
                int              ret = 0;
                ARStatusList     status;
                ARControlStruct *ctrl;
# define DBG(X) fprintf(stderr, "[%s %d] %s : ", __FILE__, __LINE__, __FUNCTION__); fprintf X
#define SAFEPRT(X) (X && *X)? X : "[null]"
                DBG( (stderr,  "ars_Login(%s, %s, %s, %s, %s, %d, %d)\n",
                        SAFEPRT(server),
                        SAFEPRT(username),
                        SAFEPRT(password),
                        SAFEPRT(lang),
                        SAFEPRT(authString),
                        tcpport,
                        rpcnumber)
                    );
                RETVAL = NULL;
                Zero(&status, 1, ARStatusList);
                ctrl = (ARControlStruct *)safemalloc(sizeof(ARControlStruct));
                Zero(ctrl, 1, ARControlStruct);
                ctrl->cacheId = 0;
                ctrl->sessionId = 0;
                ctrl->operationTime = 0;
                strncpy(ctrl->user, username, sizeof(ctrl->user));
                ctrl->user[sizeof(ctrl->user)-1] = 0;
                strncpy(ctrl->password, password, sizeof(ctrl->password));
                ctrl->password[sizeof(ctrl->password)-1] = 0;
                strncpy(ctrl->server, server, sizeof(ctrl->server));
                ctrl->server[sizeof(ctrl->server)-1] = 0;
                ret = ARInitialization(ctrl, &status);

                ret = ARVerifyUser(ctrl, NULL, NULL, NULL, &status);
                if(ret != 0) {
			unsigned int    item;
                        DBG( (stderr, "ARVerifyUser failed %d\n", ret) );
        		for (item = 0; item < status.numItems; item++) {
                        	fprintf(stderr,  "messageType = %d\n", status.statusList[item].messageType );
                         	fprintf(stderr,  "messageNum  = %d\n", status.statusList[item].messageNum );
                         	fprintf(stderr,  "messageText = %s\n", status.statusList[item].messageText );
                        	fprintf(stderr,  "appendedText = %s\n", status.statusList[item].appendedText );
                        	fprintf(stderr,  "-----\n" ); 
			}
                        ARTermination(ctrl, &status);
                        free(ctrl); /* invalid, cleanup */
                        RETVAL = NULL;
                } else {
			DBG( (stderr, "ARVerifyUser ok %d\n", ret));
                        RETVAL = ctrl; /* valid, return ctrl struct */
                }
        }
	OUTPUT:
	RETVAL
