<!-- title: Graph of Thoughts, initial thoughts -->

_Work in progress, scrappy notes & thoughts to pull together. What sprang to mind, not thought through, likely much rubbish._

So I finally got around to reading the recent [Graph of Thoughts : Solving Elaborate Problems with Large Language Models](https://arxiv.org/abs/2308.09687) paper. _"Finally" in the sense of it only appeared at Arxiv just over a week or so ago, I printed a couple of days ago. Things are moving sooo fast..._

I do need to re-read it a few more times, also check some of the refs, there are bound to be papers that address the bits mentioned below (several are graph-related).So, initial thoughts. First is **meta**, the most important, subsuming everything else: **It's really well written!**. Research only really becomes useful when it's communicated. The text is as plain English as you can get with such material. Loads of acronyms, but that's unavoidable. But where they are significant, they're expanded and explained. Only as much maths as necessary, lovely - so often in this field, complicated sums muddy the water. Lots of clear-enough diagrams. Content-wise : **Strong Accept**.

Regarding content, in no particular order :

There are really tasty chunks, I really like the general approach.

For starters, identification of concrete goals : `How best to aggregate thoughts to maximise accuracy and minimise cost?`.
Some of the terms used (I've no idea which originated here or elsewhere, is irrelevant), like `Graph of Operations, GoO` and `Graph Reasoning State, GRS ` are great markers for particular concepts.
The metric **Volume** the authors provide looks like it could be **incredibly useful**. It's stated in a couple of places, the plain English version is :

`We define volume - for a given thought t - as the number of preceding LLM thoughts that could have impacted t`

The evaluation seems broad enough to be reliable, applied in a way that makes sense. The use cases are seriously uninspiring, but I'd say that adds weight to this thing having potential - I think it would do better on harder problem.

Frankly **I am very surprised** they got results as good as they did. Ok, I personally think approaches along these lines can offer huge benefits over current Tree-of-Thought etc techniques. But I've had given it another year or so of architecture trial and error before seeing any noticeable gain. One of the use cases is keyword counting - from what I've seen, ChatGPT's ability with arithmetic is below that of a 5-year old, only marginally above that of a certain former US president.

Description Logics as a generalization

is all quasi-procedural logic
I
things like applying tabl

https://en.wikipedia.org/wiki/Method_of_analytic_tableaux

IBIS

to ping
@DrIBIS @doriantaylor

https://web.archive.org/web/20030418021226/http://ideagraph.net/xmlns/ibis/

https://vocab.methodandstructure.com/ibis

I hadn't thought through how to do it (see this paper!), but the _Graph of Thoughts_ notion was a very visible next step after _Chain..._ and _Tree..._. I discussed it with ChatGPT [a little while ago](https://twitter.com/danja/status/1671680152500322304). This reinforced my feeling that it should be a productive avenue, so at the end of our conversation I asked ChatGPT for advertizing copy to promote it :

> "Unleash the power of graph-of-thought in LLM dialogues! Represent ideas as nodes, relationships as edges, and explore a web of knowledge. Navigate non-linearly, uncover intricate connections, and foster context-aware discussions."

https://www.siwei.io/en/posts/
