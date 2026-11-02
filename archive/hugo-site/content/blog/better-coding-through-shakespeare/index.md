---
title: "Better Coding Through Shakespeare"
summary: "Software engineer theory meets Renaissance drama in a rambunctious seven-part tutorial."
slug: "Better-Coding-Through-Shakespeare"
categories: 
- programming
- python
- tutorial
date: 2018-09-15
---

Shakespeare, as Ben Jonson reminds us, is "not of an age but for all time."
So, naturally, he has lots of good advice on computer programming.

This 7 part series draws on Shakespeare's plays and Robert C. Martin's *Clean Code* to illustrate some essential programming practices that rarely get covered in conventional "Learn to Code!" contexts. By the end of this post, you'll have quality answers to some of programming's toughest questions. What separates good variable names from bad ones? How big should functions be? When are comments necessary? 

This blog post answers all of these questions (and more!) with level-headed pragmatism and a sizeable dollop of Shakespearean humor. So, sit back, relax, and enjoy...

# Better Coding Through Shakespeare

## Act I: Naming Things. Or, Romeo Is a Dreadful Programmer

In *Romeo and Juliet*, Romeo famoulsy opines...

> *What’s in a name? That which we call a rose*
>
> *By any other name would smell as sweet.*[[1]](#romeo)

Now that might be a fine philosophy for Montagues and Capulets, but it's a *dreadful* way to approach programming.

**Names matter**. 

Well-named variables, functions, and classes can significantly improve the readability and maintainability of a program.

For example, check out this function:


```python
def get_result(l):
    result = list()
    for i, j in l:
        if j > 40:
            result.append(i)
    return result
```

To quote Robert Martin,
> The problem isn’t the simplicity of the code but the *implicity* of the code. [[2]](#clean1)
You might know *what* this code does, but you have no idea *why* it's doing it. What's the significance of the number 40? What's `i`? What's `j`?
What are the inputs? The outputs?

You just don't know.

But with a little thoughtful renaming, everything becomes clear:

```python
OVERTIME_CUTOFF = 40

def get_employees_with_overtime(employees_and_hours):
    employees_with_overtime = list()
    for employee_name, hours_worked in employees_and_hours:
        if hours_worked > OVERTIME_CUTOFF:
            employees_with_overtime.append(employee_name)
    return employees_with_overtime
```

Ah, that's better! Now you know *exactly* what this function and all of its variables are for.

#### See Names as Opportunities to Add Value

This is dreadful:
```python
s = 50000
```

This is better:
```python
salary = 50000
```

But this is best:
```python
base_salary= 50000
```

#### i,j,k (and Friends) Are Only For Indices

Let's say you want to iterate through a list of office locations for a Texas-based company:
```python
office_locations = ["Houston", "Austin", "Dallas"]
```

This is awful. `i` adds no value here; it can only confuse you.
```python
for i in office_locations: 
    pass 
```

This is vaguely acceptable, but only if you know that (1) enumerate returns indices and (2) `i` is a conventional name for indices
```python
for i, location in enumerate(office_locations):  
    pass
```

These two options are likely the best. These variable names help communicate the intention of the code (to iterate through locations) and even make the semantics of "enumerate" clearer.
```python
for location in office_locations:
    pass
    
for loc_index, location in enumerate(office_locations):
    pass
```

#### Don't Add Types If They Don't Add Information

Appending type information to variables is usually a poor idea.
Variable names can lie -- there's nothing to stop a variable named `this_is_totally_a_list` from being (or becoming!) something other than a list.
So, don't add typing information through variable names. Instead, use your language's type system (or type hint system!) -- it's there for a reason.

These variables, for example, are probably poorly named:
```python
employee_name_string = "Robin"
employee_name_list = ["Robin", "Sam", "Alex"]
```

#### Make Sure You Can Pronounce It

If you need a variable for a company street address, don't do this:
```python
cmpy_strt_adr = "100 Foo Street" 
```
No one wants to stumble through pronouncing "cumpy stert adder".
Be kind to yourself and your coworkers -- create names that aren't torturous to pronounce.

#### Variables and Classes are Nouns. Functions and Methods are Verbs.

Classes model things; methods model actions. Nouns represent things; verbs represent actions. 
There's a natural division here, and you should respect it. Use nouns to name your classes; use verbs to name your methods.

Don't do this:
```python
class GetEmployeeInfo(object):
    
    def years_of_service_calculator(self):
        pass
```

Instead, do this:
```python
class Employee(object): # GOOD!
    
    def get_years_of_service(self): # GOOD!
        pass
    
```

#### Pick Your Conventions and Stick with Them

If you use snake_case for methods, use snake_case. If you prefer camelCase, use camelCase. 

If you like using the "get" prefix, that's great -- don't stray into "fetch" or "acquire" unless you have an *very* convincing use-case. 

Inconsistent conventions magnify the cognitive burden of reading code; consistent conventions ease that burden.
This might *seem* trivial, but I assure you it is not. Programming is hard enough without cognitive self-sabotage.

So, definitely don't do this:
```python
class Employee(object):
    
    def getName(self):
        pass
    
    def fetch_title(self): 
        pass
    
    def Return-Salary(self):
        pass
    
    def aCqQiReMaNaGeR(self):
        pass
```

## Act II: Functions. Or, Hermia Would Make a Good Function

In *A Midsummer Night's Dream*, Helena says of Hermia...

> And though she be but little, she is fierce.[[3]](#dream)

Just the qualities we want in a function: little and fierce.

Programs made up of small, powerful functions are easier to understand, easier to test, and easier to maintain.

Check out this big ol' function. No need to get too involved with it. It is, after all, fake. But glance through it and get the gist.

```python
def promote_employee(employee, new_title):
    
    # give the employee his new title, adding 'Senior' or 'Junior' if necessary
    if employee.years_of_service > 10:
        fully_udated_title = "Senior " + new_title
    elif employee.years_of_service < 2:
        fully_udated_title = "Junior " + new_title
    employee.title = fully_udated_title
    
    # compute the employee's new salary
    new_salary_bracket_min, new_salary_bracket_max = human_resources.get_salary_bracket(new_title)
    if employee.salary <= new_salary_bracket_min:
        new_salary = new_salary_bracket_min
    elif employee.salary >= new_salary_bracket_max:
        new_salary = new_salary_bracket_max
    else:
        new_salary = ( new_salary_bracket_min + new_salary_bracket_max ) / 2.0
    employee.salary = new_salary

    # compute the employee's new 401k matching
    if human_resources.is_role_401k_eligible(new_title):
        new_max_401k_matching = human_resources.get_max_401k_matching(new_title)
        min_401k_matching = human_resources.get_company_minimum_401k_matching()
        if employee.matching_401k == 0:
             new_matching_401k = min_401k_matching
        else:
            new_matching_401k = min(new_max_401k_matching, employee.matching401k + 0.01)
    else:
        new_matching401k = 0
    employee.matching_401k = new_matching_401k

    # compute the new stock compensation
    stock_level_1, stock_level_2, stock_level_3 = human_resources.get_stock_levels(new_title)
    if employee.tenure > 20:
        new_stock_total = stock_level_3
    elif employee.tenure > 10:
        new_stock_total = stock_level_2
    else:
        new_stock_total = stock_level_1
    employee.stock = new_stock_level

    return employee
```

That's one *long* function. It isn't terribly easy to read, the logic of each individual part obfuscates the function's larger goal, and there are control-flow statements everywhere. The comments help *a little*, but they shouldn't be necessary. 

In short, this function isn't short, and it isn't clear.

Compare it with these beautiful little functions:

```python
def promote_employee(employee, new_title):
    update_title(employee, new_title)
    update_salary(employee, new_title)
    update_401k_matching(employee, new_title)
    update_stock(employee, new_title)
    return employee
    
def update_title(employee, new_title):
    if employee.years_of_service > 10:
        new_title = "Senior " + new_title
    elif employee.years_of_service < 2:
        new_title = "Junior " + new_title
    employee.title = new_title
    
# imagine that the rest of the new "update" functions are similarly defined below
```

Now *that* is readable! 

It's immediately clear, even at a glance, what is involved in promoting an employee. The details of updating title, salary, 401k, and stock no longer obfuscate the larger purpose of `promote_employee`. If anyone cares about the finer details of, say, title updating, they can go look in `update_title`. 

There are three tricks here: (1) functions should be small, (2) do only one thing, and (3) operate at a single level of abstraction. The next sections cover each trick in detail.

### Function Trick #1: Functions Should Be Small

To quote Robert C. Martin on it,

> The first rule of functions is that they should be small. The second rule of functions is that
*they should be smaller than that*. [[5]](#clean2)

Very clever. But how small is "smaller than that?" 

Honestly, there isn't a universally-accepted measure of "small." Here are some statistics from a Ruby codebase written by Martin Fowler. Fowler is something of a thought-leader in software engineering theory, so one could do worse than emulating him.

 - 59% of his functions are less than three lines
 - 75% of his functins are less than five lines
 - 93% of his functions are less than ten lines [[6]](#function)

Now those are some small functions! Granted, Fowler is both (1) particularly devoted to the idea of small functions and (2) writing in Ruby, a particularly terse language. 
Your definition of small need not be the same as Fowler's; you should treat these numbers as shaggy heuristics rather than a statements of Truth.

As a general rule, if your functions start to exceed 10 lines, you should take a step back and ask yourself: does this function *really* need to be this big?
The answer might very well be "Yes!", but it's probably "No..."

Luckily, if you follow trick #2, your functions will naturally remain small.

### Function Trick #2: Functions Should Do One Thing 

To quote Robert C. Martin again,

> Functions should do one thing. They should do it well. They should do it only. [[7]](#clean3)

This, of course, begs the question: how does one know if a function is doing only one thing? 

This is relatively straightforward: try to extract out another meaningful function -- if you're successful, then your function was doing more than one thing. To illustrate this, take another look at `promote_employee`:


```python
def promote_employee(employee, new_title):
    update_title(employee, new_title)
    update_salary(employee, new_title)
    update_401k_matching(employee, new_title)
    update_stock(employee, new_title)
    return employeee
```

Keeping in mind the idea that functions should do only one thing, is there another function that could be extracted from `promote_employee`?

There's an argument to be made that `update_salary`, `update_401k_matching`, and `update_stock` might be extracted into a new function: `update_compensation`.
This new function does one thing -- it updates an employees compensation.

Take a look:

```python
def promote_employee(employee, new_title):
    update_title(employee, new_title)
    updated_compensation(employee, new_title)
    return employee

def update_compensation(employee, new_title):
    update_salary(employee, new_title)
    update_401k_matching(employee, new_title)
    update_stock(employee, new_title)
```

Now those are some good looking functions! Try as you might, there just doesn't seem to be any way of extracting additional meaningful functions from either `promote_employee` or `update_compensation`. These functions have been divided up into their smallest reasonable logical components, and as a result, they are small, readable, easy to test, and easy to maintain.

### Function Trick #3: Functions Should Operate at a Single Level of Abstraction

This final function trick is, unsurprisingly, a little more abstract. What exactly is a "level of abstraction"? And why should functions only operate at one of them?

Put simply, a level of abstraction is a level of detail. High levels of abstraction are light on details; low levels of abstraction of heavy on details.

Consider `update_compensation`:

```python
def update_compensation(employee, new_title):
    update_salary(employee, new_title)
    update_401k_matching(employee, new_title)
    update_stock(employee, new_title)
```

This function operates at a relatively high level of abstraction -- it's concerned with *what* updating compensation entails, not with *the details* of how compensation updates are carried out. If, for example, you decided to include the specific details of `update_stock` in `update_compensation`, you would end up with a rather muddled looking `update_compensation` function:

```python
def update_compensation(employee, new_title):
    update_salary(employee, new_title)
    update_401k_matching(employee, new_title)
    stock_level_1, stock_level_2, stock_level_3 = human_resources.get_stock_levels(new_title)
    if employee.tenure > 20:
        new_stock_total = stock_level_3
    elif employee.tenure > 10:
        new_stock_total = stock_level_2
    else:
        new_stock_total = stock_level_1
    employee.stock = new_stock_level
```

`update_compensation` is now operating at two levels of abstraction, two levels of detail. It contains high-abstraction, low-detail salary and 401k updates.
But it also contains a very low-abstraction, high-detail stock update. This update just doesn't *fit*. It makes `update_compensation` harder to read, harder to describe, and harder to understand in the context of the employee-promoting process.

So after you code up a function, ask yourself if it's operating at a single level of abstaction. If it isn't, you've likely discovered an excellent opportunity to make your code easier to read, explain, and maintain.


## Act III: **"Come hither, come hither. How did this argument begin?" Or, Arguments Confuse Don Adriano (And Everyone Else)** 

Arguments complicate your code. There's no way around it.

Arguments make testing, understanding, and debugging code more difficult, and that difficulty grows *exponentially* in the number of arguments.

Naturally, our friend Robert C. Martin agrees:

> The  ideal  number  of  arguments  for  a  function  is
zero (niladic). Next comes one (monadic), followed
closely  by  two  (dyadic).  Three  arguments  (triadic)
should be avoided where possible. More than three
(polyadic)  requires  very  special  justification — and
then shouldn’t be used anyway. [[9]](#clean4)

Martin takes a pretty hard line against arguments. There are, in fact, some excellent reasons to write functions with more than three functions.
Heavily-used public-facing objects (like Python's [pandas dataframe](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html)) intentionally heap loads of functionality into a fantastically convenient interface that necessarily requires a larger number of arguments.

But! Martin is right in the *general* case. Testability, readability, and maintainability do tend to decrease as the number of arguments increases. 
Accordingly, you should do your best to limit the number of arguments in your functions and classes.

Here are some tricks for tamping down your arguments!

### Argument Trick #1: Make Your Arguments Classy

You might be writing a function like this...


```python
def manipulate_3D_point(x, y, z):
    # Do something nifty with a point sitting in three dimensions.
    pass
```

Any function that needs to know about a point sitting in 3D space will need *at least* three arguments: x, y, and z. But that's not a stellar start to writing functions with only a few arguments.

What's a programmer to do?

Well, since `x`, `y`, and `z` are all necessary to make a 3D point, they can (and should!) be bound up in a 3D point class!


```python
class Point_3D(object):
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
        
def manipulate_3D_point( a_3D_point ):
    # Do something nifty with something a point sitting in three dimensions.
    pass
```

*Much* better! You're function has all the information it needs, you've minimized your argument list, and I'd even argue that you added significant clarity to your code by adding a simple little class. (Note: for Pythonic fun with classes that simply bind data together, check out Python's [namedtuple](https://docs.python.org/3/library/collections.html#collections.namedtuple).

Granted, this example is pretty obvious. But the point remains (pun intended): when your argument list starts to grow, some of your arguments are likely related enough to make a coherent class.

### Argument Trick #2: Make Sure Arguments Don't Come OUT of Functions

Arguments are confusing enough. But arguments that come *out* of functions are even worse.

At this point you should be a little confused. Don't arguments go *into* functions by definition? Why yes. They do. But if you're not careful, they can surprise you (and everyone else) by coming back *out* of your functions. Let me illustrate.

Imagine that you're reading some (icky) code, and you stumble across this little gem:

```python
text = extend_text( text, extend_value )
```

This line of code looks like it probably...
- Takes a text and another value as arguments
- Extends the text using `extend_value`
- ...and then returns text again.

So text goes *in*, and then comes back *out*. Yuck.

This works significantly better as
```python
text.extend( value )
```
Ah, much better! `value` goes *in*, `text` comes *out*, and no one is surprised.

### Argument Trick #3: Flags are for Countries, Not for Programmers

Programmers *love* passing flags to functions. 

Like so...


```python
class SomeCrazyData(object):
    def output_data(self, as_CSV):
        if as_CSV:
            # Output the data as CSV
            return some_CSV
        else:
            # Output the data as JSON
            return some_JSON
```

Look how simple! Now you can get `output_data` to return the data in CSV *or* JSON format. All you have to do is pass a boolean flag and WHAM! You're done!

But this function makes me feel really uneasy.

- `as_CSV` is a boolean. If its value is `True`, then it returns a CSV. If its value is the *opposite* of `True`, then it returns... Uh... Well I guess it returns the opposite of a CSV. Whatever that is. I haven't the foggiest idea.
- Functions do one thing! But... This function does two things. One for the `True` case and another for the `False` case. That's unfortunate.
- The function's name and arguments don't tell me what I can use the function for! To figure that out, I have to rely on good documentation (Ahahahahaha! Yeah right...) or look around inside the function until I figure it out.

To recap, we have a function with an ambiguous argument that does two things without making it clear from its definition what those two things are. 

Yuck.

It's a much better idea to do something like this:


```python
class SomeCrazyData(object):
    def output_data_as_CSV(self):
        # Output the data as CSV
        return some_CSV
    def output_data_as_JSON(self):
        # Output the data as JSON
        return some_JSON
```

Do yourself a favor: don't use flags unless you *absolutely* have to.

### Argument Trick #4: Leave "None" Alone!

None is so tempting. But it's usually a sub-optimal idea.

It is a value that represents the absence of any value. And that alone should make you feel weird.

You cannot iterate through None. You cannot cannot use it as a function. It has no attributes, and it has no methods. All None will ever do for you is raise the exception "AttributeError: 'NoneType' object has no attribute..."

If you return it from a function, it will force every caller of your function to perform None-checks. If they forget a check, they risk an AttributeError. 

If you pass it into a function, (especially as a default argument), you'll obfuscate your logic with None-checks and doom your helper functions to the same fate.

And yet, None still gets used because it is convenient. It has no features: all you can do with it is ask "Are you None?" 

Given its simple featurelessness, folks use None to store all kinds of random information: Did I ever set this variable? Did I call this function? Did I succeed in some task? *All* sorts of things. 

They're all a mistake. There is *always* a better way to signal your intention than with a None.

You could...
- Raise an exception (potenially in a try-except block) to signal that something invalid happened
- Ditch the default argument. If an argument doesn't have a sensible default, then why are you trying to force one on it?
- Use a sensible, non-mutable default: a custom "empty" class or an enum.
- Re-architect your functions and logic so that they don't need None. Your code will almost certainly be more robust as a result.

Just try not to use None.

If you're still not convinced, consider for a moment that Turing award-winning computer scientist Tony Hoare [believes that None (aka: the null refernece) is a mistake](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare). And he invented it.

## Act IV: "Forgive the comment that my passion made / Upon thy feature" [[11]](#john) Or, King John Regrets Commenting and You Should Too

Comments are weird. 

Countless programmers extol the virtues "well-commented" code, but no two people ever seem to have the same idea of what "well-commented" means. Now why is that? As you might have come to expect, we're going to turn to Robert C. Martin for the answer:

>The  proper  use  of  comments  is  to  compensate  for  our  failure  to  express  ourself  in
code. Note that I used the word 
failure. I meant it. Comments are always failures. [[12]](#clean5)

It is worth repeating: comments are always failures. We fail to express ourselves clearly in code, and so we leave a comment behind to mark that failure. Over time, that comment slowly forgets its purpose as the surrounding system evolves. And then one day, the comment looks up and realizes that it no longer means anything to anyone. It has no purpose. All it can do is wait to be deleted or replaced.

Almost brings a tear to your eye, doesn't it?

If only our programming languages were more expressive -- if only *we* were more expressive! 
But they aren't, and we're not. So there are still a few kinds of neccesary (but necessarily evil!) comments.

### Dire Warnings


```python
# DONT CHANGE THIS NUMBER. If it isn't EXACTLY equal to 4, then - believe it or not - the San Andreas Fault will violently hemorrhage
# and cause San Francisco to topple helplessly into the Pacific.
b = 4
```

Occasionally, things like this happen. Systems aren't always as robust as we'd like them, and programmers who've erred leave warnings behind. They're often valuable, and not to be dismissed without investigation.

### Explaining Interfaces You Don't Own


```python
# This only works if you pass in the username in Pig Latin...
fetch_BookFace_messages(username="odycay anzandtvay")
```

We hope that all public APIs are well-documented and entirely unastonishing. But that's just not the case. Ocassioanlly, Alice-in-Wonderland-esque functions climb out of the rabbit hole and make their way into our systems. We can sputter and swear and jump up and down all we'd like, but there's often very little we can do to change wonky code that we don't own. All we can do is leave a comment and hope for the best.

Admittedly, the wonky code might one day change and our comment will become unnecessary. But 'til then, a few words might save our colleagues loads of time and energy.

### Explaining the Truly Esoteric

Occasionally, you'll find yourself coding in the footsteps of someone with a skill set very different from your own. That previous coder might be, for example, a math PhD. And although she has long left the firm, she did provide a nice equation to help you understand her code:

\begin{align*}
 &a=12+7 \int_0^2
  \left(
    -\frac{1}{4}\left(e^{-4t_1}+e^{4t_1-8}\right)
  \right)\
\end{align*}



Alas, your degree isn't in math, so you don't haveno hope of making sense of this.

*However!*

Your erstwhile colleague also provided a nice, English description of this equation's purpose and implementation in a comment:


```python
# Here's exactly what the equation does and why...
# <insert clear explanation here>
```

Now you can impress your fellow developers at the next meeting with your lucid descriptions of complex computations. 

Hurray!

### Licenses, Test Files, Permissions, Primary Maintainers, and Other Necessities


```python
"""
Primary: Cody VanZandt
Permission Group: Blah Blah and Foo
Tests: /tests/ThingDoer.py
License: Creative Commons 4.0 Attribute
"""

def a_very_important_function():
    # do some very important computational business
```

This stuff is pretty important in systems with lots of developers. Some folks might even scrape and mine a large collection of it for its secrets. 

Not *all* such file statistics are useful (things like version number are generally best left to version control software), but a lot of them are, so they're ofen worth including. 

## Act V: "You are too blunt. Go to it orderly." Or, Petruchio Needs Better Formatting

Poor formatting can hamstring your readers just as easily as poor design.

If no one knows where to look for anything, the task of understanding what's actually happening grows more difficult.

You (and everyone who reads your code) will be grateful if you spend a litte time formatting your code to be readable and unsurprising. 

### How Long Should a File Be? 

The short answer? I don't know.

Just long enough and not any longer, I think. 

1000 lines is usually too many, and a single line is usually too few. In truth, file length isn't the sort of thing you should optimize. You should instead ask yourself "In one sentence, what is this file doing?" If you can't answer that question without a slough of commas and conjuctions, then you're file is too long. See, files - just like functions - should only do one thing.

### Where Should I Put Things?

Ah, now this question is much easier!

I am, unsurprisingly, a huge fan of Robert C. Martin's answer...

>We would like a source file to be like a newspaper article. The name should be simple
but explanatory. The name, by itself, should be sufficient to tell us whether we are in the
right  module  or  not.  The  topmost  parts  of  the  source  file  should  provide  the  high-level
concepts and algorithms. Detail should increase as we move downward, until at the end
we find the lowest level functions and details in the source file. [[13]](#clean6)

That is a fantastic simile: a source file is a like a *newspaper article*.

Let's look an example of this done *really* wrong:


```python
def add_report_content(empty_report):
    content = get_report_content()
    full_report = empty_report + content
    return full_report

def make_unformatted_report():
    return "An unformatted report"

def format_report(unformatted_report):
    return unformatted_report.format()

def make_report_base():
    unformatted_report = make_unformatted_report()
    return format_report(unformatted_report)

def get_report_content():
    return "Some content."

def make_report():
    report_base = make_report_base()
    finished_report = add_report_content(report_base)
    return finished_report
```

How obvious is this program's flow? Can you glance through it and tell me how these functions work together? Which functions depend on which other functions?

It's not obvious. 

Sure, you can probably look around and figure out that everything starts with `make_report`, but the file leads you on a merry chase - up and down, and up and down, and... Eh. It's a mess.

Compare with this...


```python
def make_report():
    report_base = make_report_base()
    finished_report = add_report_content(report_base)
    return finished_report

def make_report_base():
    unformatted_report = make_unformatted_report()
    report_base = format_report(unformatted_report)
    return report_base

def make_unformatted_report():
    return "An unformatted report"

def format_report(unformatted_report):
    return unformatted_report.format()

def add_report_content(empty_report):
    content = get_report_content()
    full_report = empty_report + content
    return full_report

def get_report_content():
    return "Some content."
```

Now that's *much* better!

What does this file do? It's right at the top: it makes a report with `make_report`.

You can follow the logic of `make_report` first through `make_report_base` and then through `add_report_content`. Each of which is located (along with its dependent functions) in order right below `make_report`.

It's just like a well structured essay:
- Thesis (`make_report`)
    - Topic 1 (`make_report_base`)
        - Support for Topic 1 (`make_unformatted_report`)
        - Support for Topic 1 (`format_report`)
    - Topic 2 (`add_report_content`)
        - Support for Topic 2 (`get_report_content)

### Do Not Line Up Your Assignments

Lastly, a minor and perhaps controversial suggestion.

Let's say you have a big ol' load of assignment statements...


```python
def some_function():
    a_second_long_variable = 5
    short_var = 1
    an_extremely_long_variable_name = 6
    longer_variable = 3
    also_short = 2
    an_even_longer_variable = 4
    return "Boo! Terrible!"
```

So you think to yourself, 

"Gee, those staggered assignment statements sure look ugly. Let me fix that up..."


```python
def some_function():
    a_second_long_variable =          5
    short_var =                       1
    an_extremely_long_variable_name = 6
    longer_variable =                 3
    also_short =                      2
    an_even_longer_variable =         4
    return "Boo! Terrible!"
```

Ah! That's much better!

Except... it isn't better at all. It's worse.

Firstly, you missed the point. The problem isn't that loads of staggered assignments right in a row look ugly. The problem is that you have loads of staggered assignments. Don't try to hide that issue under a fresh coat of paint; fix it. 

Secondly, you forgot what assignment statements are really about. You've drawn the eye away from the assignments and towards the giant list of values. But *assignment* is the important thing here, not the giant list of values.

And finally, this non-traditional assignment plays tricks on the mind. If I didn't know better, I *might* think for a crazy second that `short_var` is equal to a large amount of whitespace followed by a `1`. 

Weird.

## Act VI: "Doth not the object cheer your heart, my lord?" Or, Queen Margaret Loves Object-Oriented Programming

Objects are great; object-oriented programming is *fantastic*.

And while I don't have the space in this series (let alone this section) to read you the riot act on object-oriented programming, I do have enough space to answer two of the most important questions on classes.

First up...

### When Should You Use a Class?

There are many reasons to use classes!

Here's a useful (though wildly incomplete) list:
- To protect your data from accidental or incorrect manipulation
- To keep data items close to the functions that act on them
- To reduce code reuse
- To model life in code with fidelity
- To provide useful abstractions that make complex systems understandable
- And more!

But at the end of the day, all of these reasons reduce down to one: you have a rag-tag set of variables (and optionally: functions) that would probably work better if you imposed a little structure. 

So something like this...


```python
def do_something(a, b, c):
    pass

def do_something_else(a, b, c):
    pass

def do_yet_another_thing(a, b, c):
    pass
```

Usually works better like this...


```python
class ABC_Thing(object):
    
    def __init__(self, a, b, c):
        self.a = a
        self.b = b
        self.c = c
        
    def do_something(self):
        pass
    
    def do_something_else(self):
        pass
    
    def do_yet_another_thing(self):
        pass
```

### How Big Should Classes Be?

To quote Robert C. Martin one last time,

>The first rule of classes is that they should be small. The second rule of classes is that *they
should be smaller than that*.[[15]](#clean7)

But, we will ask for one last time in this series: just exactly how small *is* small?

Unlike functions, it's not productive to measure size in lines. A class might work with 20 (hopefully small) methods, or with two.

The only reliable way to corral the size of your classes is to look at how many *responsibilities* that class performs. 

Because like functions, a class *should only do one thing*.

For example...


```python
class Lamp(object):
    
    def turn_on(self):
        pass
    
    def turn_off(self):
        pass
    
    def convert_to_AC(self, direct_current):
        pass
    
    def convert_to_DC(self, alternating_current):
        pass
```

Now I'm no electrician, but I'd say that a lamp probably shouldn't know anything about converting different currents. That should probably be in a class called... uh... whatever it is you call the thing that converts currents.

Whatever that thing is called, the point remains the same: you shoulnd't be afraid to split up an overburdened class into a handful of smaller, cleaner classes.

## Act VII: Final Words, Or What You Will

If you've made it all the way through *Better Coding Through Shakespeare*, I congratulate you. This series weighs in at a few thousand words and includes a fair bit of code. It's not exactly light reading.

I hope that you've found this series instructive, but I'll also accept that you believe I am...

>"A most notable coward, an infinite and endless liar, an hourly promise breaker, the owner of no one good quality." [[16]](#all) 

And you know, that's fine by me.

I didn't write this series to proselytize for my particular coding religion. I wrote this because these questions of functions, arguments, comments, formatting, and objects are all worth asking. It doesn't matter that you've accepted my answers, only that you've considered the questions.

Thanks for reading, and good luck out there.

[ Exit, pursued by a bear. ] [[17]](#winter)

## Works Cited

<a name="romeo">[1]</a> Shakespeare, William. *Romeo and Juliet.* II.ii

<a name="clean1">[2]</a> Martin, Robert C. *Clean Code.* 18.

<a name="dream">[3]</a> Shakespeare, William. *A Midsummer Night's Dream.* III.ii

<a name="mom">[4]</a> Thanks, Mom!

<a name="clean2">[5]</a> Martin, Robert C. *Clean Code.* 34

<a name="function">[6]</a> Fowler, Martin. https://martinfowler.com/bliki/FunctionLength.html 

<a name="clean3">[7]</a> Martin, Robert C. *Clean Code.* 35

<a name="love">[8]</a> Shakespeare, William. *Love's Labor's Lost.* III.i

<a name="clean4">[9]</a> Martin, Robert C. *Clean Code.* 40

<a name="john">[10]</a> Shakespeare, William. *King John* IV.iii

<a name="clean5">[11]</a>Martin, Robert C. *Clean Code.* 54

<a name="shrew">[12]</a> Shakespeare, William. *The Taming of the Shrew* II.i

<a name="clean6">[13]</a> Martin, Robert C. *Clean Code.* 77

<a name="henry">[14]</a> Shakespeare, William. *Henry VI* II.

<a name="clean7">[15]</a> Martin, Robert C. *Clean Code.* 136

<a name="all">[16]</a> Shakespeare, William. *All's Well That Ends Well* III.VI

<a name="winter">[17]</a> Shakespeare, William. *Winter's Tale* III.iii
