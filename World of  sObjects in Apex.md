
# World of sObjects in Apex

### What are sObjects?
In Apex, sObjects(short for "salesforce objects") represent records in the Salesforce database. They are essentially instances of a particular object type, such as standard objects provided by Salesforce (e.g., Account, Contact, Opportunity) or custom objects created by users to meet specific business needs. sObjects can store data and are at the core of data manipulation and retrieval in Salesforce.

> Because Apex is tightly integrated with the database, you can access Salesforce records and their fields directly from Apex. Each Salesforce record is represented as an sObject before it is inserted into Salesforce. Likewise, when persisted records are retrieved from Salesforce, they’re stored in an sObject variable.

Standard and custom object records in Salesforce map to their sObject types in Apex.

### API Names for sObjects and their Fields
In Apex, both `standard` and `custom sObjects`, as well as their fields, are referenced using their unique API names. The API name serves as a unique identifier for each object and field in Salesforce. It allows developers to programmatically access and manipulate the data stored in those objects and fields.

* **sObject API Names:**
    * Standard Objects: Standard objects provided by Salesforce, such as Account, Contact, and Opportunity, have predefined API names that are consistent across all Salesforce orgs. For example, the API name for the Account object is "Account", and the API name for the Contact object is "Contact".
    * Custom Objects: Custom objects created by users also have API names, which are specified when the object is created. The API name for a custom object follows the format "CustomObjectName__c". For example, if you create a custom object called "Project", its API name would be "Project__c".
* **Field API Names:**
    * Standard Fields: Standard objects come with predefined fields, and each field has a unique API name. For instance, the API name for the Name field of the Account object is "Name", and the API name for the Email field of the Contact object is "Email".
    * Custom Fields: Custom objects allow users to define custom fields, and each field is assigned a unique API name. The API name for a custom field follows the format "CustomFieldName__c". For example, if you create a custom field called "ProjectName" in the custom object "Project", its API name would be "ProjectName__c".

### Creating sObject for Stardard Objects
Salesforce provides a set of standard objects that are available by default in every Salesforce org. These objects serve common business purposes and come with predefined fields and functionality. Some examples of standard objects are:

* Account: Represents a company, organization, or individual with whom you have a business relationship.
* Contact: Represents an individual associated with an account.
* Opportunity: Represents a potential sale or pending deal with a customer.
* Lead: Represents a person or organization that may be interested in your products or services before they become an opportunity.
* Case: Represents a customer issue or question.
* and many more...
To work with standard objects in Apex, you can directly reference their corresponding sObject types, such as Account, Contact, Opportunity, etc. These types provide specific methods and properties tailored to each object's functionality.

#### Example: Creating a Standard sObject in Apex

1. Declare a variable of the appropriate sObject type to hold the data for the standard object record you want to create.

```apex
Account acc = new Account();
```
2. Assign values to the fields of the sObject. There are two ways of doing so. 
  * The fastest way to add fields is to specify them as name-value pairs inside the constructor.
  ```apex
  Account acc = new Account(Name='Acme Corporation', Phone='123-456-789');
  ```
  * Another way is using the dot notation.
  ```apex
  Account acc = new Account();
  acc.Name = 'Acme Corporation';
  acc.Phone = '123-456-7890';
  ```
3. Once you have set the necessary field values, you can perform operations on the sObject. Common operations include inserting the record into the database, updating existing records, or deleting records.
```apex
insert acc;
```

### Creating sObjects for Custom Objects
Custom objects in Salesforce are created by users to capture and manage data specific to their organization's needs. Unlike standard objects, custom objects are designed to accommodate unique business processes and can be fully customized with custom fields, relationships, and functionality.

When a custom object is created, Salesforce automatically generates an sObject type to represent that custom object in Apex. This type follows the naming convention CustomObjectName__c (e.g., CustomObject__c). You can use this type to interact with custom object records in Apex.

#### Example: Creating a Custom sObject in Apex

1. Declare a variable of the appropriate sObject type to hold the data for the custom object record you want to create. The variable should be of the form CustomObject__c, where "CustomObject" is the API name of the custom object.

```apex
Project__c project = new Project__c();
```
2. Assign values to the fields of the sObject. There are two ways of doing so. 
  * The fastest way to add fields is to specify them as name-value pairs inside the constructor.
  ```apex
  Project__c project = new Project__c(Name='Sample Project', Description__c='This is a sample project.');
  ```
  * Another way is using the dot notation.
  ```apex
  project.Name = 'Sample Project';
  project.Description__c = 'This is a sample project.';
  ```
3. Once you have set the necessary field values, you can perform operations on the sObject. Common operations include inserting the record into the database, updating existing records, or deleting records.
```apex
insert project;
```

### Working with Generic sObjects Data Type

Generic sObjects in Apex refer to the use of the sObject type, which represents any Salesforce object dynamically. Unlike specific sObject types (standard or custom), the sObject type allows you to work with multiple object types without knowing the specific object at compile-time. This provides flexibility when dealing with unknown or dynamic data structures.

Here are the key aspects of working with generic sObjects in Apex:

1. **Dynamic Field Access:** With generic sObjects, you can access fields dynamically using the get and put methods. The get method retrieves the value of a field based on its API name, while the put method sets the value of a field dynamically.
```apex
sObject obj = new Account();  // Instantiate a generic sObject as an Account

// Accessing fields dynamically
String accountName = (String) obj.get('Name');
obj.put('Phone', '123-456-7890');

```
2. **Querying and Modifying Records:** Generic sObjects can be used to query records dynamically using SOQL (Salesforce Object Query Language) queries. The query results are returned as a List<sObject>, allowing you to iterate over the records and perform operations dynamically.
```apex
List<sObject> records = [SELECT Name, Phone FROM Account LIMIT 10];  // Querying Account records dynamically

for (sObject obj : records) {
    String accountName = (String) obj.get('Name');
    obj.put('Phone', '987-654-3210');
    // Perform other operations on the fields as needed
}
```
3. **Type Casting and Field Validation:** Since the sObject type does not provide compile-time checks, you need to perform type casting when working with specific field values. It is important to validate the field types to avoid runtime errors.
```apex
sObject obj;
obj = new Account(Name='Test', Phone='123-456-789');
Account acc = (Account)obj;
System.debug(acc);

obj = new Student__c(Name='Test', High_School_Phone__c='098-765-433');
Student__c std = (Student__c)obj;
System.debug(std);
```

However, Working with generic sObjects has some limitations compared to specific sObject types. You lose some of the compile-time checks and type-specific methods and properties available on specific sObject types. Additionally, the use of generic sObjects can make code less readable and may require additional error handling and validation.
