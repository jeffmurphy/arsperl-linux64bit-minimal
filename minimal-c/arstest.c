#include <stdio.h>
#include <strings.h>
#include <string.h>
#include <malloc.h>
#include <assert.h>

#include "ar.h"
#include "arerrno.h"
#include "arextern.h"
#include "arstruct.h"
#include "arfree.h"

int main()
{
                int              ret = 0;
                ARStatusList     status;
                ARControlStruct *ctrl;

/* ADJUST ************/
		char *server = "localhost";
		char *username = "Demo";
		char *password = "";


		char *lang = "";
		char *authString = "";
		int tcpport = 0;
		int rpcnumber = 0;

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
                bzero(&status, sizeof(ARStatusList));
                ctrl = (ARControlStruct *)malloc(sizeof(ARControlStruct));
		assert(ctrl != NULL);

                bzero(ctrl, sizeof(ARControlStruct));
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
		if (ret != 0) {
			DBG (( stderr, "ARInit failed %d\n", ret));
			return (-1);
		}

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
			return (-1);
                } else {
			DBG( (stderr, "ARVerifyUser ok %d\n", ret));
                }
		return (0);
        }
