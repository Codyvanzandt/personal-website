---
title: "Finally Learn Python Imports"
summary: "Has Python's import system ever left you feeling hurt and confused? Let's remedy that."
slug: "Finally-Learn-Python-Imports"
categories: 
- programming
- python
- tutorial
date: 2019-03-2
---

## What Is an Import?
**Imports** are statements that allow us to use code that lives somewhere different from where we're currently working. We cannot (or rather, we absolutely should not) develop even a modest Python program without them. They're essential. 

They're also *significantly* more complicated than most folks assume - filled with plenty of traps for unwary programmers to fall into.

In this notebook, we'll cover imports from the basics ("What even IS an import?") to the edge of what is possible. (Note: we're speaking from a Python3.2+ perspective).

Dig in, and enjoy!

### Where Does Python Code Live?

Before we can start talking about importing Python code from various places, we need to first discuss the places in which Python code lives.

### Modules
Python code lives in files that end in ".py". 
In Python-speak, a file that ends in ".py" is also a **module**.

For example, let's write some Python code to create a dinner plate and put it in a file named ```dinner_plate.py```


`dinner_plate.py`

```python
class DinnerPlate( object ):
    def __repr__( self ):
        return "DinnerPlate()"
    
def make_dinner_plate():
    return DinnerPlate()
```

Here's what our world looks like:

```text
.
├── dinner_plate.py
└── GuideToImports.ipynb  # We're right here!
```

We're currently inside of the `GuideToImports.ipynb` Jupyter Notebook, and right beside us is a single file named `dinner_plate.py`. Since Python files are modules, we could also say that we have a single module named `dinner_plate`. 

There's a weird convention here that we need to talk about.

Notice that when we mentioned the file, we called it `dinner_plate.py`. But when we mentioned the module, we called it `dinner_plate`. There's only one object here, but we use two different names for it. When we're talking about this object as a file, we call it `dinner_plate.py` - *with* the ".py". But when we're talking about this object as a module, we call it `dinner_plate` - *without* the ".py".

Yeah, yeah, yeah. It sounds totally stupid to have two *slightly different* names for the same thing. But, believe it or not, this is going to end up mattering a LOT.

### Packages
If Python code lives in modules, then where do modules live? 

Modules live in folders (also called directories), or in Python-speak, **packages**.
Let me repeat that: packages are just folders.

Just as modules allow us to group Python snippets together, packages allow us to group modules together. 

For example, let's say that, in addition to our `dinner_plate` module, we create a similar module, `cup`, and we put it right beside `dinner_plate`.

`cup`

```python
class Cup( object ):
    def __repr__( self ):
        return "Cup()"
    
def make_cup():
    return Cup()
```

Here's what our world looks like now:

```text
.
├── cup.py
├── dinner_plate.py
└── GuideToImports.ipynb  # We're right here!
```

Now this is all well and good, but we might want to group `dinner_plate` and `cup.` together into a package named `flatware`. So, we create a folder named `flatware` and move `cup` and `dinner_plate` into that folder.

Now we have a **package** named `flatware` that contains two modules named `cup` and `dinner_plate`.

```text
.
├── flatware
│   ├── cup.py
│   └── dinner_plate.py
└── GuideToImports.ipynb # We're right here!

```

Lastly, packages can also have more packages inside of them! We call these inner packages **subpackages**, but there's nothing special about them. They just regular packages that happen to live inside of another package.

For example, let's create a subpackge inside of `flatware` named `utensils` and add two modules to it: `fork` and `spoon`.

`fork.py`

```python
class Fork( object ):
    def __repr__( self ):
        return "Fork()"
 
def make_fork():
    return Fork()
```

`spoon.py`

```python
class Spoon( object ):
    def __repr__( self ):
        return "Spoon()"
    
def make_spoon():
    return Spoon()
```

Now we have a package named `flatware` that contains two modules, `cup` and `dinner_plate`, as well as a subpacakge named `utensilts`. The `utensils` subpackage has two modules,`fork` and `spoon`.

```text
.
├── flatware
│   ├── cup.py
│   ├── dinner_plate.py
│   └── utensils
│       ├── fork.py
│       └── spoon.py
└── GuideToImports.ipynb # We're right here!
```

## Imports 101: The Basics of Using Imports
Now that we know where Python code lives, it's time to get back to our original question. 

How do we **import** a Python object from **where it lives** into **where we want to use it?**

To import an object, we need to do two things:
1. Identify the complete **path** from the top of our project to the object we want to import
2. Write an import statement

Keeping these two things in mind, let's go import some stuff!

### Importing a Module

Let's try to import the `fork` module!

#### Step 1: Identifying the Complete Path

We need to get the complete path from the top of our project to where `fork` is. 

```text
.
├── flatware
│   ├── cup.py
│   ├── dinner_plate.py
│   └── utensils
│       ├── fork.py
│       └── spoon.py
└── GuideToImports.ipynb # We're right here!
```

To get from the top of our project to `fork`, we have to go into the `flatware` package, then into the `utensils` package, and finally into the `fork` module. 

This means that the complete path from where we are to `fork` is:

`flatware.utensils.fork`

#### Step 2: Writing the Import Statement

Now that we have our path, `flatware.utensils.fork`, we're ready to write a real Python import statement.

Here's the syntax:


```python
import flatware.utensils.fork
```

And that we have it! We have successfully imported the `fork` module!

Take note: import statements import **modules**, not files. This means that we imported the `fork` **module**, not the `fork.py` file. 

We should never us ".py" when we're trying to import a module. *Because modules do not end in ".py"*

(See! The whole file vs. module thing from earliler came in handy!)

### Using the Imported Module

Now that we've imported `fork`, we're now ready to use the two objects inside of `fork`: the class `Fork` and the function `make_fork`. 

To use one of these objects - for example, the function `make_fork` - we need to use the complete path to `make_fork`: `flatware.utensils.fork.make_fork`


```python
import flatware.utensils.fork

flatware.utensils.fork.make_fork()
```




    Fork()



We got a fork object! Hurray!

That was pretty painless. The only headache was how much we had to type in order to call the `make_fork` function: `flatware.utensils.fork.make_fork()`

Luckily, Python provides a handy way around that.

### Importing an Individual Object from a Module

In our previous example, we imported the `fork` module and then accessed the `make_fork` function inside of `fork`.

This time, we're going to try something different. Instead of importing the `fork` module, we're going to import an single object from the `fork` module.

For example, we can reach into the `fork` module and import just the `make_fork` function:


```python
from flatware.utensils.fork import make_fork

make_fork()
```




    Fork()



And there's our Fork again! 

Notice how we no longer have to call `flatware.utensils.fork.make_fork()`, we can simply write `make_fork()`. Convenient!

Take note: we didn't import all of the objects that live in the `fork` module; we just imported `make_fork`. If we tried to access *anything else* from the `fork` module, we would run into an error.

Luckily, this "from ... " syntax doesn't limit us to importing only a single object. If we wanted to import the class `Fork` *and* the function `make_fork` from the `fork` module, we can do that in a single statement:


```python
from flatware.utensils.fork import make_fork, Fork

make_fork(), Fork()
```




    (Fork(), Fork())



### Nicknaming Our Imported Objects
We've now seen two different kinds of imports:
- **import a.path.to.a.module**
- and **from a.path.to.a.module import something**

But wait! There's more!

We can also give **nicknames** to the objects that we import!

Check this out:


```python
import flatware.utensils.fork as my_fork_module
my_fork_module.make_fork()
```




    Fork()



In writing `as my_fork_module`, we're giving a nickname to `my_fork_module` that only applies here. The original `fork` module didn't change.

Now when we want to call the function `make_fork`, we can use our nickname, `my_fork_module`.

Additionally, we can use nicknames with **from** imports!


```python
from flatware.utensils.fork import make_fork as fork_function

fork_function()
```




    Fork()



We can even import multiple objects *and* rename them:


```python
from flatware.utensils.fork import make_fork as fork_function, Fork as ForkClass

fork_function(), ForkClass()
```




    (Fork(), Fork())



### Absolute and Relative Imports
We haven't mentioned this before, but there are actually two different kinds of imports: absolute imports and relative imports.

#### Absolute Imports

With absolute imports, we have to include the name of every package and module in the path from the top of our project to the object we want to import.

absolute imports are what we've been using this whole time.


#### Relative Imports

Relative imports are different.

With relative imports, we **don't** have to include the name of every pacakge in our path. Instead, we can use special nicknames that Python assigns to packages depending on their position **relative** to where we are.

Specifically:
1. the package we're currently inside is nicknamed: **.** (a single dot)
2. the package one level above us is nicknamed: **..** (two dots)
3. the package two levels above us is nicknamed: **...** (three dots)

... and so on...

As an example, let's say we're working inside of `fork.py`, and we want to import the `make_cup` function from `cup.py` and the `make_spoon` function from `spoon.py`.

```text
.
├── flatware
│   ├── cup.py
│   ├── dinner_plate.py
│   └── utensils
│       ├── fork.py # Now we're right here!
│       └── spoon.py
└── GuideToImports.ipynb 
```

If we were using absolute imports, we would the full path from the beginning of our project to the objects that we want to import:
```python
from flatware.utensils.spoon import make_spoon
from flatware.cup import make_cup
```
But with relative imports, we can replace package names with dots. 

Since we're currently in `fork.py`...
- **.** (single dot) refers to our current package: `flatware.utensils`
- **".."** (double dot) refers to the pacakge above us: `flateware`

Making those replacements yields this:

```python
from .spoon import make_spoon
from ..cup import make_cup
```
**Important Note:** If we want to use relative imports, we must use `from`.


#### Absolute and Relative: Which Should We Use?
Generally speaking, we should prefer absolute imports over relative imports. 

Absolute imports are clearer than their relative counterparts. With absolute imports, we have the full and complete paths to our imported objects. With relative imports, we have to mentally convert the dots into packages and hope that we got it right. 

Of course, there is one big advantages to relative imports. Relative imports don't depend on the exact names of our packages. If we change the names of our packages but do not change their structure, absolute imports will break, but relative imports will still succeed. 

Is the extra flexibility of relative imports worth sacrificing the clarity of absolute imports? Perhaps not. These days, most text-editors and IDEs are capable of automatically renaming things for us -- we don't *need* the flexibility of relative imports. 

Of course this is a decision everyone has to make on their own.

## Imports 102: Importing a Module vs. Running a Module vs. Running a File

Now that we have explored the basics, it's time to venture off the garden path. Here's perhaps the most horrifying element of Python imports...

**We can have perfectly good imports that break completely depending on how we use our modules.**

For example, if we have a file, `cool_code.py`, that imports some things, those imports will behave differently depending on if we...

1. Import the `cool_code` module
2. Run the `cool_code` module
3. Run the `cool_code.py` file

(Also! Notice how, once again, we're differentiating between the `cool_code` module and the `cool_code.py` file.)

This sounds... nasty, confusing, and disappointing. 

Let's try and make sense of this using an example. Here's a simple project:

```text
vehicles
├── engines
│   └── truck_engine.py
└── trucks
    └── chevy.py
```

`truck_engine`

```python
class TruckEngine( object ):
	def start( self ):
		return "VROOM!"
```

`chevy`
```python
from vehicles.engines.truck_engine import TruckEngine

class Silverado( object ):

	def __init__( self ):
		self.engine = TruckEngine()

	def start( self ):
		return self.engine.start()
```

We have a `vehicle` package with two subpackages: `engines` and `trucks`. The `engines` subpackage has a `truck_engine` module with a `TruckEngine` class. The `trucks` subpackage has a `chevy` module with a `Silverado` class. 

The `Silverado` class needs an engine, so it imports `Truck` engine from the top of the project using the path `vehicles.engines.truck_engine`. 

### Importing a Module

Let's try importing the `Silverado` class and using it!


```python
from vehicles.trucks.chevy import Silverado

myTruck = Silverado()
myTruck.start()
```




    'VROOM!'



We imported our `Silverado` class from the `chevy` module and used it; everything worked perfectly.

No surprises here!

### Running a Python File

Now let's try running our `chevy.py` file. Our imports are good, and our Python is solid. Everything *should* work fine. Let's give it a go.

To run a Python file, we need to open up our command line (also called the terminal) and enter the `python` command followed by the path through our filesystem to our `chevy.py` file.

Like this...


```bash
%%bash
python vehicles/trucks/chevy.py
```

    Traceback (most recent call last):
      File "vehicles/trucks/chevy.py", line 1, in <module>
        from vehicles.engines.truck_engine import TruckEngine
    ModuleNotFoundError: No module named 'vehicles'



    ---------------------------------------------------------------------------

    CalledProcessError                        Traceback (most recent call last)

    <ipython-input-24-7f6debbca43d> in <module>
    ----> 1 get_ipython().run_cell_magic('bash', '', 'python vehicles/trucks/chevy.py\n')
    

    ~/.local/share/virtualenvs/GuideToImports-e6Nz-2ie/lib/python3.7/site-packages/IPython/core/interactiveshell.py in run_cell_magic(self, magic_name, line, cell)
       2350             with self.builtin_trap:
       2351                 args = (magic_arg_s, cell)
    -> 2352                 result = fn(*args, **kwargs)
       2353             return result
       2354 


    ~/.local/share/virtualenvs/GuideToImports-e6Nz-2ie/lib/python3.7/site-packages/IPython/core/magics/script.py in named_script_magic(line, cell)
        140             else:
        141                 line = script
    --> 142             return self.shebang(line, cell)
        143 
        144         # write a basic docstring:


    </home/cody/.local/share/virtualenvs/GuideToImports-e6Nz-2ie/lib/python3.7/site-packages/decorator.py:decorator-gen-110> in shebang(self, line, cell)


    ~/.local/share/virtualenvs/GuideToImports-e6Nz-2ie/lib/python3.7/site-packages/IPython/core/magic.py in <lambda>(f, *a, **k)
        185     # but it's overkill for just that one bit of state.
        186     def magic_deco(arg):
    --> 187         call = lambda f, *a, **k: f(*a, **k)
        188 
        189         if callable(arg):


    ~/.local/share/virtualenvs/GuideToImports-e6Nz-2ie/lib/python3.7/site-packages/IPython/core/magics/script.py in shebang(self, line, cell)
        243             sys.stderr.flush()
        244         if args.raise_error and p.returncode!=0:
    --> 245             raise CalledProcessError(p.returncode, cell, output=out, stderr=err)
        246 
        247     def _run_script(self, p, cell, to_close):


    CalledProcessError: Command 'b'python vehicles/trucks/chevy.py\n'' returned non-zero exit status 1.


Oh, the horror! 

What went wrong? Let's check out the error message at the *very* top and see if we can make any sense of this mess...

```text
Traceback (most recent call last):
  File "vehicles/trucks/chevy.py", line 1, in <module>
    from vehicles.engines.truck_engine import TruckEngine
ModuleNotFoundError: No module named 'vehicles'
```

When our `chevy` module tried to import `TruckEngine`, it failed because it couldn't find a module named `vehicles`. 

This is confusing for at least two reasons:
1. This import worked just fine a minute ago
2. What does Python mean by **No module named 'vehicle'?** Vehicle is a **package!** And it's right **there!**

To understand what's going on, we need to understand how Python actually finds modules to import.

#### How Python Finds Modules

When Python starts up, it creates a giant list of places where it'll look for modules that we want to import. If our module isn't in one of those places on the list, Python won't find it and all sorts of nasty errors will pop up.

This giant list of places is actually just a variable named `path` that lives inside of Python's built-in `sys` module. It's just a regular Python list with regular Python strings inside of it. We can import it and muck around with it just like any other list. 

Weirdly enough, the list `sys.path` starts out *completely empty*. There's nothing there, and if it stayed that way, we wouldn't be able to import anything. Luckily, Python automatically adds some things to `sys.path`. 

1. Python adds the directory containing all of Python's built-in modules
2. Python adds the directory containing all of the extra packages we've personally installed
3. And if we run a Python file (like we did just a minute ago), Python adds the directory containing the file we ran.

**Yeah, yeah, yeah. This is super interesting or whatever, BUT WHAT DOES ANY OF THIS MEAN???**

Our error noted that Python couldn't find the `vehicles` package, so `vehicles` must not have been in `sys.path`!

So let's think about what **was** in `sys.path`. As per above, `sys.path` has the directory containing all of the built-in modules, the directory containing all of our installed modules, and finally, `sys.path` has the directory containing the file we ran.

Since we ran `python vehicles/trucks/chevy.py`, the directory containing `chevy.py` was `trucks/`. So, the `trucks/` direcgtory got added in `sys.path`. 

See the problem? The `vehicles/` directory never got added to `sys.path`! This means that our import statement inside of the `chevy` module... 

```python
from vehicles.engines.truck_engine import TruckEngine
```

...completely fails because Python cannot find the `vehicles/` part of our path! 

#### So... Can We Fix This? Or Can We Never Run Python Code Again?

Well, there's the naive solution: right before Python reaches our `from vehicles.engines.truck_engine ...` import statement, we could manually add the `vehicles/` directory to `sys.path`. After all, `sys.path` is just a list. We can add things to it. 

This would work... but it is a **horrible** solution. It it just so hacky, so adhoc, and so ugly. It is also annoying: we don't want to add this...

```python
import sys.path
sys.path.append( "some/path/to/some/place" )`
```

...to the top of every file that might have a problematic import. That's terrible. 

#### Luckily, There Is Another Way!

Instead of running the **file** `vehicles/trucks/chevy.py`, we can instead run the **module** `vehicles.trucks.chevy`

If we run the **module** `chevy`, Python does something slightly different to `sys.path` than when we ran the **file** `chevy.py`. Instead of adding the directory containing the **file** (which was `/trucks`), Python will add our current directory to `sys.path`.

Let's remind ourselves what our current directory is...

```text
. # <--- This is our current directory
├── GuideToImports.ipynb # We're right here!
├── flatware
│   ├── cup.py
│   ├── dinner_plate.py
│   └── utensils
│       ├── fork.py
│       └── spoon.py
└── vehicles
    ├── engines
    │   └── truck_engine.py
    └── trucks
        └── chevy.py
```

Perfect! Our current directory contains `vehicles/`

This means that, as long as we run the `chevy` **module** instead of the `chevy.py` **file**, the `vehicles` package will be added to `sys.path`, thus allowing Python to find `vehicles` and everything underneath it!

#### But How Do We Run Something as a Module?

As it turns out, it's trivially easy to run something as a module instead of as a file.

Instead of running...

```text
%%bash
python vehicles/trucks/chevy.py
```

...in our command line / terminal, we need to run...


```bash
%%bash
python -m vehicles.trucks.chevy
```

**AND IT WORKS! WE DON'T GET AN ERROR!**

There are two things to notice:
1. We added "-m" to our command. This tells Python that we're running a **module** and not a **file**.
2. We used "vehicles.trucks.chevy", not "vehicles/trucks/chevy.py". This is because...
    - Files are separated by slashes, but packages and modules (like all of our imports) are separated by dots.
    - Pyton files end in ".py", but modules do not
    
Once again, the seemingly trivial difference between files and modules saves the day once again.


### This Has Been a Long, Difficult Section. Let's Summarize.

- If we want to **import** modules, there's no need to worry. As long as we wrote valid import statements, Python can figure everything out for us.
- But if we want to **run** a file or a module, we need to think about `sys.path`
    - No matter what, `sys.path` will contain the directories where built-ins and user-installed modules  live.
    - If we run a Python **file**, `sys.path` will contain the directory where our file lives
    - If we run a Python **module**, `sys.path` will contain our current directory.
        - You run a Python file like this: `python path/to/your/file.py`
        - And you run a Python module like this: `python path.to.your.file`

## Imports 201: Best Practices

Now that we understand how to use imports, it's time to understand how to use imports *properly*.

### Where Do We Put Our Imports?

- We put imports at the very top of our Python modules, right after any comments/docstrings, and right before any module-level variables.

```python
"""
Here are some comments! Comment, comment, comment!
"""

import math
import sys

MODULE_LEVEL_VARIABLE = ( "Big", "Old", "Variable" )
```

Every other option is terrible. Full stop. Do not suprise folks with hidden imports.

### How Do We Organize Our Imports?

- Every new import goes on a new line. The only exception are `from...` imports.

```python
import math
import sys
from my_module import function_one, function_two
```

- Group imports from the same packages together

```python
import math
import my_package.my_module          # Imports from `my_package` are together
import my_package.my_other_module  
```

- You should have three different sections of imports, each separated by a new line. Those sections are...
    - Built-in imports
    - Third-party imports
    - Local imports 
    
```python
import math # 
import os # math and os are built-in

import pandas
import requests # pandas and requests are third-party modules

from ..my_package.my_module import my_function
import my_pacakge.my_subpackage.my_other_module # These are local imports
```

### How Do We Feel About Relative vs. Absolute Imports Again?

- We generally prefer absolute imports over relative imports. 
    - Absolute imports make it clearer where the import is coming from. 
        - But if your absolute imports are getting incredibly long, relative imports can help. 
        - Additionally, if you think that the names of your packages will change (but their structure won't), relative imports can also help.   
        
```python
from my_package.my_subpackage.my_module import my_function # We tend to prefer this...
from ..my_subpackage.my_module import my_function          # ...over this.
```

### How Do We Feel About Nicknames?

- We treat them with suspicion, especially if we're nicknaming individual functions, classes, and variables.

```python
import my_package.my_subpackage.my_subsubpackage.my_module as my_module # This is...fine.
import my_module as jelly_beans # This is seriously questionable
from my_module import function1 as function2 # This is a horrible idea
```

### How Do We Feel About Using "from..." to Import Subpackages?

- We feel okay about importing subpackages, as long as you make sure that your subpackage doesn't share the same name as a third-party or built-in object.

```python
from my_package import my_subpackage # We feel okay about this...
                                     #...if my_subpackage is unique.
```

### Can We Import Something From Somewhere Other Than Where It Was Defined?

- Ugh... Yeah.. We can do this. **BUT We SHOULDN'T!** We should import objects from the module in which they were originally defined.

`module_a`
```python
from my_package.my_subpackage import my_function
```

`module_b`
```python
from module_a import my_function # BOO! HISS! TERRIBLE!
```



## Where to Go from Here?

Onwards into [the Python documentation!](https://docs.python.org/3/reference/import.html#replacing-the-standard-import-system)
