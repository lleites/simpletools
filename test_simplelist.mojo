from simplelist import SimpleList
from testing import assert_equal, assert_true, assert_false


@value
struct MojoTest:
    """
    A utility struct for testing.
    """

    var test_name: String

    fn __init__(inout self, test_name: String):
        self.test_name = test_name
        print("# " + test_name)

    fn assert_true(self, cond: Bool, message: String):
        """
        Wraps testing.assert_true.
        """
        _ = assert_true(cond, message)

    fn assert_true(self, cond: Bool):
        """
        Wraps testing.assert_true.
        """
        _ = assert_true(cond)

    fn assert_equal(self, a: StringRef, b: StringRef):
        """
        Wraps testing.assert_equal.
        """
        _ = assert_equal(a, b)

    fn assert_equal(self, a: Int, b: Int):
        """
        Wraps testing.assert_equal.
        """
        _ = assert_equal(a, b)

    fn assert_false(self, cond: Bool, message: String):
        """
        Wraps testing.assert_false.
        """
        _ = assert_false(cond, message)

    fn assert_false(self, cond: Bool):
        """
        Wraps testing.assert_false.
        """
        _ = assert_false(cond)


@value
@register_passable
struct MyStruct:
    var name: StringRef
    var x: Int
    var y: Int


fn test_simplelist_append() raises:
    let mojo_test = MojoTest("simplelist_append")
    var storage = SimpleList[MyStruct]()
    storage.append(MyStruct("valor", 0, 1))
    mojo_test.assert_equal(storage[0].name, "valor")
    mojo_test.assert_equal(storage[0].x, 0)
    mojo_test.assert_equal(storage[0].y, 1)


fn test_simplelist_index_error():
    let mojo_test = MojoTest("simplelist_index_error")
    var storage = SimpleList[MyStruct]()
    storage.append(MyStruct("valor", 0, 1))
    try:
        _ = storage[5]
        mojo_test.assert_true(False, "This should raise error")
    except:
        mojo_test.assert_true(True, "Raised error")


var result = SimpleList[StringRef]()


fn test_foreach() raises:
    let mojo_test = MojoTest("foreach")
    var storage = SimpleList[MyStruct]()
    storage.append(MyStruct("valor", 0, 1))
    storage.append(MyStruct("valor_2", 9, 10))

    fn print_name(value: MyStruct) -> None:
        print(value.name)
        result.append(value.name)

    storage.foreach(print_name)

    mojo_test.assert_equal(result[0], "valor")
    mojo_test.assert_equal(result[1], "valor_2")


fn test_map() raises:
    let mojo_test = MojoTest("map")
    var storage = SimpleList[MyStruct]()
    storage.append(MyStruct("valor", 0, 1))
    storage.append(MyStruct("valor_2", 9, 10))

    fn get_name(value: MyStruct) -> StringRef:
        return value.name

    var name_storage = storage.map[StringRef](get_name)

    mojo_test.assert_equal(name_storage[0], "valor")
    mojo_test.assert_equal(name_storage[1], "valor_2")


fn test_all_any() raises:
    let mojo_test = MojoTest("all_any")
    var storage = SimpleList[MyStruct]()
    storage.append(MyStruct("valor", 0, 1))
    storage.append(MyStruct("valor_2", 9, 10))

    fn is_true(value: MyStruct) -> Bool:
        return True

    fn is_false(value: MyStruct) -> Bool:
        return False

    fn is_some(value: MyStruct) -> Bool:
        return value.name == "valor_2"

    mojo_test.assert_true(storage.all(is_true))
    mojo_test.assert_false(storage.all(is_false))
    mojo_test.assert_false(storage.all(is_some))

    mojo_test.assert_true(storage.any(is_true))
    mojo_test.assert_false(storage.any(is_false))
    mojo_test.assert_true(storage.any(is_some))


fn test_range() raises:
    let mojo_test = MojoTest("range")
    var storage = SimpleList[MyStruct]()
    storage.append(MyStruct("valor", 0, 1))
    storage.append(MyStruct("valor_2", 9, 10))

    var range_storage = storage.range(0, 1)

    mojo_test.assert_equal(range_storage[0].name, "valor")
    mojo_test.assert_equal(range_storage.__len__(), 1)


fn test_reduce() raises:
    let mojo_test = MojoTest("reduce")
    var storage = SimpleList[MyStruct]()
    storage.append(MyStruct("valor", 0, 1))
    storage.append(MyStruct("valor_2", 9, 10))

    fn add_values(accumulator: Int, value: MyStruct) -> Int:
        return accumulator + value.x

    var reduced_storage = storage.reduce[Int, 0](add_values)

    mojo_test.assert_equal(reduced_storage, 9)


fn test_bool():
    let mojo_test = MojoTest("bool")
    var storage = SimpleList[MyStruct]()
    if storage:
        mojo_test.assert_true(False, "It is empty and it should be False")

    storage.append(MyStruct("valor", 0, 1))
    if not storage:
        mojo_test.assert_true(False, "It has an element and it should be True")


fn test_size():
    let mojo_test = MojoTest("size")
    var storage = SimpleList[MyStruct]()
    mojo_test.assert_equal(storage.size(), 0)

    storage.append(MyStruct("valor", 0, 1))
    mojo_test.assert_equal(storage.size(), 1)


fn main() raises:
    test_simplelist_append()
    test_simplelist_index_error()
    test_foreach()
    test_map()
    test_all_any()
    test_range()
    test_bool()
    test_size()
