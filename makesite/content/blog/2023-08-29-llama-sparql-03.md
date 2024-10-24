<!-- title: llama_index SPARQL Notes 03 -->

### Today

_I'm down to $0.23 OpenAI API credit, so until I next have $ need to look at things that don't need it. `sparql.py` doesn't in itself need the OpenAI API, but a SPARQLy version of Wey Gu's Notebook is my target functional E2E test._

> I still have NebulaGraph data generated from Wey's Notebook. I can use nebula-python to pull out data from there, RDFLib to build RDF, sparqlwrapper to push to store. The SPARQL needed will be essentially the same as for `sparql.py`. Also NebulaGraph <=> RDF utils would be nice to have (may already exist, but I'll pretend I didn't consider that, need to inform myself).

Then -

- have a look around _3 Create VectorStoreIndex for RAG_ in Notebook
- put the INSERT & SELECT queries inside sparql.py
- ...

---

**MOVE PATH FROM llama_index INSTALLED TO DEV TREE**

**sudo /usr/local/nebula/scripts/nebula.service start all**

Started with :

`resp = client.execute_json('MATCH (v:entity) RETURN v')`

After converting this to string there were character encoding errors. Should really be investigated properly, but for now I'll just go with some quick & dirty sanitization (Valid RDF literals will probably need _something_ anyhow).

`json_str = resp.decode('utf-8')` appears to have fixed the encoding issues.
