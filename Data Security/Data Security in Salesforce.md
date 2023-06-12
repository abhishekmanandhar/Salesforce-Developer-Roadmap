
# Manage the Data Access in Salesforce

### Data Security in Salesforce
Data security is a critical aspect of Salesforce, and it offers various features and mechanisms to ensure the protection and integrity of data stored in the platform. Salesforce provides a robust and layered approach to data security, encompassing various levels of protection and controls.

Salesforce offers a versatile sharing model that allows for assigning different data sets to specific user groups, striking a balance between security and convenience. This minimizes the risk of unauthorized access or data misuse while ensuring users have the necessary data access. 

Salesforce provides configurable security controls to determine user privileges for viewing, creating, editing, or deleting records and fields. Access can be configured at various levels such as organization-wide, object-level, field-level, or even at the individual record level. This flexible combination of security controls allows for efficient management of data access for a large number of users without the need for individual permission settings.

### Levels of Data Access
#### Organization Level Security
At the highest level, you can secure access to your organization by maintaining a list of authorized users, setting password policies, and limiting login access to certain hours and certain locations.

* **Maintain a list of authorized users:** At the organization level, Salesforce administrators can maintain a centralized list of authorized users. This ensures that only approved individuals have access to the Salesforce org. User management controls allow administrators to create, deactivate, and delete user accounts as needed, ensuring that only authorized personnel have access to the organization's data.
* **Set password policies:** Salesforce allows administrators to establish password policies at the organization level. These policies define the complexity requirements for user passwords, such as minimum length, inclusion of alphanumeric characters, and regular password expiration. By enforcing strong password policies, organizations enhance the overall security of user accounts and reduce the risk of unauthorized access.
![Password Policies](https://github.com/abhishekmanandhar/Salesforce-Developer-Roadmap/blob/main/Data%20Security/images/password%20policies.png)
* **Limit login to certain hours and locations:** Salesforce provides IP restrictions and login hours settings to control when and where users can log in to the organization's Salesforce org. Administrators can define trusted IP ranges or specific IP addresses from which users are allowed to log in. This restricts access to Salesforce from unauthorized networks or locations. Additionally, administrators can set login hours to specify the times during which users can access the system. These restrictions help protect against unauthorized access attempts and reduce the exposure of the organization's data.
![Login IP](https://github.com/abhishekmanandhar/Salesforce-Developer-Roadmap/blob/main/Data%20Security/images/login%20IP.png)
![Login Hours](https://github.com/abhishekmanandhar/Salesforce-Developer-Roadmap/blob/main/Data%20Security/images/login%20hours.png)

#### Object Level Security
Object-level security in Salesforce refers to the controls and permissions set at the level of individual objects or entities within the Salesforce platform. It determines what actions users can perform on specific objects, such as viewing, creating, editing, or deleting records. You can control object permissions using profiles and permission sets.

Profiles are a collection of settings and permissions that define the actions users can perform on objects and their associated records. Each profile is assigned to one or more users and governs their access to objects. With profiles, you can control object-level permissions, including read, create, edit, and delete access, for different sets of users.

Permission sets are used to extend or override the permissions granted by profiles. They allow for more granular control by providing additional permissions to specific users or groups. Permission sets can be assigned to users in addition to their profile, granting them access to specific objects or features not available in their profile.
