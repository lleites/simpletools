from simpletools.simplelist import SimpleList as slist


@value
@register_passable
struct MyStruct:
    var name: StringRef
    var x: Int
    var y: Int


fn slist_example() raises:
    # Create a list and add some elements
    var storage = slist[MyStruct]()
    storage.append(MyStruct("First Name", 0, 1))
    storage.append(MyStruct("Second Name", 0, 1))

    # Build a names SimpleList
    fn get_name(value: MyStruct) -> StringRef:
        return value.name

    var names = storage.map[StringRef](get_name)

    # Print the length of each name
    fn print_len(value: StringRef):
        print(value.__len__())

    names.foreach(print_len)

    # Get the second element and pring x and y
    let second_element = storage[1]
    print(second_element.x, second_element.y)


fn main() raises:
    slist_example()
