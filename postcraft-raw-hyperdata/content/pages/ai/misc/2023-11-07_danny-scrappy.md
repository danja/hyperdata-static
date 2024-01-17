a very broad question, without an obvious asnser, so it'd be nice to hear your general intuitions.
I'd sketched this down to remind myself.

Panos touched on this Data Scientist, instance vs class.

RAG using Linked Data is low-hanging fruit, but it's still very prompt-oriented, the integration is shallow. My sense is that whatever the magic inside the LLM, the nature of the training data, it's good on a serial kind of representation, which can potentially traverse graphs, but it's not native.

How to integrate structural knowledge, like Linked Data more directly with LLMs.

So beyond RAG, how might it to be possible to more directly influence the insiternals of an LLM, somehow give it training or fine-tuning to somehow get use knowledgegraph to mak it understand stuctures better?

At first pass, I think including rules from OWL-based knowledge in the training/fine-tuning phases might
