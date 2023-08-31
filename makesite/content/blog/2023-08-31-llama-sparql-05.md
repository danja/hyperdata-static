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
