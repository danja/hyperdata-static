<!-- title: llama_index SPARQL Notes 09 -->

_I lost internet connectivity last night, woke up this morning with no electricity. The electric came on pretty soon - I had been warned ENEL were messing with the village wiring. The net took a trip into town to sort out (billing error, and then they took ages to switch me back on). The money I was expecting hasn't yet arrived t the bank, so still no OpenAI credit. So I spent most of the day staring at the wall/Twitter._

Ok, it seems like I was looking at the wrong place to put the query. Not `query()` but :

```
    def get(self, subj: str) -> List[List[str]]:
        """Get triplets."""
        ...
```

The implementation in `nebulagraph.py` is _scary_!

Fool Danny, I forgot to put a logger bit in to check what gets returned there.

In `simple.py` :

```
    def get(self, subj: str) -> List[List[str]]:
        """Get triplets."""
        return self._data.graph_dict.get(subj, [])
```

Wey mentions 'flattened' around `get_rel_map()`, where the subject is given with a list of associated rel, obj. But this looks less flat.

I'll assume for now, if data =

```
"one", "two", "three"
"one", "two", "four"
"two", "two", "four"
```

`get('one')` will return :

```
[[`one', 'two', 'three'], ['one','two','four']]
```

Now I'm confused. I did put a logger into `get()`, list of lists, **lol**. Nothing came out.

Ok, I'll make a helper method that acts as above, see where it go when I can see the behaviour again.

@prefix er: <http://purl.org/stuff/er#> .
@base <http://purl.org/stuff/data> .

Query like :

```
PREFIX er:  <http://purl.org/stuff/er#>
BASE <http://purl.org/stuff/data>

SELECT DISTINCT ?rel ?obj WHERE {
    GRAPH <http://purl.org/stuff/guardians> {
        ?triplet a er:Triplet ;
            er:subject ?subject ;
            er:property ?property ;
            er:object ?object .

        ?subject er:value ?subj_string .
        ?property er:value ?rel .
        ?object er:value ?obj .
    }
}
```

Ok, that worked via Fuseki's UI. For code, replace `?subj_string` with `{subj}`. Put it in `def sparql_query(self, query_string):`

sparqlwrapper will not doubt need help producing what I want, need to RTFM there, `results.response` somewhere - if it's available as a list of lists that'd be nice.

I'm using GET method, I don't like POST unless really necessary (it's floppy in the spec).

I must **make an endpoint-focused test for this**

Wired in to `get()`, that'll do for today.
