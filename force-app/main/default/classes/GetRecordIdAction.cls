/**
 * Agentforce action: resolves a record's Salesforce Id from its object API name
 * and its Name field value. Intended for use before other actions that need a
 * record Id (e.g., update, lookup, or shipping actions).
 */
global with sharing class GetRecordIdAction {

    /** Input wrapper: identifies which record to find. */
    global class Request {
        @InvocableVariable(
            label='Object API Name'
            description='The API name of the Salesforce object to search, e.g. Account, Contact, Opportunity, or a custom object like Shipment__c. Use the exact API name, not the plural or display label.'
            required=true
        )
        global String objectApiName;

        @InvocableVariable(
            label='Record Name'
            description='The value of the record\'s Name field to search for, e.g. "Acme Corporation". Must be an exact match. Do not include the object type or extra words.'
            required=true
        )
        global String recordName;
    }

    /** Output wrapper: the lookup result. */
    global class Response {
        @InvocableVariable(
            label='Record Id'
            description='The 15/18-character Salesforce Id of the matching record, returned as text. Empty if no record was found, the inputs were invalid, or an error occurred. Pass this value to other actions that require a record Id.'
        )
        global String recordId;

        @InvocableVariable(
            label='Summary Message'
            description='A short human-readable status of the lookup: whether a record was found, not found, the input was invalid, or an error occurred. Use this to explain the outcome to the user when Record Id is empty.'
        )
        global String summaryMessage;
    }

    @InvocableMethod(
        label='Get Record Id'
        description='Finds the Salesforce record Id for a record when you know its object API name and its exact Name (e.g. find the Id of the Account named "Acme Corporation"). Use this whenever a record Id is needed but the user has only provided a record name. Returns the first match only; returns an empty Id with an explanatory message if nothing is found.'
    )
    global static List<Response> getRecordId(List<Request> inputs) {
        List<Response> results = new List<Response>();

        for (Request input : inputs) {
            Response result = new Response();

            if (String.isBlank(input.objectApiName) ||
                String.isBlank(input.recordName)) {
                result.summaryMessage = 'Object API name and record name are both required.';
                results.add(result);
                continue;
            }

            Schema.SObjectType objectType =
                Schema.getGlobalDescribe().get(input.objectApiName);

            if (objectType == null) {
                result.summaryMessage = 'Object "' + input.objectApiName + '" was not found.';
                results.add(result);
                continue;
            }

            String objectName = objectType.getDescribe().getName();
            String recordName = input.recordName;

            String query =
                'SELECT Id FROM ' + objectName +
                ' WHERE Name = :recordName LIMIT 1';

            try {
                List<SObject> records = Database.query(query);
                if (!records.isEmpty()) {
                    result.recordId = (String) records[0].get('Id');
                    result.summaryMessage = 'Found ' + objectName + ' record "' + recordName + '".';
                } else {
                    result.summaryMessage = 'No ' + objectName + ' record named "' + recordName + '" was found.';
                }
            } catch (Exception e) {
                result.summaryMessage = 'Error occurred while querying record: ' + e.getMessage();
            }

            results.add(result);
        }

        return results;
    }
}