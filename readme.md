Hey, 
This is the T&C template generator. In simple terms, it replaces the content of the template with the provided data at the appropriate places. 

## Prerequisites

Before running the script, ensure that you have the following:

- Ruby installed on your machine.
- A template file containing the T&C document structure with placeholder tags.
- A dataset file in JSON format, specifying clauses and sections with corresponding IDs and text.

## Usage
1. Clone the repository to your local machine:
```bash
git clone <repository_url>
cd <repository_directory>
ruby tcgenerator.rb -t <template_file> -d <dataset_file>
```

Replace <template_file> with the path to your template file and <dataset_file> with the path to your dataset file.
-t <template_file>: Specify the path to the template file.
-d <dataset_file>: Specify the path to the dataset file in JSON format.

The script with then take the template file and then replace the [CLAUSE-] && [SECTION-] parts inside the file with the appropriate data from the the dataset file. 
The generated T&C document will be saved in the file named T&C-Document.txt in the same directory as the script.


### Format of the dataset file

```bash
{
	'clauses': {
		id: "1", text: "Hello",
		id: "2", text: "world",
		...
	},
	'sections': {
		id: "1", clauses_ids: ["1", "2"]
		...
	}
}
```


### Format of the template file
```bash
A T&C Document
This document is made of plaintext.
Is made of [CLAUSE-3].
Is made of [CLAUSE-4].
Is made of [SECTION-1].
Your legals.
```

## Test Cases

For the test cases, There is a separate folder with rspec test cases in it named as **spec**.. By staying in the root folder, run this command to initiate the test cases

```bash
rspec ./spec/tcgenerator_spec.rb
```

**The root folder contains all the necessary files required to run and verify the tests. Do not Delete it. **	