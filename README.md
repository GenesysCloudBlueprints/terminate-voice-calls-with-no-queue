# Update the External Tag on a conversation with a GC User's presence upon receiving an incoming Communicate call

This Genesys Cloud Developer Blueprint explains how to set up Genesys Cloud to update the external tag on a conversation with a GC User's presence upon receiving an incoming Communicate (PBX/Non-ACD) call.

When an Architect workflow receives a communicate call trigger, multiple Genesys Cloud Public API calls are made to retrieve the receiving GC user's current presence and update the external tag on the triggering conversation with the presence of the Genesys Cloud user.

The following shows the end-to-end user experience that this solution enables.

![End-to-end user experience](blueprint/images/GCPutExternalTag.gif "End-to-end user experience")
