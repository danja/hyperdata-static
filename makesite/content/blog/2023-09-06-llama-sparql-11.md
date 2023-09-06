<!-- title: llama_index SPARQL Notes 11 -->

WARNING:llama_index.graph_stores.nebulagraph:s =Peter Quill
WARNING:llama_index.graph_stores.nebulagraph:rel_map =

Ok, I want `rel_map` to take the subject, `Peter Quill`, call the SPARQL store and return something in this format :

{'Peter Quill': [
'Peter Quill, -[would return to the MCU]->, May 2021, <-[would return to the MCU]-, Peter Quill',
'Peter Quill, -[would return to the MCU]->, May 2021',
'Peter Quill, -[was raised by]->, a group of alien thieves and smugglers',
'Peter Quill, -[is leader of]->, Guardians of the Galaxy',
'Peter Quill, -[would return to the MCU]->, May 2021, <-[Gunn reaffirmed]-, Guardians of the Galaxy Vol. 3',
...

```

Hmm, it takes a list :

```

    def get_rel_map(
        self, subjs: Optional[List[str]] = None, depth: int = 2
    ) -> Dict[str, List[List[str]]]:

```

Looping through the list to build the query should work, but there might be a more elegant way. Whatever, start with a single subject.

If I build this up in :
```

llama_index/tests/storage/graph_stores/test_sparql.py

```
It make a good start to the test.

Probably unnecessary but I've added an `unescape_from_rdf` helper to `sparql.py` to revert the quote escaping that Turtle needed.

```

cd ~/AI/nlp/GraphRAG/src
export PYTHONPATH=$PYTHONPATH:/home/danny/AI/LIBS-under-dev/llama_index
python /home/danny/AI/LIBS-under-dev/llama_index/tests/storage/graph_stores/test_sparql.py

```

> urllib.error.HTTPError: HTTP Error 502: Proxy Error

Oops. Too many results? Check server...

That took me a long time, bit fiddly. But now :

```

results = graph_store.select_triplets('Peter Quill', 10)

```
is returning :
```

{'rel': {'type': 'literal', 'value': 'is leader of'}, 'obj': {'type': 'literal', 'value': 'Guardians of the Galaxy'}}
{'rel': {'type': 'literal', 'value': 'is half-human'}, 'obj': {'type': 'literal', 'value': 'half-Celestial'}}
{'rel': {'type': 'literal', 'value': 'was abducted from Earth'}, 'obj': {'type': 'literal', 'value': 'as a child'}}
{'rel': {'type': 'literal', 'value': 'was raised by'}, 'obj': {'type': 'literal', 'value': 'a group of alien thieves and smugglers'}}

```

Ok, so now I reckon I need SPARQL UNION (and possibly BIND) to get some <-[backwards]- bits.

Break time.

Hmm, I was playing around with the SPARQL, looks like this dataset (populated from `sparql.py`) is missing a few triples.
For now go with https://fuseki.hyperdata.it/#/dataset/llama_index-test/query which came from NebulaGraph.

Ok, this returns some things of the right shape, will do for now :
```

PREFIX er: <http://purl.org/stuff/er#>

BASE <http://purl.org/stuff/data>

SELECT DISTINCT ?subj ?rel ?obj ?rel2 ?obj2 WHERE {

    GRAPH <http://purl.org/stuff/guardians> {
        ?triplet a er:Triplet ;
            er:subject ?subject ;
            er:property ?property ;
            er:object ?object .

        ?subject er:value "Peter Quill"  .
        ?property er:value ?rel .
        ?object er:value ?obj .
    OPTIONAL {
            ?triplet2 a er:Triplet ;
            er:subject ?subject2 ;
            er:property ?property2 ;
            er:object ?object2 .

        ?subject2 er:value ?obj .
        ?property2 er:value ?rel2 .
        ?object2 er:value ?obj2 .
    }
    }

}

```

**Property paths!** D'oh! I'd forgotten about them. Probably useful here. https://www.w3.org/TR/sparql11-query/#propertypaths

But for now, get suitable output of `rel_map` from results of the above.

**ChatGPT**
Given the following example :

subj = 'Peter Quill'
rels = {'rel': {'type': 'literal', 'value': 'is leader of'}, 'obj': {'type': 'literal', 'value': 'Guardians of the Galaxy'}, 'rel2': {'type': 'literal', 'value': 'cannot heal'}, 'obj2': {'type': 'literal', 'value': 'Rocket'}}
arp = to_arrows(subj, rels)

write the function to_arrows so this will be the value of string arp :

'Peter Quill, -[would return to the MCU]->, May 2021, <-[Gunn reaffirmed]-, Guardians of the Galaxy Vol. 3'
**didnt really help**

Started doing it manually, now too tired. Night night.

---
I've used this (and almost identical in Java etc) _so often_, but have managed to forget :

> Logger.setLevel() specifies the lowest-severity log message a logger will handle, where debug is the lowest built-in severity level and critical is the highest built-in severity. For example, if the severity level is INFO, the logger will handle only INFO, WARNING, ERROR, and CRITICAL messages and will ignore DEBUG messages.

`:cat AI`
`:tag SPARQL`
`:tag LlamaIndex`
```
