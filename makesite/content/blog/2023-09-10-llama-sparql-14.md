<!-- title: llama_index SPARQL Notes 14 -->

```
Add OpenAPI keys.

Endpoint : https://fuseki.hyperdata.it/#/dataset/llama_index_sparql-test/

DROP GRAPH <http://purl.org/stuff/guardians>

sudo /usr/local/nebula/scripts/nebula.service start all
cd ~/AI/nlp/GraphRAG/src
export PYTHONPATH=$PYTHONPATH:/home/danny/AI/LIBS-under-dev/llama_index
python graph-rag-sparql-minimal.py
```

Fool Danny!

I'd made `rels()` as a placeholder for `get_rel_map()` while testing. Forget to wire it in when running end-to-end.

Connecting that up (and a few little tweaks) got rid of the recursion issue.

**Yay!! I might be missing something obvious but it now appears to work!**

Now to tidy up, then set up a demo Notebook.

Ew, I got the recursion/depth error again.

Ah, interesting!

I was giving it 2 questions :

- What do cats eat?
- Who is Quill?

The first the LLM should be able to answer but the RAG data would be no use, and vice versa.

When I removed the cat query, no recursion error. So I guess maybe the LLM was returning TMI.

So I'll leave it out for now.

Back to setting up a demo.

---

Grrr. Accidentally stuck a big file in a repo, got in a tangle with github. While sorting that out (backup, cleaning, updates) I'll start demo notes here.

SPARQL Graph RAG Demo

This is only a minimal, special case, proof-of-concept.

[Notebook](https://www.siwei.io/en/demos/graph-rag/), in which [Wey Gu](https://siwei.io/en/)

[Notebook](https://www.siwei.io/en/demos/graph-rag/), in which [Wey Gu](https://siwei.io/en/)
