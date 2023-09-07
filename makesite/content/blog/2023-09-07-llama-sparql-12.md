<!-- title: llama_index SPARQL Notes 12 -->

```
cd ~/AI/nlp/GraphRAG/src
export PYTHONPATH=$PYTHONPATH:/home/danny/AI/LIBS-under-dev/llama_index
python /home/danny/AI/LIBS-under-dev/llama_index/tests/storage/graph_stores/test_sparql.py
```

That took a while but I now have results like :

```
{Peter Quill: [
                    'Peter Quill, -[was abducted from Earth]->, as a child',
                    'Peter Quill, -[is leader of]->, Guardians of the Galaxy',<-[are attacked by]-, Adam',
```

Ah, but as a string. Need to add a loop on the subjs and tweak data accumulation to conform to:

```
    def get_rel_map(
        self, subjs: Optional[List[str]] = None, depth: int = 2
    ) -> Dict[str, List[List[str]]]:
```

Hmm, I don't really understand that return shape. And I've overwritten the log that had it...

```
sudo /usr/local/nebula/scripts/nebula.service start all
cd ~/AI/nlp/GraphRAG/src
export PYTHONPATH=$PYTHONPATH:/home/danny/AI/LIBS-under-dev/llama_index
python graph-rag-nebulagraph-minimal.py
```

if nebulagraph.py, get_rel_map() :

```
        # We put rels in a long list for depth>= 1, this is different from
        # SimpleGraphStore.get_rel_map() though.
        # But this makes more sense for multi-hop relation path.
```

the results in the log look very like what's produced from SPARQL above. Ok, time to try it.

First, at https://fuseki.hyperdata.it/#/dataset/llama_index_sparql-test/query

```
DROP GRAPH <http://purl.org/stuff/guardians>
```

- python graph-rag-sparql-minimal.py

little char problem, ChatGPT time

Ah, SPARQL encoding different from Python on Spanish n with wibble

It _might_ now be putting what it should in the store (took a few minutes), but it crashes with :

```
  File "/home/danny/AI/LIBS-under-dev/llama_index/llama_index/response_synthesizers/tree_summarize.py", line 142, in get_response
    return self.get_response(
           ^^^^^^^^^^^^^^^^^^
  [Previous line repeated 980 more times]
  File "/home/danny/AI/LIBS-under-dev/llama_index/llama_index/response_synthesizers/tree_summarize.py", line 96, in get_response
    summary_template = self._summary_template.partial_format(query_str=query_str)
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/danny/AI/LIBS-under-dev/llama_index/llama_index/prompts/base.py", line 206, in partial_format
    return SelectorPromptTemplate(
           ^^^^^^^^^^^^^^^^^^^^^^^
...
RecursionError: maximum recursion depth exceeded in comparison
...
 File "pydantic/class_validators.py", line 337, in pydantic.class_validators._generic_validator_basic.lambda13
 ...
```

Hmm. A loop or just to big?

---

          PREFIX er:  <http://purl.org/stuff/er#>
            BASE <http://purl.org/stuff/data>

    SELECT DISTINCT ?rel1 ?obj1 ?rel2 ?obj2 WHERE {

    GRAPH <http://purl.org/stuff/guardians> {
        ?triplet a er:Triplet ;
            er:subject ?subject ;
            er:property ?property ;
            er:object ?object .

        ?subject er:value "Peter Quill"  .
        ?property er:value ?rel1 .
        ?object er:value ?obj1 .

    OPTIONAL {
        ?triplet2 a er:Triplet ;
            er:subject ?object ;
            er:property ?property2 ;
            er:object ?object2 .

        ?property2 er:value ?rel2 .
        ?object2 er:value ?obj2 .
    }}}

LIMIT 10
