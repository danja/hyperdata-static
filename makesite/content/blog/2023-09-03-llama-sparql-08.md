<!-- title: llama_index SPARQL Notes 07 -->

Continuing from yesterday, log-probing `modulagraph.py`

- sudo /usr/local/nebula/scripts/nebula.service start all
- cd ~/AI/nlp/GraphRAG/src

While added logger probes, having another look at functions in `modulagraph.py`, I should implement in `sparql.py`. They don't look complicated in what they do, but the shape of the data structures returned is confusing.

```
    def client(self) -> Any:
        self._session_pool
```

Not really sure there, the sparqlwrapper clients aren't reusable, maybe return a generator functions? need to look at the other `graph_store` implementations.

```
    def get(self, subj: str) -> List[List[str]]:
```

I suspect that'll be like `SELECT DISTINCT ?p ?o WHERE { <subj> ?p ?o }`

    https://adamj.eu/tech/2021/07/06/python-type-hints-how-to-use-typing-cast/

```
    def get_rel_map(
        self, subjs: Optional[List[str]] = None, depth: int = 2
    ) -> Dict[str, List[List[str]]]:
        """Get rel map."""
        # We put rels in a long list for depth>= 1, this is different from
        # SimpleGraphStore.get_rel_map() though.
        # But this makes more sense for multi-hop relation path.
```

Confusing. But this calls `get_flat_rel_map` which has a handy comment :

```
        # The flat means for multi-hop relation path, we could get
        # knowledge like: subj -rel-> obj -rel-> obj <-rel- obj.
        # This type of knowledge is useful for some tasks.
        # +-------------+------------------------------------+
        # | subj        | flattened_rels                     |
        # +-------------+------------------------------------+
        # | "player101" | [95, "player125", 2002, "team204"] |
        # | "player100" | [1997, "team204"]                  |
        # ...
        # +-------------+------------------------------------+
```

```
    def upsert_triplet(self, subj: str, rel: str, obj: str) -> None:
```

I _think_ the implementation for NebulaGraph makes this look trickier than it is. A templated SPARQL `INSERT` block is probably whaqt's needed.

```
    def delete(self, subj: str, rel: str, obj: str) -> None:
```

Same approach as `upsert_triplet`?

```
    def query(self, query: str, param_map: Optional[Dict[str, Any]] = {}) -> Any:
```

Hmm, the param_map looks painful.
This function calls :

```
    def execute(self, query: str, param_map: Optional[Dict[str, Any]] = {}) -> Any:
```

No really sure how that operates...

I'm not sure how useful the log statements I've added will be with the data structures, I've only got `str(structure)`, some may well need more unrolling.

Ok, try that (without any calls to OpenAI API) :

- sudo /usr/local/nebula/scripts/nebula.service start all
- cd ~/AI/nlp/GraphRAG/src
- export PYTHONPATH=$PYTHONPATH:/home/danny/AI/LIBS-under-dev/llama_index
- python graph-rag-nebulagraph-minimal.py

Runs ok, nice :

```
INFO:llama_index.graph_stores.nebulagraph:get_schema() schema:
Node properties: [{'tag': 'entity', 'properties': [('name', 'string')]}]
Edge properties: [{'edge': 'relationship', 'properties': [('relationship', 'string')]}]
Relationships: ['(:entity)-[:relationship]->(:entity)']
```

Hmm. How best to express the schema in RDF?
RDFS is the obvious choice. This current version absolutely won't be a general solution so the schema should be associated with the (`guardians`) graph. OWL has ontology descriptions..? TODO re-read specs.

Uncommented some of the calls in `graph-rag-nebulagraph-minimal.py` that depend on OpenAI API, added a few log statements. Added API key. I've probably not included all the blocks of code needed for this to work end-to-end, but give it a go.

> OpenAI API credit balance $0.21

Running...

```
 raise openai.error.AuthenticationError(
openai.error.AuthenticationError: No API key provided. You can set your API key in code using 'openai.api_key = <API-KEY>', or you can set the environment variable OPENAI_API_KEY=<API-KEY>). If your API key is stored in a file, you can point the openai module at it with 'openai.api_key_path = <PATH>'. You can generate API keys in the OpenAI web interface. See https://platform.openai.com/account/api-keys for details.
```

Strange, I had `os.environ["OPENAI_API_KEY"] = "..."`. Added `openai.api_key = "..."`

Oops, `NameError: name 'openai' is not defined. Did you mean: 'OpenAI'?`

`import openai`

Also uncommented text-to-NebulaGraphCypher bits.

Ok, failed on :

```
  File "/home/danny/AI/LIBS-under-dev/llama_index/llama_index/graph_stores/nebulagraph.py", line 632, in query
    logger.info('param_map = '+param_map)
                ~~~~~~~~~~~~~~^~~~~~~~~~
TypeError: can only concatenate str (not "dict") to str
```

log got as far as :

```
#### nebulagraph query called
INFO:llama_index.graph_stores.nebulagraph:query =
MATCH (p:`entity`)-[:relationship]->(m:`entity`) WHERE p.`entity`.`name` == 'Peter Quill'
RETURN p.`entity`.`name`;
```

tweaked -

```
        # logger.info('param_map = '+param_map)
        logger.info('param_map = ')
        for key, value in param_map.items():
            logger.info(key + ' = '+value)

```

Good-good, at command line got :

```
python graph-rag-nebulagraph-minimal.py
Graph Store Query:

MATCH (p:`entity`)-[:relationship]->(m:`entity`) WHERE p.`entity`.`name` == 'Peter Quill'
RETURN p.`entity`.`name`;
Graph Store Response:
{'p.entity.name': ['Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill', 'Peter Quill']}
Final Response:

Peter Quill is a character in the Marvel Universe. He is the son of Meredith Quill and Ego, and the half-brother of Gamora. He was raised by his mother on Earth until he was abducted by aliens at the age of ten. He was raised by the Ravagers, a group of space pirates, and eventually became their leader. He is also known as Star-Lord.
```

Only a little more in log :

```
#### nebulagraph get_schema called
INFO:llama_index.graph_stores.nebulagraph:get_schema() schema:
Node properties: [{'tag': 'entity', 'properties': [('name', 'string')]}]
Edge properties: [{'edge': 'relationship', 'properties': [('relationship', 'string')]}]
Relationships: ['(:entity)-[:relationship]->(:entity)']

INFO:__main__:#### 5.2
INFO:__main__:#### 5.3
INFO:__main__:#### 6.1
INFO:llama_index.graph_stores.nebulagraph:
#### nebulagraph query called
INFO:llama_index.graph_stores.nebulagraph:query =
MATCH (p:`entity`)-[:relationship]->(m:`entity`) WHERE p.`entity`.`name` == 'Peter Quill'
RETURN p.`entity`.`name`;
INFO:llama_index.graph_stores.nebulagraph:param_map =
INFO:__main__:#### 6.2
```

Looks like it's first querying for all the subjects, then using those to get all property, objects.

> Credit balance $0.20

Boo! VSCode hung when I was trying to rename a file. For a clean slate I rebooted. Browser opened with :

> Credit balance $0.15

Commented out the text-to-NebulaGraphCypher bits again.

So next, attacking `sparql.py` again (last time was with ChatGPT helping, only served to confuse me) :

- figure out how to represent the schema
- code for upload/getting it

The bits that use sparqlwrapper I'll put in helper functions so connection can be tested independently.
