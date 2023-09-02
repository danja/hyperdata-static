<!-- title: llama_index SPARQL Notes 06 -->

grr, forgot again,

**sudo /usr/local/nebula/scripts/nebula.service start all**

So far `nebula-rdf-dump.py` is making quasi-Turtle triples from the NebulaGraph data. If I provide some namespace prefixes that'll make it proper.
`er` for my minimal Entity-Relationship vocab, use the `base` to complete the instance data URIs.

Easy one, prepend it with :

```
@prefix er: <http://purl.org/stuff/er#> .
@base <http://purl.org/stuff/data> .
```

Using f formatting in the code, run...

Check :

- rapper -c -i turtle guardians.ttl

```
rapper: Parsing URI file:///home/danny/AI/nlp/GraphRAG/nebula-sparql-utils/guardians.ttl with parser turtle
rapper: Parsing returned 2380 triples
```

Good-o.

Now to figure out the SPARQL to pust the stuff to the store.

Different prefix syntax, https://www.w3.org/TR/sparql11-query/#syntaxTerms

```
BASE <http://purl.org/stuff/data>
PREFIX er:  <http://purl.org/stuff/er#>
```

What queries are needed?

https://www.w3.org/TR/sparql11-update

```
CREATE ( SILENT )? GRAPH IRIref

DROP  ( SILENT )? (GRAPH IRIref | DEFAULT | NAMED | ALL )

INSERT DATA  QuadData
```

> where QuadData are formed by TriplesTemplates, i.e., sets of triple patterns, optionally wrapped into a GRAPH block.

Ok, so here I guess an update call for :

```
CREATE GRAPH <http://purl.org/stuff/guardians>
```

```
{prefixes}
INSERT DATA {
    GRAPH <http://purl.org/stuff/guardians>
       { {triples} } }
```

ew, need to escape {} ... nah, less thought needed to concatenate with +

Good-oh, sparqlwrapper has an update example https://sparqlwrapper.readthedocs.io/en/latest/main.html#sparql-update-example (with auth)

```
danny@danny-desktop:~/AI/nlp/GraphRAG/nebula-sparql-utils$ python nebula-rdf-dump.py
Update succeeded

Update succeeded
```

Looking good so far...check data at

https://fuseki.hyperdata.it/#/dataset/llama_index-test/query

```
SELECT ?s ?p ?o WHERE {
    GRAPH <http://purl.org/stuff/guardians> {
            ?s ?p ?o
        }
}
LIMIT 50
```

Nothing!!!

Tried the SPARQL as dumped to file, then SELECT as above - looks fine.

```
DROP GRAPH <http://purl.org/stuff/guardians>
```

check code around sparqlwrapper...

Hmm, can you reuse clients (create graph & insert)? Apparenty not. Added code to make a new one - it worked!

**yardstone reached!**

Tired, but looking at next steps -

```
from llama_index.storage.storage_context import StorageContext
from llama_index.graph_stores import NebulaGraphStore

...

%pip install nebula3-python ipython-ngql

os.environ['NEBULA_USER'] = "root"
os.environ['NEBULA_PASSWORD'] = "nebula" # default password
os.environ['NEBULA_ADDRESS'] = "127.0.0.1:9669" # assumed we have NebulaGraph installed locally

space_name = "guardians"
edge_types, rel_prop_names = ["relationship"], ["relationship"] # default, could be omit if create from an empty kg
tags = ["entity"] # default, could be omit if create from an empty kg

graph_store = NebulaGraphStore(
    space_name=space_name,
    edge_types=edge_types,
    rel_prop_names=rel_prop_names,
    tags=tags,
)
storage_context = StorageContext.from_defaults(graph_store=graph_store)
```

Looks like most of what StorageContext does is done through the graph store implementations, eg. SimpleGraphStore

---

Ok, I reckon next, going back to putting tracer logging in NebulaGraphStore

1. pull out a bit of code from Notebook that uses `nebulagraphstore.py` but not the OpenAI API
2. make sure it works!
3. point python at my dev llama_index
4. add logging points to dev llama_index `nebulagraphstore.py`

currently at :

~/.local/lib/python3.11/site-packages/llama_index

noo...that has a single subdir `readers`

- locate document_summary.py
  /home/danny/.local/pipx/venvs/llama-index/lib/python3.11/site-packages/llama_index/data_structs/document_summary.py

Ok, this may or may not work - a symlink
