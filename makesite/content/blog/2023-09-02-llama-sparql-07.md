<!-- title: llama_index SPARQL Notes 07 -->

Ok, time to attack the bits listed at the end of yesterday's [post](https://hyperdata.it/blog/llama-sparql-06/).

Break time. Made some progress, but got a bit distracted starting a [master plan](https://github.com/danja/nlp/blob/main/GraphRAG/goal.md). Pretty much than same as I'd already put in the [GraphRAG doc](https://github.com/danja/nlp/tree/main/GraphRAG), but expanded a bit, more background, hopefully a better explanation for folks that occupy other Venn diagrams.

export PYTHONPATH=$PYTHONPATH:/home/danny/AI/LIBS-under-dev/llama_index

Added extra logging to `nebulagraph.py`, just markers on functions defined in types.py are being called -

```
logging.basicConfig(filename='loggy.log', filemode='w', level=logging.INFO)
logger = logging.getLogger(__name__)
logger.info('nebulagraph HERE')
...
logger.info('#### nebulagraph client(self) called')
```

After running `python graph-rag-nebulagraph-minimal.py`, what was in loggy.log (in the dir I ran from) :

```
INFO:llama_index.graph_stores.nebulagraph:HERE
INFO:llama_index.indices.loading:Loading all indices.
INFO:llama_index.indices.loading:Loading all indices.
INFO:llama_index.graph_stores.nebulagraph:#### get_schema called
```

Ok, that's a start. For a bit more coverage, I'll do the same to `simple.py` and the skeletal `sparql.py`.

```
INFO:llama_index.graph_stores.nebulagraph:nebulagraph HERE
INFO:llama_index.graph_stores.simple:simple HERE
INFO:llama_index.indices.loading:Loading all indices.
INFO:llama_index.indices.loading:Loading all indices.
INFO:llama_index.graph_stores.nebulagraph:#### nebulagraph get_schema called
```
