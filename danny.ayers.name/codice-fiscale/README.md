# Checking my Codice Fiscale

I tried to register a .it domain at gandi.net. Computer says no.

I query. Jeremie at Gandi says my ID is wrong.

.it domain registration is restricted to Italian citizens/residents. I'm a resident.

An acceptable ID, which I have, is a Codice Fiscale.

Ok, from my medical card :

**YRSDLJ64A14Z114E**

Pretty much _everyone_ has a Codice Fiscale whether they like it or not. They're algorithmically generated from basic personal details.

I check my card. Yup, correct. I blame Gandi's validator.

Jeremie double-checks. Points out the algorithm on Wikipedia : [Italian fiscal code](https://en.wikipedia.org/wiki/Italian_fiscal_code)

Says the final, checksum-ish, character is wrong. He reckons **W** not **E**.

I try the algorithm manually. I get **M**. _(I do suspect I was using the odd lookup table for the even characters)_.

Grr. Ok, check the easier bits manually, script the rest.

## Easier Bits

Relevant details :

- Forenames : Daniel John
- Surname : Ayers
- Birthdate : 1964-01-14
- Sex : Male
- Place of birth : Chesterfield °, UK

° _puzzled me for a long time now: my parents lived in Tideswell, I believe there's a cottage hospital in Bakewell & plenty of facilities in Buxton, Chesterfield's a bit of a trek. I'll have to remember to ask my mother..._

### Cognome

- First three consonants of surname : YRS

**YRS**

### Nome

- First three consonants of the name are used. If there is more than one name, both are considered as if they were one. If the name has more than three consonants, the 2nd is skipped (!? + a couple of more obscure rules)

danieljohn -> dnljhn -> DLJ

**YRSDLJ**

### Data di nascita

- Year of birth (two digits): the last two year of birth digits are used (e.g. "1972" would be 72);

-> 64

- Month of birth : each single month is associated with one letter, as shown in the table:

A January
B February
C March
D April
E May
H June
L July
M August
P September
R October
S November
T December

-> A

- Birthday and gender (2 digits): the two birthday digits are used (from 01 to 31); if the person is a woman, 40 is added (e.g. 01 would be 41, 31 would be 71).

-> 14

**YRSDLJ64A14**

### Luogo di nascita

- Town of birth : the code of the town of birth is used, as indicated by the official list of Italian towns and cities... People born in a foreign country have their own code according to the country of birth, all of them beginning with letter Z...the UK code is Z114

**YRSDLJ64A14Z114**

### Check character

The final character is a check character, calculated according to the following algorithm:

- the eight odd characters (1st, 3rd, 5th, etc.) are set apart; same thing for the seven even ones (2nd, 4th, 6th, etc.).

Each single character is converted into a numeric value as shown in the tables below:

- [input-odd.csv](output-odd.csv)
- [input-even.csv](output-even.csv)

Lookup table time.

The numeric values are then added together and the result is divided by 26. The remainder is used to look up the final character in the table below:

- [output-check.csv](output-check.csv)

but that's a direct map from the remainder to the character, some tweak on char(remainder) should do it.

Ok.
Now I have [my-cf.py](my-cf.py)

**Who was correct?**

The bit of the Italian state with whom I originally registered (the Questura in Lucca presumably), Jeremie at Gandi, or me?

_My money's on Jeremie._

I run the code. Code says **G**.

Just totally fuck off, still not resolved. That's an hour I won't get back.

I do also have a residence card ('permanent residence' - but only valid until 2032, likely screwed by Brexit, I should apply for citizenship soon).

I'll send Jeremie a photo.

PS. ChatGPT4 gets **E**, same as is on my medical card (had to tell it the birthplace bit).
