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
