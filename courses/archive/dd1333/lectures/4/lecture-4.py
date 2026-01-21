#lists are a subtype of so-called sequences
#a python list is a linked list of pointers to data with very little syntax
#in C, each node would be something like this:
#
#struct {
#   prev: int*;
#   index: int;
#   next: int*;
#} node;
#
#lists are _not_ arrays, due to the linked list structure, they are much
#more performance and memory intensive, but also more loosey
#
#a tuple is an _array_ of references, this means that the length of a tuple
#is immutable

li = list()
li.append("CFATE")
li.append(2025)
li.append(False)

print(li)
#>  ["CFATE", 2025, False]

#indexing
print(li[1])
#>  2025


#dicts

#a dict is more akin to a hashmap, it uses key-value pairs.
di = {
        "foo": "value_1",
        "bar": 2,
        "baz": True
        }

print(di)
#>  {"foo": "value_1", "bar": 2, "baz": True}

print(di["bar"])
#>  2

#when doing a simple iteration over a list, you get the key
for qux in di:
    print(qux)
#>  foo 
#>  bar 
#>  baz

for qux in di:
    print(di[qux])
#>  value_1
#>  2 
#>  True


#sets
#a set is an unindexed _set_ of values
vowels = {'a', 'e', 'i', 'y', 'o', 'u'}
s = "test string"

has_vowel = False
for char in s:
    if char in vowels:
        has_vowel = True

print(has_vowel)
#>  True


#filhantering
#öppna en fil och läs dess innehåll
file = open("example_file.txt", encoding="utf-8")
print("\nFile:\n", file.read())
#>  Lorem ipsum dolor sit amet
#>  
#>  Dorem dpsum dolor dit dmet
file.close()

#öppna en fil och läs in dess innehåll till en lista av rader
file = open("example_file.txt", encoding="utf-8")
print("List of lines:\n", file.readlines())
#>  ['Lorem ipsum dolor sit amet', 'Dorem dpsum dolor dit dmet']
file.close()


#with-as satser
#ingen .close() nödvändigt!
with open('example_file.txt') as file:
    print(file.read())
#>  Lorem ipsum dolor sit amet
#>  
#>  Dorem dpsum dolor dit dmet
