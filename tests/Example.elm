module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "Example Test Suite"
        [ test "should equal" <|
            \() ->
                1 + 1
                    |> Expect.equal 2
        ]
