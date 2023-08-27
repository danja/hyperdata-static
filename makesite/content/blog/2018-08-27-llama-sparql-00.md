<!-- title: llama_index-SPARQL notes 01 -->

> This is a continuation of notes from [GraphRAG](https://github.com/danja/nlp/tree/main/GraphRAG). I'm currently writing a SPARQL connector for llama_index, and jotting notes as I go along. My Wordpress install recently broke, but because a SPARQL-backed blog engine was on my TODO list I let it ride. But it occurred to me that an easy stopgap would be to use a minimal static blog/site builder as an interim fix (makesite.py fit the bill), use it for the GraphRAG notes too. **Nice layout with bells & whistles to follow!**

### Today

Implementing a naive SPARQL connector, just enough to replicate the functional of Wey Gu's original demo with a SPARQL store rather than NebulaGraph.

_I've read the books, but still my inclination on something like this would usually be to go straight to the implementation, only making tests when it (predictably) doesn't work. But my Python is weak and this codebase is new to me, so test-driven it is._

There don't appear to be any tests around the graph stores yet, so start against existing implementations, so, to build :

1. `llama_index/tests/graph_stores/test_simple.py`
2. `llama_index/tests/graph_stores/test_nebulagraph.py` - see how far I get, I probably won't understand what the helpers do, Wey Gu should be happy to improve
3. `llama_index/tests/graph_stores/test_sparql.py`
4. `llama_index/graph_stores/sparql.py`

for reference :

- `llama_index/graph_stores/types.py` - graph store interface **vital ref**
- `llama_index/graph_stores/simple.py` - minimal graph store (in-memory dictionary)
- `llama_index/graph_stores/nebulagraph.py` - NebularGraph connector

- `llama_index/tests/vector_stores/test_cassandra.py` - related test implementation
- `llama_index/tests/vector_stores/test_postgres.py` - related test implementation

- `/llama_index/docs/examples/index_structs/knowledge_graph/nebulagraph_draw.html` etc

**Trying existing tests**

`pytest tests`

missing dependency -

- pip install tree_sitter_languages

try again, 4 FAILED, all from what I roughed out yesterday :)

5 ERROR, eg.

ERROR tests/llm_predictor/vellum/test_predictor.py::test_predict\_\_basic - ModuleNotFoundError: No module named 'vellum'

dependency?

- pip install vellum

9 failed, 247 passed, 79 skipped, 31 warnings in 2.75s

not-me failures around vellum

FAILED tests/llm_predictor/vellum/test_prompt_registry.py::test_from_prompt\_\_new - ModuleNotFoundError: No module named 'vellum.core'

https://pypi.org/search/?q=vellum

try -

- pip install vellum-ai

Lucky! 4 failed, 252 passed, 79 skipped, 31 warnings in 3.40s

Those 4 are my rubbish.

How to run individual test files? https://stackoverflow.com/questions/36456920/specify-which-pytest-tests-to-run-from-a-file

collected 0 items

test naming conventions https://stackoverflow.com/questions/37353960/why-pytest-is-not-collecting-tests-collected-0-items

Ooops - I used the wrong path.

- pytest tests/graph_stores/

5 failed, 1 passed in 0.25s

- pytest tests/graph_stores/test_simple.py

1 failed in 0.17s

I'd see the annotation `@pytest.fixture` elsewhere, but for pytest the test_naming was what it needed :

```
def test_one_false():
    assert 1 == 0
```

ok, time to actually write code...

### Ask the assistant first

I hadn't really explored ChatGPT's Code Assistant. Had seen that you could upload source files, best as a zip.

So I thought, see how far it gets with `llama_index/graph_stores/`
