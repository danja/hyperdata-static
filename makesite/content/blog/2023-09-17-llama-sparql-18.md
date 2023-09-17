<!-- title: llama_index SPARQL Notes 18 -->

I spent the past few days mostly admin stuff (and stacking logs).

Prior to making a pull request on llama_index I want to :

- have an demo reliably working
- write adequate docs

I'm going to try to be a little more careful with git this time after a screw-up the other day.

So for a clean slate, I backed up and then deleted my fork of llama_index.
Then :

- created a new fork
- created a branch `sparql-01`
- cloned the fork locally & on my server
- switched to branch : `git checkout sparql-01`

I think the only necessary core files are :

- [x] llama_index/llama_index/graph_stores/++init++.py
- [x] llama_index/llama_index/graph_stores/registery.py
- [x] llama_index/llama_index/graph_stores/sparql.py

and docs/demos :

- [ ] notes on future in my nlp repo
- llama_index/docs/examples/graph_stores/graph-rag-sparql-mini.py
- [ ] working locally
- [ ] working on server
- llama_index/docs/examples/graph_stores/graph-rag-sparql-mini.ipynb
- [ ] working locally
- [ ] working on server
