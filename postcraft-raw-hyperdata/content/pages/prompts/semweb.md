You are an expert on Semantic Web technologies. You give short, concise responses to question. If you don't know the answer, first look for relevant online resources. If you can't find the answer, tell me what you need to know. Take your time, search as many times as necessary until you are convinced you've done all you can.
I would like to extend the ontology linked with any terms that might be necessary for working with kanban boards. There may be existing terms elsewhere that may be used directly or through subclassing etc.
The vocabulary to extend is at : https://hyperdata.it/xmlns/project/
A description of Kanban is at : https://www.atlassian.com/agile/kanban/boards
A list of core ontologies to consider is in the JSON-LD at : https://schema.org/version/latest/schemaorg-current-http.jsonld
Please generate definitions for every new term that might be useful in Turtle syntax. Include label, description and any relevant class and property relationships with existing terms. Use RDFS, OWL, SKOS and data cube terms as appropriate, aiming to give precise definitions of any new terms.

Now review the turtle you have created. For each of the terms you have prefixed 'Kanban', please generate a more generic term in the context of project management. Then incorporate ideas from the Eisenhower matrix and derived systems. Modify the vocabulary to include the terms that are suggested by this. Review what you have and add any more terms from owl and rdfs that make the meanings more precise. Save another simple markdown list of terms and a file in Turtle format to /mnt/data zip all the files together and provide me with a download link

Here is part of a JSON-LD file that lists vocabularies. Please step through it one URL at a time, get the RDF in whatever format is available and check for any terms that may be relevant to project management. For each vocabulary save a file in /mnt/data/ named as the prefix given for the namespace, giving definitions of the terms in Turtle format.
{
"@context": {
"brick": "https://brickschema.org/schema/Brick#",
"csvw": "http://www.w3.org/ns/csvw#",
"dc": "http://purl.org/dc/elements/1.1/",
"dcam": "http://purl.org/dc/dcam/",
"dcat": "http://www.w3.org/ns/dcat#",
"dcmitype": "http://purl.org/dc/dcmitype/",
"dcterms": "http://purl.org/dc/terms/",
"doap": "http://usefulinc.com/ns/doap#",
"foaf": "http://xmlns.com/foaf/0.1/",
"odrl": "http://www.w3.org/ns/odrl/2/",
"org": "http://www.w3.org/ns/org#",
"owl": "http://www.w3.org/2002/07/owl#",
"prof": "http://www.w3.org/ns/dx/prof/",
"prov": "http://www.w3.org/ns/prov#",
"qb": "http://purl.org/linked-data/cube#",
"rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
"rdfs": "http://www.w3.org/2000/01/rdf-schema#",
"schema": "http://schema.org/",
"sh": "http://www.w3.org/ns/shacl#",
"skos": "http://www.w3.org/2004/02/skos/core#",
"sosa": "http://www.w3.org/ns/sosa/",
"ssn": "http://www.w3.org/ns/ssn/",
"time": "http://www.w3.org/2006/time#",
"vann": "http://purl.org/vocab/vann/",
"void": "http://rdfs.org/ns/void#",
"xsd": "http://www.w3.org/2001/XMLSchema#"
}
}
