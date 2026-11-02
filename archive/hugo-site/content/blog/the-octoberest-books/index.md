---
title: "The Octoberest Books"
summary: "Which fantasy fiction books are the Octoberest? The spookiest? Armed with 3.4 million Goodreads reviews, I try and hack my way to answer!"
slug: "The-Octoberest-books"
categories: 
- cultural-analytics
- python
date: 2021-10-09
---

## In Search of Spooky Reads

For the last few Octobers, my inner tech geek and inner October fanatic have been desperate to collaborate on a spooky data science project.
It's a competitive field, though! There's Janelle Shane's always-excellent neural-net-generated [Halloween costumes](https://www.aiweirdness.com/halloween-costumes-by-the-neural-19-10-14/)
and [tasty(ish) treats](https://www.aiweirdness.com/easy-halloween-treats-generated-by-19-10-31/). There's 538's silly-and-sporty [Candy Power Ranking](https://fivethirtyeight.com/videos/the-ultimate-halloween-candy-power-ranking/).
And of course, there are the veteran spooky statisticians of the National Retail Federation, who've been running an annual [Halloween Trends Report](https://nrf.com/topics/holiday-and-seasonal-trends/halloween) for some years now.

As for my own entry into this amusingly large body of Halloween hackery, I've decided to stick to my literary roots and launch what I'm calling a cultural analytics "bottle project" (*a la* television's [bottle episodes](https://en.wikipedia.org/wiki/Bottle_episode)) --
a short-and-sweet single-method, single-dataset, investigation into one small question. In this case: which fantasy books are the Octoberest? The great hope of the project, of course, is that the "Octoberest" books are also the spookiest, most-Halloweenest books!

## Computing Octoberness

Here's the idea: I took [UCSD's dataset of Goodreads reviews for fantasy books](https://sites.google.com/eng.ucsd.edu/ucsdbookgraph/home) and calculated for each book how many reviews it received in October vs. how many it received in the non-October months.
After making the vaguely-mathematically-justifiable decision to divide the number of non-October reviews by 11 (to account for the fact that there are 11-times as many non-October months!), 
I had my "Octoberness" score, which measures how evenly distributed a book's reviews were between October and the average non-October month.

An Octoberness score of 1, for example, means that a book received a equal number of reviews in October as it did in an average non-October month.
A score of 2 means that a book received twice as many reviews in October compared to an average non-October month.
And a score of 0.5 means it received half as many reviews in October compared to an average non-October month.

That's the *general* idea. There were a couple of necessary modifications. Or at least modifications that I ended up making. First, I unscrupulously tossed out books with too few reviews to yield a meaningful Octoberness score. An exploratory analysis suggested that 100 total reviews was a reasonable cutoff, where "exploratory analysis" here means "I frowned deeply at a histogram." Second, I tossed out every review submitted in the first calendar year following a book's publication. September and October-published books have artifically high Octoberness scores, since they benefit from a hefty initial readership. Many of those _are_ spooky (shout-out to seasonal publishing trends!), but many are not, so out they go.

If this was a serious experiment, I might've have done something different, something clever.
But this isn't a serious experiment. I'm hacking my way to a spooky book list, and if I've got to bury ~~tens of thousands~~ a few reviews to get there, well, I've made my peace with that.

After committing these high crimes against experimental design, all that was left was to run the code and cross my fingers that the results would be interesting -- a classic 
posture of the computational humanities! And I am excessively proud to report that the result speak -- or really, *shriek* -- for themselves. Below, I've curated a selection of some of the most Octoberest books, complete below with clickable book covers that whisk you away to Goodreads.com. The extra-curious reader can find the top 150 (along with the accompanying code) on this project's [little Github page.](https://github.com/Codyvanzandt/Octoberest-Books)

## A Selection of the Most Octoberest Books

### #1 (6.94 Octoberness): *The Halloween Tree* by Ray Bradbury 

[![The Halloween Tree](https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1320398641l/761381.jpg)](https://www.goodreads.com/book/show/761381.The_Halloween_Tree)

> A fast-moving, eerie tale set on Halloween night... 
> 
> Eight costumed boys running to meet their friend Pipkin at the haunted house outside town encounter instead the huge and cadaverous Mr. Moundshroud. As Pipkin scrambles to join them, he is swept away by a dark Something, and Moundshroud leads the boys on the tail of a kite through time and space to search the past for their friend and the meaning of Halloween.

### #3 (4.14 Octoberness): *Slasher Girls & Monster Boys* by April Genevieve Tucholke et al.

[![Slasher Girls and Monster Boys](https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1423855717l/19364719.jpg)](https://www.goodreads.com/book/show/19364719-slasher-girls-monster-boys)

> For fans of Stephen King, Neil Gaiman, Lois Duncan, and Daphne Du Maurier comes a powerhouse anthology featuring some of the best writers of YA thrillers and horror
> 
> A host of the smartest young adult authors come together in this collection of scary stories and psychological thrillers curated by Between the Devil and the Deep Blue Sea’s April Genevieve Tucholke.
>
>  Each story draws from a classic tale or two—sometimes of the horror genre, sometimes not—to inspire something new and fresh and terrifying. There are no superficial scares here; these are stories that will make you think even as they keep you on the edge of your seat. From bloody horror to supernatural creatures to unsettling, all-too-possible realism, this collection has something for any reader looking for a thrill.

### #6 (2.12 Octoberness): *The Graveyard Book* by Neil Gaiman 

[![The Graveyard Book](https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1531295292l/2213661.jpg)](https://www.goodreads.com/book/show/2213661.The_Graveyard_Book)

> Nobody Owens, known to his friends as Bod, is a perfectly normal boy. Well, he would be perfectly normal if he didn't live in a graveyard, being raised and educated by ghosts, with a solitary guardian who belongs to neither the world of the living nor the world of the dead.
> 
> There are dangers and adventures for Bod in the graveyard: the strange and terrible menace of the Sleer; a gravestone entrance to a desert that leads to the city of ghouls; friendship with a witch, and so much more.
> 
> But it is in the land of the living that real danger lurks, for it is there that the man Jack lives and he has already killed Bod's family.

### #7 (2.09 Octoberness): *Wicked as They Come* by Delilah S. Dawson 

[![Wicked as They Come](https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1324921586l/12381722.jpg)](https://www.goodreads.com/book/show/12381722-wicked-as-they-come)

> When nurse Tish Everett forced open the pesky but lovely locket she found at an estate sale, she had no idea she was answering the call of Criminy Stain, from the far off land of Sang. He’d cast a spell for her, but when she’s transported right to him, she’s not so sure she’s ready to be under the spell of another man. (It didn’t go so well last time with controlling, abusive, domineering Jeff.) If only Criminy wasn’t so deliciously rakish….

### #10 (1.94 Octoberness): *Click-Clack the Rattlebag* by Neil Gaiman 

[![Click Clack the Rattlebag](https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1588204688l/53297922._SX318_.jpg)](https://www.goodreads.com/en/book/show/16109478-click-clack-the-rattlebag)

> "Click-Clack the Rattlebag" is your Halloween treat from Neil Gaiman and Audible, free through October 31. It's not available anywhere else, and for a limited time, each download from Audible benefits educational charities at DonorsChoose.org.
> 
> A few words from Neil: 
> 
> "Why tell ghost stories? Why read them or listen to them? Why take such pleasure in tales that have no purpose but, comfortably, to scare?
I don't know. Not really. It goes way back. We have ghost stories from ancient Egypt, after all, ghost stories in the Bible, classical ghost stories from Rome (along with werewolves, cases of demonic possession, and of course, over and over, witches). We have been telling each other tales of otherness, of life beyond the grave, for a long time; stories that prickle the flesh and make the shadows deeper and, most important, remind us that we live, and that there is something special, something unique and remarkable, about the state of being alive. Happy Halloween!"


## Celebrations and Limitations

It's always such a joy to see a simple method yield compelling results! The full list is jam-packed with magic, mystery, and all manner of Things That Go Bump in the Night. The #10 Octoberness-getter, Neil Gaiman's scary story "Click Clack the Rattle Bag," is especially lovely and completely new to me. If you can spare 10 minutes, you really must to listen to [Gaimain read it himself, with ambient lighting, sound, and costuming](https://www.youtube.com/watch?v=imLja6Emezo). It's quite the October mood-setter!

Of course, this little bottle project is (by design!) full of omissions, missed-opportunities, and ignored-problems. We could commit ourselves to more serious statistical mumbo-jumbo, but frankly, most of the fun of a bottle project lies in keeping seriousness of every kind at arm's-length. 

If you pick up the Octoberness question or the Goodreads dataset and run with either of them (which I highly recommend! loads of fun!), I'd love to hear about it. Similarly, I'd be thrilled to read any little bottle projects that you've worked on, especially if they land somewhere near my cutural analytics neighborhood. 

Happy October!
