# SimpleTools

This project aims to include simple but powerful utils and structures to simplify the Mojo development.

## SimpleList

`SimpleList` is a generic data structure that provides a list-like interface for storing and manipulating data of any type. Think of `list` in Python but with extra methods.

### Methods

#### `__init__`

Initializes an empty `SimpleList`.

#### `append`

Appends a value to the end of the `SimpleList`.

#### `__len__`

Returns the length (the number of items) in the `SimpleList`.

#### `__getitem__`

Returns the item at the given index. Raises an error if the index is out of range.

#### `get`

Returns the item at the given index, or the default value if the index is out of range.

#### `foreach`

Applies a function to each item in the `SimpleList`.

#### `map`

Applies a function to each item in the `SimpleList` and returns a new `SimpleList` with the results.

#### `all`

Returns `True` if the function returns `True` for all items in the `SimpleList`, `False` otherwise.

#### `any`

Returns `True` if the function returns `True` for any item in the `SimpleList`, `False` otherwise.

#### `range`

Returns a new `SimpleList` with items from the given start index to the end index.

#### `reduce`

Applies a function of two arguments cumulatively to the items of the `SimpleList`, from left to right, so as to reduce the `SimpleList` to a single output.

#### `__bool__`

Returns `True` if the `SimpleList` is not empty, `False` otherwise.

#### `size`

Returns the number of items in the `SimpleList`.

## How to use

There are multiple examples in the `test_simplelist.mojo` file.
You can also check the `example_usage.mojo`

## FAQ

### This does not work with my struct

It is possible that you are not using the two annotations needed or that you are using String instead of StringRef.
Check the example files mentioned in [How to use](#how-to-use) for examples.

### Why is not `__iter__` implemented?

There are certain limitations in the standard lib that makes this harder than needed. Iterations support would be added sooner than later, for now you can use the [foreach](#foreach) and [map](#map) methods.

## License

This project is licensed under the terms of the MIT license.
