# Autopilote API Coldfusion Wrapper

A Coldfusion / Lucee wrapper for [Autopilot](https://autopilothq.com/)'s [REST API](http://docs.autopilot.apiary.io/).

Example:

```coldfusion
autopilot = src.autopilot("c5359558cf764d17bc49f13a87e8a56e");

contact={};
contact["FirstName"]="John";
contact["LastName"]="Smith";
contact["Email"]="john.smith@mail.com";

response=autopilot.contact.upsert(contact);

if (!structKeyExists(response, "error") {
		writeDump(reponse);  
} else {
		writeOutput("<h1>Error</h1>");
		writeDump(reponse);  
}

```

### Quick links:
* [Install Testing Pre-requisite](#install-testing-pre-requisite)
* [Usage](#usage)
	* [Contacts](#contacts)
		* [Upsert Contact](#upsert-contact)(s)
		* [Get Contact](#get-contact)
		* [Delete Contact](#delete-contact)
		* [Unsubscribe Contact](#unsubscribe-contact)
	* [Lists](#lists)
		* [List Lists](#list-lists)
		* [Insert List](#insert-list)
		* [List Contacts in List](#list-contacts-in-list)
		* [Check if Contact is in List](#check-if-contact-is-in-list)
		* [Add Contact to List](#add-contact-to-list)
		* [Remove Contact from List](#remove-contact-from-list)
	* [Journeys](#journeys) (via triggers)
		* [Add Contact to Journey](#add-contact-to-journey)
		* [List Journeys with Triggers](#list-journeys-with-triggers)
	* [Account](#account)
* [Ressource](#ressource)
* [License](#license)


## Install Testing Pre-requisites

Unit testing is done with the old lady [mxunit](https://github.com/mxunit/mxunit) and optionaly via [mxunit-watch](https://github.com/atuttle/mxunit-watch)

To use it you will require:

 * Lucee via [CommandBox](http://www.ortussolutions.com/products/commandbox) ( Command Line Interface (CLI) for Coldfusion developers)
 * [NodeJS](https://nodejs.org/)
 	 

### Quick install on OSX

1. Clone this repository
2. Install Command Box

```bash
brew install http://downloads.ortussolutions.com/ortussolutions/commandbox/commandbox.rb
```
3. Install Nodes Packages

```bash 
npm install
```

4. Start Server 
```bash 
npm start
```
6. Testing Watcher
```bash 
npm test
```
To stop server
```bash 
npm stop
```

## Usage

Begin by initializing with your API key:

	autopilot = src.autopilot("c5359558cf764d17bc49f13a87e8a56e");

Now you will be able to interact with Autopilot resources as described below.

### Contacts

#### Upser Contact(s)

* Method `autopilot.contact.upsert(data);`
* Return `struct`
* Parameters:

	| Name       | Type                | Required | Description                                                                           |
	|------------|---------------------|----------|---------------------------------------------------------------------------------------|
	| `data`     | `struct` or `array` | Yes      | The contact data to be upserted. If an array is provided, a bulk upsert is performed. |

Also available:

* `autopilot.contact.add(contact);` 
* `autopilot.contact.update(contact);`
* `autopilot.contact.bulk(contacts);` 


#### Get Contact

* Method `autopilot.contact.get(contact_id_or_email);`
* Return `struct`
* Parameters:

	| Name       | Type                | Required | Description                                                                           |
	|------------|---------------------|----------|---------------------------------------------------------------------------------------|
	| `contact_id_or_email`     | `string` | Yes      | Either the Autopilot `contact_id` or the contact's email address |

#### Delete Contact

* Method `autopilot.contact.delete(contact_id_or_email);`
* Return `boolean` or `struct` when error
* Parameters:

	| Name       | Type                | Required | Description                                                                           |
	|------------|---------------------|----------|---------------------------------------------------------------------------------------|
	| `contact_id_or_email`     | `string` | Yes      | Either the Autopilot `contact_id` or the contact's email address |

#### Unsubscribe Contact

* Method `autopilot.contact.unsubscribe(data);`
* Return `boolean` or `struct` when error
* Parameters:

	| Name       | Type                | Required | Description                                                                           |
	|------------|---------------------|----------|---------------------------------------------------------------------------------------|
	| `contact_id_or_email`     | `string` | Yes      | Either the Autopilot `contact_id` or the contact's email address |


### Lists

#### List Lists

* Method `autopilot.list.list();`
* Return `boolean` or `struct` when error
* Parameters: none

#### Create List

* Method `autopilot.list.create();`
* Return `string` list_id or `struct` when error
* Parameters:

	| Name       | Type                | Required | Description                                                                           |
	|------------|---------------------|----------|---------------------------------------------------------------------------------------|
	| `name`     | `string` | Yes      | The name for a new list. |
	
#### List Contacts in List

* Method `autopilot.list.contacts();`
* Return `array` of contact 
* Parameters:

	| Name       | Type                | Required | Description                                                                           |
	|------------|---------------------|----------|---------------------------------------------------------------------------------------|
	| `list_id`     | `string` | Yes      | The `id` of the list to query. |
		| `bookmark` | `string`   | No       | If there are more contacts on the list than have been returned, the bookmark will allow you to access the next group of contacts. |
	
#### Check if Contact is in List

* Method `autopilot.list.has();`
* Return `boolean` or `struct` when error
* Parameters:

	| Name       | Type                | Required | Description                                                                           |
	|------------|---------------------|----------|---------------------------------------------------------------------------------------|
	| `list_id`     | `string` | Yes      | The `id` of the list to query. |
		| `contact_id_or_email` | `string`   | Yes       | Either the Autopilot `contact_id` or the contact's email address. |
		
#### Add Contact to List

* Method `autopilot.list.add();`
* Return `boolean` or `struct` when error
* Parameters:

* Parameters:

	| Name        | Type       | Required | Description                                                       |
	|-------------|------------|----------|-------------------------------------------------------------------|
	| `listId`    | `string`   | Yes      | The `id` of the list to query.                                    |
	| `contact_id_or_email` | `string`   | Yes      | Either the Autopilot `contact_id` or the contact's email address. |

#### Remove Contact from List

* Method `autopilot.list.remove();`
* Return `boolean` or `struct` when error
* Parameters:

	| Name        | Type       | Required | Description                                                       |
	|-------------|------------|----------|-------------------------------------------------------------------|
	| `listId`    | `string`   | Yes      | The `id` of the list to query.                                    |
	| `contact_id_or_email` | `string`   | Yes      | Either the Autopilot `contact_id` or the contact's email address. |


### Journeys (via triggers)
#### Add Contact to Journey

* Method `autopilot.journey.add();`
* Return `boolean` or `struct` when error
* Parameters:

	| Name        | Type       | Required | Description                                                          |
	|-------------|------------|----------|----------------------------------------------------------------------|
	| `triggerId` | `string`   | Yes      | The `id` of the trigger associated with the Journey we're adding to. |
	| `contactId` | `string`   | Yes      | Either the Autopilot `contact_id` or the contact's email address.    |
	
#### List Journeys with Triggers

* Method `autopilot.journey.list();`
* Return `array` or `struct` when error
* Parameters:

	| Name        | Type       | Required | Description                                                          |
	|-------------|------------|----------|----------------------------------------------------------------------|
	| `callback`  | `function` | No       | A callback function to be executed upon completion.                  |
### Account
Not implemented

## Resources

[Autopilot REST API Documentation](http://docs.autopilot.apiary.io/)
[Node.js wrapper](https://github.com/Torchlite/autopilot-api)

### Notes
The old lay (mxunit) is patched by https://github.com/mxunit/mxunit/pull/43
Structure and code base inspired from [aws-cfml](https://github.com/jcberquist/aws-cfml)

### Licences
This repository is licensed under the The MIT License (MIT). See [LICENSE](license) for details.
