<!-- title: llama_index SPARQL Questions -->

Immediate goal is to recreate Wey's Graph RAG demo but using a SPARQL store rather than NebulaGraph.

I'm running it as [graph-rag-sparql-minimal.py](https://github.com/danja/nlp/blob/main/GraphRAG/src/graph-rag-sparql-minimal.py). The in-progress [sparql.py](https://github.com/danja/llama_index/blob/add-sparql/llama_index/graph_stores/sparql.py) (`rels()` will be called from `get_rel_map()`).

I've got data going to the store _something like it should_ using `graph_store.upsert()`. Data coming back from calls to `graph_store.get_rel_map()` that appears to be _more or less_ the right shape. But an issue with each I would appreciate advice on.

1. Batching data

   Right now I've set up INSERT queries to add triplets (as RDF triples) one at a time to the store. It's _really_ inefficient because each has to be wrapped in a query skeleton and POSTed over HTTP. I imagine some kind of batch handling is already implemented somewhere, but I couldn't find anything I understood. It isn't essential right now, but if there is something, pointers?

2. Loops in graph data

   This is a breaking issue for me right now. I'm sure I can sort it out, but a little more knowledge should make that quicker :)
   So at some point the data is fed through `llama_index/llama_index/response_synthesizers/tree_summarize.py`.
   I get `RecursionError: maximum recursion depth exceeded in comparison`, so seems likely there's a loop somewhere. Short term, some kind of check+delete should fix that (algorithm hunt time). But more generally, what is the situation with graphs & loops? Is this an underlying feature of the way Graph RAG operates, or is it just an implementation issue?

---
