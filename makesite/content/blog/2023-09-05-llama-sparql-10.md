<!-- title: llama_index SPARQL Notes 10 -->

_Got some funds so I paid some API credit. But have spent the day so far on admin and bits & pieces that were niggling me. And now, 16:47, it's dogwalk time. But I need a bit of fresh air, clear head for `sparql.py`._
**Back from dogwalk**

Credit balance $29.87

```
sudo /usr/local/nebula/scripts/nebula.service start all
cd ~/AI/nlp/GraphRAG/src
export PYTHONPATH=$PYTHONPATH:/home/danny/AI/LIBS-under-dev/llama_index
python graph-rag-nebulagraph-minimal.py
```

5 or 6 runs with little tweaks in between. OpenAI credit still says $29.87.

No idea why, this returned a <MarkdownObject> rather than text. So pulled that out.

It also ends on an exception from calling -

```
    def __del__(self) -> None:
        """Close NebulaGraph session pool."""
        self._session_pool.close()
```

_But_, before that it says :

> Peter Quill is the half-human, half-Celestial leader of the Guardians of the Galaxy...

The log isn't any more useful -

```
INFO:llama_index.graph_stores.nebulagraph:nebulagraph HERE
INFO:llama_index.graph_stores.simple:simple HERE
INFO:llama_index.graph_stores.sparql:sparql HERE
INFO:__main__:graph-rag-nebulagraph-minimal HERE
INFO:__main__:#### 1.2
INFO:__main__:#### skip 2
INFO:__main__:#### 4
INFO:llama_index.indices.loading:Loading all indices.
INFO:__main__:#### 6.2
INFO:__main__:

Peter Quill is the half-human, half-Celestial leader of the Guardians of the Galaxy...
```

Hmm, log level..?

Tweaked a bit, noticed it's loading index from `./storage_graph/docstore.json`

Oops, I pulled out the code for generating the kg when I was looking at the upload bits without OpenAI

TypeError: can only concatenate str (not "list") to str

ok,

```
for s in subjs:
    logger.warning('s =' + str(s))
```

a couple more tweaks later it ran through. _Much_ more interesting logs!

First thing of note :

```
DEBUG:openai:message='Request to OpenAI API' method=post path=https://api.openai.com/v1/completions
DEBUG:openai:api_version=None data='{"prompt": "Some text is provided below. Given the text, extract up to 10 knowledge triplets in the form of (subject, predicate, object). Avoid stopwords.\\n---------------------\\nExample:Text: Alice is Bob\'s mother.Triplets:\\n(Alice, is mother of, Bob)\\nText: Philz is a coffee shop founded in Berkeley in 1982.\\nTriplets:\\n(Philz, is, coffee shop)\\n(Philz, founded in, Berkeley)\\n(Philz, founded in, 1982)\\n---------------------\\nText: The Guardians travel to Orgocorp\'s headquarters to find the switch\'s override code and save Rocket\'s life.As Rocket lies unconscious, he recalls his past.As a baby raccoon, he was experimented on by the High Evolutionary, who sought to enhance and anthropomorphize animal lifeforms to create an ideal society called Counter-Earth.Rocket befriended his fellow Batch 89 test subjects: the otter Lylla, the walrus Teefs, and the rabbit Floor.The High Evolutionary was impressed by Rocket\'s rapidly growing intelligence but became furious once it exceeded his own.The High Evolutionary used Rocket to perfect his Humanimal creations, then planned to harvest Rocket\'s brain for further research and exterminate the obsolete Batch 89.Rocket freed his friends, but the High Evolutionary killed Lylla.Enraged, Rocket mauled the High Evolutionary, but his henchmen killed Teefs and Floor during a firefight with Rocket, before the latter fled Counter-Earth in a spaceship.In the present, the Ravagers, including an alternate version of Gamora, help the Guardians infiltrate Orgocorp.They retrieve Rocket\'s file but discover that the code was removed, with the likely culprit being Theel, one of the High Evolutionary\'s advisors.The Guardians, along with Gamora, depart for Counter-Earth to find him.They are followed by Ayesha and Adam after the High Evolutionary, their race\'s creator, threatened to wipe out the Sovereign if they fail to retrieve Rocket.The Guardians reach Counter-Earth and are guided to the Ar\\u00eate Laboratories complex.Drax and Mantis remain with Gamora and Rocket as Peter Quill, Groot, and Nebula travel to Ar\\u00eate.Nebula is forced to wait outside by guards as Quill and Groot enter Ar\\u00eate, while Drax tricks Mantis into pursuing Quill\'s group.Gamora saves Rocket from being captured by Adam and the High Evolutionary\'s guard War Pig.Questioned by Quill, the High Evolutionary admits disillusionment with the Animen\'s imperfect society.He destroys Counter-Earth, killing the Humanimals and Ayesha.Ar\\u00eate departs as a spaceship, with Nebula, Drax and Mantis boarding to rescue Quill and Groot, who instead escape Ar\\u00eate with Theel, retrieving the code from his corpse before being rescued by Gamora in their ship.\\nTriplets:\\n", "stream": false, "model": "text-davinci-002", "temperature": 0.0, "max_tokens": 3480}' message='Post details'
DEBUG:urllib3.connectionpool:https://api.openai.com:443 "POST /v1/completions HTTP/1.1" 200 None

```

Lots and lots of upserts, up to around line 1000 in nebby.log

line 1020 #### nebulagraph get_rel_map called

```
WARNING:llama_index.graph_stores.nebulagraph:
#### nebulagraph get_rel_map called
WARNING:llama_index.graph_stores.nebulagraph:s =Peter Quill
WARNING:llama_index.graph_stores.nebulagraph:#### nebulagraph get_flat_rel_map
WARNING:llama_index.graph_stores.nebulagraph:subs = ['Peter Quill']
WARNING:llama_index.graph_stores.nebulagraph:get_flat_rel_map() subjs_param: ['Peter Quill'], query: WITH map{`true`: '-[', `false`: '<-['} AS arrow_l,     map{`true`: ']->', `false`: ']-'} AS arrow_r MATCH (s)-[e:`relationship`*..2]-()   WHERE id(s) IN $subjs WITH id(s) AS subj,[rel IN e |   [  arrow_l[tostring(typeid(rel) > 0)] +      rel.`relationship`+  arrow_r[tostring(typeid(rel) > 0)],  CASE typeid(rel) > 0    WHEN true THEN dst(rel)    WHEN false THEN src(rel)  END  ]] AS rels WITH   subj,  REDUCE(acc = collect(NULL), l in rels | acc + l)    AS flattened_rels RETURN  subj,  REDUCE(acc = subj, l in flattened_rels | acc + ', ' + l )    AS flattened_rels
WARNING:llama_index.graph_stores.nebulagraph:rel_map =
WARNING:llama_index.graph_stores.nebulagraph:s =Peter Quill
WARNING:llama_index.graph_stores.nebulagraph:rel_map =
```

right, this looks where the triplets for a subj are got & returned

_raw snipped_

I saved that chunks as rel_map.json and let VSCode try to format it - much clearer. Kinda...

PS. format a bit by hand

```
{'Peter Quill': [
    'Peter Quill, -[would return to the MCU]->, May 2021, <-[would return to the MCU]-, Peter Quill',
    'Peter Quill, -[would return to the MCU]->, May 2021',
    'Peter Quill, -[was raised by]->, a group of alien thieves and smugglers',
    'Peter Quill, -[is leader of]->, Guardians of the Galaxy',
    'Peter Quill, -[would return to the MCU]->, May 2021, <-[Gunn reaffirmed]-, Guardians of the Galaxy Vol. 3',
    ...
```

Ok, a format in a format. I don't know why there are backwards arrows and apparently repetition, but the basic stuff will be straightforward from SPARQL results. I reckon I'll start with simple forward-arrow triples, see if that communicates enough.

oh wait, line 1124 :

```
'Request to OpenAI API' method=post path=https://api.openai.com/v1/completions
DEBUG:openai:api_version=None data='{"prompt": "Context information from multiple sources is below.\\n---------------------\\nThe following are knowledge sequence in max depth 2 in the form of directed graph like:\\n`subject -[predicate]->, object, <-[predicate_next_hop]-, object_next_hop ...
...
```

Break time. Food & flop.

`:cat AI`
`:tag SPARQL`
`:tag LlamaIndex`
