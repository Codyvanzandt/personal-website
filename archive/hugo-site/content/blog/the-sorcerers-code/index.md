---
title: "The Sorcerer's Code"
summary: "A hands-on introduction to Python's magic methods."
slug: "The-Sorcercers-Code"
categories: 
- programming
- python
- tutorial
date: 2018-08-31
---


# We're Going to Need a Little Magic

So there you are - mind racing, fingers blurring, the most beautiful Python in all the world coming to life on your screen. You're in the zone!

Tasks fall to your indomitable will one right after another. Boom! Boom!

Suddenly, a new task appears on the horizon: you need a class to represent a big ol' hunk of words!

"Ha," you scoff. "Easy!"

It takes mere seconds for you to lay out the core of the class.


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()
```

You give the class a try...


```python
hunk = WordHunk("These are some words")
assert hunk.words == ["These", "are", "some", "words"]
```

...and it's flawless, of course. You're an absolute *wizard* on the keyboard today!

Confidently, you print out your new class:


```python
hunk = WordHunk("These are some words")
print(hunk)
```

    <__main__.WordHunk object at 0x7fb5684d5ef0>


Oh. Oh no.

That's so... ugly!

You desperately wrack your brain for a solution, but nothing comes to mind. Could you maybe change the print function? Could you do something weird with stdout? 

Ugh - those are terrible ideas.

You sag in your chair, and your flow state comes to an abrupt end.

Magician though you may have been, you're going to need some *real* magic to get out of this mess.

Luckily, Python has you covered. 

Allow me to introduce you to... 

### *_Magic Methods!_*

# The `__init__` Method

You're probably pretty familiar with this little number already.

By defining `__init__`, we can control how class instances are *initialized*. 

We used this method just above when we dictated that `WordHunk` initializes instances by: 

- Converting a user-provided string into a list of individual words
- And assigning that new list of words to the instance variable `words`

# The `__str__` Method

`__str__` allows us to define a "human-readable" representation of our class. Whatever `__str__` returns is what `print` will return.

Armed with this new knowledge, let's fix up `WordHunk`:


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()
    def __str__(self):
        return str(self.words)
```


```python
hunk = WordHunk("These are some words")
print(hunk)
```

    ['These', 'are', 'some', 'words']


Now *that* is magical! 

Let's just make sure that WordHunks are *always* represented in such a pretty way...


```python
double_hunk = [hunk, hunk]
print(double_hunk)
```

    [<__main__.WordHunk object at 0x7fb5684e30b8>, <__main__.WordHunk object at 0x7fb5684e30b8>]


Oh no. Not again!

# The `__repr__` Method

Where `__str__` fails, `__repr__` excels. 

`__repr__` allows us to define a "machine-readable" representation of our class. Whatever `__repr__` returns is what will be rendered when we use our class in a data structure or on the command line.

By convention, the return value of `__repr__` should be valid Python code. Ideally, we should be able to recreate an instance of a class *from* that instance's `__repr__`. 

Let's get to it!


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()
    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
```


```python
hunk = WordHunk("These are some words")
double_hunk = [hunk, hunk]
print(double_hunk)
```

    [WordHunk('These are some words'), WordHunk('These are some words')]


Perfect! And as a quick double-check, we can get the `__repr__` of our objects using Python's `repr` function.


```python
repr(hunk)
```




    "WordHunk('These are some words')"



And if we evaluate our `__repr__` as if it were valid Python code (because it *is*), then we should get back a real Python object:


```python
eval(repr(hunk))
```




    WordHunk('These are some words')



Ta da! A real `WordHunk`!

# The `__len__` Method

Wouldn't it be cool if we could take the length of a `WordHunk` using Python's built-in `len` function?


```python
len(hunk)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-11-d796a42c142a> in <module>()
    ----> 1 len(hunk)
    

    TypeError: object of type 'WordHunk' has no len()


Well I sure think it'd be cool! 

All we have to do is define the `__len__` method. Whatever `__len__` returns is how long our `WordHunk` will be.


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()
        
    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
```


```python
hunk = WordHunk("These are some words")
len(hunk)
```




    4



That was pretty easy. It makes sense that the length of a `WordHunk`is equal to how many words it contains.

# The `__contains__` Method

I think it would also be pretty nifty if we could check if a word is in a `WordHunk`.

Something like this:


```python
hunk = WordHunk("These are some words")
"some" in hunk
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-14-954425367c9d> in <module>()
          1 hunk = WordHunk("These are some words")
    ----> 2 "some" in hunk
    

    TypeError: argument of type 'WordHunk' is not iterable


To get this sort of behavior from our WordHunk, the simplest thing to do is define the `__contains__` method. 

`__contains__` should take an additional argument (the item in question) and then return a boolean depending on whether or not that item is in our `WordHunk`.


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
```


```python
hunk = WordHunk("These are some words")
"some" in hunk
```




    True



# The `__getitem__` Method

Here's the next awesome feature I think we should add to `WordHunk`:


```python
hunk = WordHunk("These are some words")
hunk[0] # Should return: "These"
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-17-2a1dee428c19> in <module>()
          1 hunk = WordHunk("These are some words")
    ----> 2 hunk[0] # Should return: "These"
    

    TypeError: 'WordHunk' object does not support indexing


To get `WordHunk` to support indexing, we need to define `__getitem__`. 

`__getitem__` should take an additional argument (a index of some sort) and returns the word located at that index.


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
    
    def __getitem__(self, key):
        return self.words[key]
```


```python
hunk = WordHunk("These are some words")
hunk[0]
```




    'These'



# The `__setitem__` Method

Now that we can get an item using bracket-notation, it would be nice if we could *set* an item using bracket notation.

Something like this:


```python
hunk = WordHunk("These are some words")
hunk[2] = "different"
hunk
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-20-0fdc933bef70> in <module>()
          1 hunk = WordHunk("These are some words")
    ----> 2 hunk[2] = "different"
          3 hunk


    TypeError: 'WordHunk' object does not support item assignment

No surprises here; we're going to use `__setitem__` to implement this feature.

`__setitem__` takes *two* arguments:

- a key to use as an index
- and a new value to write at that index

Note: there's really no need for `__setitem__` to return anything. I can't think of anything reasonable for it to return.


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
    
    def __getitem__(self, key):
        return self.words[key]
    def __setitem__(self, key, new_value):
        self.words[key] = new_value
```


```python
hunk = WordHunk("These are some words")
hunk[2] = "different"
hunk
```




    WordHunk('These are different words')



# The `__iter__` Method

It'd be super useful if we could also iterate through our `WordHunk` one word at a time.

Something like this:


```python
hunk = WordHunk("These are some words")

for word in hunk:
    print(word)
```

    These
    are
    some
    words


Given how this guide has gone so far, you wouldn't have expected that to work. Turns out, if you define `__getitem__`, Python will give you iteration for free. Tricky, tricky!

But what if you *don't* want to define `__getitem__`, but you still want iteration? 

Have no fear! Here are the nuts and bolts of how Python implements iteration.

We need to define *two* methods on `WordHunk`: `__iter__` and `__next__`.

Here are the rules for `__iter__` and `__next__`.

- `__iter__` needs to return an object that has a `__next__` method.

- `__next__` is a method that returns the next item until there are no more items left. At that point it throws a special exception: the `StopIteration` exception.

Let's start simple by defining `__next__` on our `WordHunk`. 


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()
        self.current_index = 0

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
    
    def __getitem__(self, key):
        return self.words[key]
    def __setitem__(self, key, new_value):
        self.words[key] = new_value
    
    def __next__(self):
        if self.current_index < len(self.words):
            next_word = self.words[self.current_index]
            self.current_index += 1
            return next_word
        else:
            raise StopIteration
```

There isn't anything tricky going on here. 

We now have a `current_index` variable to keep track of where we are in our word list.

When we call `__next__`, we check if `current_index` is a valid index in our word list.

- If `current_index` is valid, we return the word at `current_index` in our list and increment `current_index` by 1. 

- If `current_index` is invalid, we raise a special exception, `StopIteration`.

So`WordHunk` has a next method. ...What should we do now?

Let's think back to the requirements for making an object iterable.

- The object must have an `__iter__` method that returns something with a `__next__` method.
- The object's `__next__` method must return the next item until it runs out of items, then it throws.

Hang on... If `WordHunk`'s `__iter__` method needs to return an object with a `__next__` method, and `WordHunk` *is* an object with a `__next__` method... then that means `WordHunk`'s `__iter__` can just return... `WordHunk`.

Whoa. That's trippy. But there it is!


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()
        self.current_index = 0

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
    
    def __getitem__(self, key):
        return self.words[key]
    def __setitem__(self, key, new_value):
        self.words[key] = new_value
    
    def __next__(self):
        if self.current_index < len(self.words):
            next_word = self.words[self.current_index]
            self.current_index += 1
            return next_word
        else:
            raise StopIteration
    def __iter__(self):
        self.current_index = 0
        return self
```


```python
hunk = WordHunk("These are some words")
for word in hunk:
    print(word)
```

    These
    are
    some
    words


But wait, there's more!

Defining *both* `__iter__` and `__next__` is a little tiresome, so Python provides some syntactic sugar to help us along.

We can use the magic of [generators!](https://docs.python.org/3/tutorial/classes.html#generators)

Esssentially, generators let us write a *single* method that implements the behavior of *both* `__iter__` and `__next__`. 

The syntax is pretty simple. We just need to write a normal method that will return values one at a time (like `__next__` did), but instead of using a `return` statement, we'll use `yield` instead. We can call *this* new method `__iter__` and completely forget about `__next__`.

`yield` is pretty magical. It remembers exactly where it stopped returning values and always picks back up where it left off. It even takes care of throwing a `StopIteration` error for us.

Generators are a little complicated, but an example should clear things up.

```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
    
    def __getitem__(self, key):
        return self.words[key]
    def __setitem__(self, key, new_value):
        self.words[key] = new_value
    
    def __iter__(self):
        for word in self.words:
            yield word
```


```python
hunk = WordHunk("These are some words")
for word in hunk:
    print(word)
```

    These
    are
    some
    words


Now that is a *lot* simpler!

# Doing "Math" with WordHunks

What do you think would happen if we *added* two `WordHunk`s together using the `+` operator?

I think that addition of two `WordHunks` should return a *new* `WordHunk` with the word lists concatenated together.

Something like this:


```python
hunk = WordHunk("These are some words")
another_hunk = WordHunk("and they are great")
combined_hunk = hunk + another_hunk
combined_hunk
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-29-e857aae79163> in <module>()
          1 hunk = WordHunk("These are some words")
          2 another_hunk = WordHunk("and they are great")
    ----> 3 combined_hunk = hunk + another_hunk
          4 combined_hunk


    TypeError: unsupported operand type(s) for +: 'WordHunk' and 'WordHunk'


Let's make it happen! 

To get addition to work, we need to define the `__add__` method. It takes an argument (the thing that we want to add to our `WordHunk`) and returns a new `WordHunk` just like we talked about earlier.


```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
    
    def __getitem__(self, key):
        return self.words[key]
    def __setitem__(self, key, new_value):
        self.words[key] = new_value
    
    def __iter__(self):
        for word in self.words:
            yield word
            
    def __add__(self, other_WordHunk):
        all_the_words_list = self.words + other_WordHunk.words
        all_the_words_string = " ".join(all_the_words_list)
        return WordHunk(all_the_words_string)
```


```python
hunk = WordHunk("These are some words")
another_hunk = WordHunk("and they are great")
combined_hunk = hunk + another_hunk
combined_hunk
```




    WordHunk('These are some words and they are great')



Fantastic! 

Note: Since `WordHunk`s are created from strings, we had to convert the new word list into a string.

# Conclusion

And there you go! 

Thanks to Python's magic methods, our `WordHunk` is *really* featureful.

Check it out!

```python
class WordHunk(object):
    def __init__(self, word_string):
        self.words = word_string.split()

    def __str__(self):
        return str(self.words)
    def __repr__(self):
        return "WordHunk('{}')".format(" ".join(self.words))
    
    def __len__(self):
        return len(self.words)
    def __contains__(self, item):
        return item in self.words
    
    def __getitem__(self, key):
        return self.words[key]
    def __setitem__(self, key, new_value):
        self.words[key] = new_value
    
    def __iter__(self):
        for word in self.words:
            yield word
            
    def __add__(self, other_WordHunk):
        all_the_words_list = self.words + other_WordHunk.words
        all_the_words_string = " ".join(all_the_words_list)
        return WordHunk(all_the_words_string)
```

This list of magic methods is *far* from complete, but it should serve as a good introduction to the kinds of voodoo you have at your disposal. 

If you're hungry for more, I think that [this guide](http://www.diveintopython3.net/special-method-names.html) is a great place to go next. It *also* isn't complete, but it'll give you enough magic methods to solve 98% of your problems.

That last 2% is *really* esoteric (for example, you can manipulate how Python *stores* your class's attributes in memory). So I wouldn't worry to much about it. When you need one of those crazy methods, you'll know it.
