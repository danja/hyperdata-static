<!-- title: llama_index SPARQL Notes 02 -->

**Aaargh! OpenAI API credit $0.21, and I won't have any money to top it up for another week or so**

_What doesn't need the API?_

**FOR TEMP CHANGES, UNMODIFIED FILES ARE IN ../original**
_(I should probably make a branch in git, but then I'm likely to forget...)_

My attention's been skipping around, spent a lot of time trying to engage with ChatGPT. There are bits of prompts I tried in [llama_index SPARQL Notes 01](/blog/llama-sparql-01).

Time to get back to the code proper (continuing from [llama_index SPARQL Notes 00](/blog/llama-sparql-00)).

I've roughed out the shape of RDF I _think_ I need :

```
# Simple Entity-Relation

@base <http://purl.org/stuff/data> .
@prefix er: <http://purl.org/stuff/er> .

<#T123> a er:Triplet ;
er:id "#T123" ;
er:subject <#E123> ;
er:property <#R456> ;
er:object <#E567> .

<#E123> a er:Entity ;
er:value "one" .

<#R456> a er:Relationship ;
er:value "two" .

<#E567> a er:Entity ;
er:value "three" .
```

But before writing the SPARQL I want to go back to `nebulagraph.py`, add some logging calls to see what it's _actually_ passing around. Then go back to the tests, then forward...
