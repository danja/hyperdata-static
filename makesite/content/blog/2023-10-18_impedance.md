<!-- title: Impedance Matching LLMs and Linked Data -->

**If you see this message, this post is only half-done. I know what's needed so it should be done in a couple of hours. I've published prematurely to check image linking**

[Unifying Large Language Models and Knowledge Graphs: A Roadmap]()

### An Observation

Large Language Models are sizeable knowledgebases which, at least in part, encapsulate sentence-oriented data structures derived from human language. The Web is a massive knowledgebase which at a *structural* level, has embedded sentence-like data (clearly apparent when viewed from a [Linked Data](https://en.wikipedia.org/wiki/Linked_data) perspective). There isn't an obvious direct mapping between these systems, but they both feature shapes that look very similar from 1,000ft. However you look at it, the future potential of a combined system is...*TBD*. We are in a position to take (long-legged) baby steps in that direction.

### A Problem

For the purposes here, have a loose, back-of-envelope working definition of 'knowledge' :
```
A collection of structured data that represents information, together with a means of navigating that information.
```
*Navigation* isn't usually something highlighted in these parts. But applied in a very broad sense, I reckon is useful, as I hope to show here. Leave notions of *agency* to one side to avoid the bigger tarpit around intelligence, biological or artificial.  

#### A Particular Characterization of LLMs

Deep Learning systems *somehow* embody knowledge *somehow* derived from their training data. Forget their internals for now, consider them as black boxes with external interfaces, communication protocols.  

#### A Particular Characterization of the Web

I believe '[Semantic Web](https://en.wikipedia.org/wiki/Semantic_Web)' hit the Peak *(of Inflated Expectations)* in the [Gartner Hype Cycle](https://www.gartner.com/en/research/methodologies/gartner-hype-cycle) around 2001, the time of a certain [Scientific American article](https://www-sop.inria.fr/acacia/cours/essi2006/Scientific%20American_%20Feature%20Article_%20The%20Semantic%20Web_%20May%202001.pdf) (PDF). But lot has happened since then. Masses of work has been done by people working directly in the field. There's been significant deployment by people from every imaginable field using the associated technologies for practical applications. Most web developers will have seen something related in their peripheral vision, quite possibly used such things in their day job without realising it. But for various historical reasons the big picture isn't that widely known.  



First, a wormhole-speed trip from the

LLM

The cat sat on the mat. A lot of mats are blue.

Q & A

That there's some common topology between these systems shouldn't be a surprise. Both are representations of knowledge with humans as the immediate source.

But there are low-level hacks that might offer approaches *good enough* for many practical applications.

### A Potential Path to a Partial Solution  


relevance Similarity overlays on the web
