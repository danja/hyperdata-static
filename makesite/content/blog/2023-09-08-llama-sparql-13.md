<!-- title: llama_index SPARQL Notes 13 -->

So, eliminating loops...

For now at least I reckon it'd be best to prevent loops before triplets go to the store. The simplest thing that should work is when presented with a triplet `(subj, rel, obj)`, check that `obj` hasn't already been used as a `subj`.
