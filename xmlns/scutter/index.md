# Scutter Vocabulary

**Terms useful for a RDF-friendly Web Crawler/Data Augmenter**

*Work in progress 2021-05-23, changes probable due to trying it and aligning with other vocabs, esp. [HTTP Vocabulary in RDF 1.0](https://www.w3.org/TR/HTTP-in-RDF10/) and [schema.org](https://schema.org/)*

Terms derived from [ScutterVocab](https://web.archive.org/web/20051029014923/http://rdfweb.org/topic/ScutterVocab), summarised, tweaked *(2005 archived copy of http://rdfweb.org/topic/ScutterVocab)* :

* **Context** - the "shadow resource" of a source document
  * **origin** - with an ```rdfs:seeAlso``` to the source document - where the source document was initially discovered, usually the URI of another document but may be an event triggered by a user, e.g. by manual submission
  * **source** - the URI of the source document itself, a subproperty of ```dcterms:references```
  * **fetch** - points to a **Fetch**
  * **latestFetch** - the most recent **Fetch**

* **Fetch** - *(noun)* represents a HTTP ```GET``` (or equivalent) event of the source document of a context
  * **status** - the HTTP status code returned by the ```GET```

* **Reason** - annotation of a Fetch, typically explaining failure

## Provisional changes/additions

* **state** - property of **Context** summarising system's current knowledge of that **Context**. One of *["queued", "live", "dead"]*
* **base64url** - property of **Context** providing an encoding of the source document's URL according to [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648#section-5)

Both of these are prompted by implementation considerations. Having the **state** of a **Context** in the store seems a simple way of tracking resources and allowing their display via SPARQL selection. (It is inelegant being mutable but seems reasonable pragmatically).

The purpose of **base64url** is to make it easy to give a **Context** a dereferenceable URL. For example a **Context** of ```http://example.org``` would have a **base64url** of ```"aHR0cDovL2V4YW1wbGUub3Jn"```. This would allow eg. ```http://hyperdata.it/aHR0cDovL2V4YW1wbGUub3Jn``` to be used to display the information about that context. Putting the value in the RDF will hopefully simplify the coding (TBD).


## Notes
**Model** - the original vocab uses a model in which "*All resources created to describe the actions and contents of a scutter and its store, should be anonymous resources*". For reasons given, that rule won't be used here.

**HTTP Vocab** - the [HTTP Vocabulary in RDF 1.0](https://www.w3.org/TR/HTTP-in-RDF10/)
W3C Working Group Note 2017 has significant overlap with **Fetch**.
