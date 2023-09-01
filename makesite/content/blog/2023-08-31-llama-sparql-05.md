<!-- title: llama_index SPARQL Notes 05 -->

Grr...next admin session I must set up systemd

**sudo /usr/local/nebula/scripts/nebula.service start all**

for ChatGPT :

```
I'd like a function to remove duplicates from a Python json structure. For example, give the following :
[
{'s': 'production on Vol.3', 'p': 'was put on hold until', 'o': 'February 2021'
},
{'s': 'production on Vol.3', 'p': 'put on hold until', 'o': 'February 2021'
},
{'s': 'production on Vol.3', 'p': 'was put on hold until', 'o': 'February 2021'
}
]
the function should return :
[
{'s': 'production on Vol.3', 'p': 'was put on hold until', 'o': 'February 2021'
},
{'s': 'production on Vol.3', 'p': 'put on hold until', 'o': 'February 2021'
}
]
```

It got it right first time!

So, next to flip this JSON into RDF/SPARQL.

Not 100% sure, but I don't think I actually need the `extract_entities` function, anything useful will also appear in `extract_entities` and the types/roles are implied by the triplets.

**sanitize**

`def escape_for_rdf(input_str)` - thank you ChatGPT.

Given the following JSON, how would I retrieve the values of s, p, o?
[
{'s': "Industrial Light & Magic's StageCraft", 'p': 'was developed for', 'o': 'Disney+ Star Wars series The Mandalorian'
}
]

took a little backwards & forwards, but we got there.

I'm really not sure what level of granularity will eventually be needed, for big lumps of data something else from the [SPARQL Protocol](https://www.w3.org/TR/sparql11-http-rdf-update/) would probably be better (like a full-on HTTP PUT). Per-triple DELETE/INSERT might be desirable elsewhere. But here it shouldn't get too big, the INSERT approach _should_ work, and would also work per-triple.

The NebulaGraph notion of a Space appears very similar to RDF/SPARQL Named Graphs, so I'll go with that (more information, and things can get messy doing everything in the default graph).

This is what I came up with the other day :

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

I opted for URL-named resources rather than blank nodes or other IRI because soon it may help with sanity-checking, further down the line the potential for HTTP retrieval is nice to have. There are a lot of annotation/meta triples that could be added, but I reckon this is about the minimum necessary to fulfil the _Wey Gu's Notebook with SPARQL_ use case.

I guess I need a fragment ID generator. Suboptimal but so it's not too hard on the eyes for now, I'll got with alpha(capitals)-numeric. How many chars?

Please write a function to generate a random 4-character string using only numeric characters and capital letters.

Ok.

Need to keep identity of entities/relationships. I'm not sure what should happen if the same string is pulled out more than once as entity and/or relationship from different contexts. Should they have different IDs (URLs)? I don't fancy a deep dive into llama_index structures right now, I'll wait for someone to tell me. Whatever, giving identical strings the same URL shouldn't make a huge difference either way.

Strings appearing both in the role of Relationship & Entity might also be thinking about. But again, for now, no big deal.

Ran current version -

```
                        <#THKOE> a er:Triplet ;
                                er:subject <#EK8WH> ;
                                er:property <#RJSJV> ;
                                er:object <#ELD8T> .

                        <#EK8WH> a er:Entity ;
                                er:value "Vol.3" .

                        <#RJSJV> a er:Relationship ;
                                er:value "is the first MCU film to feature" .

                        <#ELD8T> a er:Entity ;
                                er:value "the word  fuck  uncensored" .
```

Progress!
