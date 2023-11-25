@value
struct SimpleList[type_: AnyType]:
    var data: DynamicVector[type_]

    fn __init__(inout self):
        self.data = DynamicVector[type_]()

    fn append(inout self, value: type_):
        self.data.push_back(value)

    fn __len__(inout self) -> Int:
        return self.data.__len__()

    fn __getitem__(inout self, index: Int) raises -> type_:
        if index >= self.__len__():
            raise Error("IndexError: list index out of range")
        return self.data.__getitem__(index)

    fn get(inout self, index: Int, default: type_) -> type_:
        if index >= self.__len__():
            return default
        return self.data.__getitem__(index)

    fn foreach(inout self, function: fn (type_) capturing -> None) -> None:
        for i in range(self.data.__len__()):
            function(self.data[i])

    fn map[
        newtype_: AnyType
    ](inout self, function: fn (value: type_) capturing -> newtype_) -> SimpleList[
        newtype_
    ]:
        var result = SimpleList[newtype_]()
        for i in range(self.__len__()):
            result.append(function(self.data[i]))
        return result

    fn all(inout self, function: fn (value: type_) capturing -> Bool) -> Bool:
        for i in range(self.__len__()):
            if not function(self.data[i]):
                return False
        return True

    fn any(inout self, function: fn (value: type_) capturing -> Bool) -> Bool:
        for i in range(self.__len__()):
            if function(self.data[i]):
                return True
        return False

    fn range(inout self, start: Int, end: Int) raises -> SimpleList[type_]:
        var result = SimpleList[type_]()
        for i in range(start, end):
            result.append(self.data[i])
        return result

    fn reduce[
        newtype_: AnyType, initial: newtype_
    ](
        inout self,
        function: fn (accumulator: newtype_, value: type_) capturing -> newtype_,
    ) -> newtype_:
        var result = initial
        for i in range(self.__len__()):
            result = function(result, self.data[i])
        return result

    fn __bool__(self) -> Bool:
        return self.data.__len__() > 0

    fn size(self) -> Int:
        return self.data.__len__()
