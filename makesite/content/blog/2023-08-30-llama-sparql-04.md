<!-- title: llama_index SPARQL Notes 04 -->

Continuing from [yesterday](2023-08-29-llama-sparql-03) on getting data from a NebulaGraph store and putting it into a SPARQL store.

I was able to get a condensed JSON rendition of the Entity data from NebulaGraph, now to do the same with Relationships

```
USE guardians;
MATCH (src:entity)-[e:relationship]->(dst:entity)
RETURN src, e, dst
LIMIT 10;
```

ChatGPT time -

> The task will be to create a function to extend an existing Python file. The purpose of this is to take data of a specific shape from a NebulaGraph DB via the nebula3 API and save it in a condensed form as JSON text. I will first give you the nGQL statements that were used to create the NebulaGraph space, then upload a the file, then describe the function I would like to add to it. Here are the nGQL statements :

```
CREATE SPACE guardians(vid_type=FIXED_STRING(256), partition_num=1, replica_factor=1);
:sleep 10;
USE guardians;
CREATE TAG entity(name string);
CREATE EDGE relationship(relationship string);
:sleep 10;
CREATE TAG INDEX entity_index ON entity(name(256));
```

> In the file there is the API call :
> resp = client.execute_json('MATCH (v:entity) RETURN v')
> I will add :
> resp_rel = client.execute_json('MATCH (src:entity)-[e:relationship]->(dst:entity) RETURN src, e, dst')
> json_rel_str = resp_rel.decode('utf-8')
> Please write a function extract_relationships(json_rel_str) following the pattern of extract_entities(json_data)

What it gave me looks close, but the output was :

```
    {'src': 'N/A', 'relationship': 'N/A', 'dst': 'N/A'
    },
    {'src': 'N/A', 'relationship': 'N/A', 'dst': 'N/A'
    },
...
```

I will upload a file containing a single result from the database. I would like the data extracted from this by the function extract_relationships to be:
[{"src": "production on Vol.3", "rel": "relationship", "dst": "February 2021"}]
please modify the function accordingly

> ChatGPT
> Finished working
> Show work
> It appears that I forgot to request the file upload. Could you please upload the file containing a single result from the database? This will help me modify the extract_relationships function to meet your requirements.

We went around in circles a lot. ChatGPT's mapping was repeatedly out, I hadn't looked closely neough at the NebulaGraph results.

But finally I ran with :

```
resp_rel = client.execute_json(
    'MATCH (src:entity)-[e:relationship]->(dst:entity) RETURN src, e, dst' LIMIT 1)
```

effectively _make it like_ :

```
[{"s": "production on Vol.3", "p": "was put on hold until", "o": "February 2021"}]
```

Yes! There are a lot of duplicates in the output but I'll just hack that for now. But I think I've done the unfmiliar bits now, the RDF/SPARQL side should be straightforward from here.

Enough for today.

**This would probably have been much easier with JSON-LD. But since I started down this path...**
