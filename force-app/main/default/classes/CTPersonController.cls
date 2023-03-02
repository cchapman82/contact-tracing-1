public with sharing class CTPersonController {
    
    public static String getToken(String mobileNo) {
        Blob value = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', value);
        return EncodingUtil.base64Encode(hash);
    }

    public static List<Person__c> getRecentHealthChalenges() {
        List<Person__c> persons = [SELECT Mobile__c, Id, Name, Health_Status__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC LIMIT 100];
        return persons;
    }

    public static List<Person__c> searchPeople(String searchTerm) {
        searchTerm = searchTerm + '%';
        List<Person__c> persons = [SELECT Mobile__c, Id, Name, Health_Status__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Name LIKE :searchTerm 
        OR Mobile__c LIKE :searchTerm OR Token__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC];
        return persons;
    }

    public static Person__c getPersonById(String personId) {
        List<Person__c> person = [SELECT Mobile__c, Id, Name, Health_Status__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Id =: personId];
        if (person != null && person.size() > 0) {
            return person[0];
        }
        return person[0];
    }

}