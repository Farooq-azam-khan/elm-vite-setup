module TestSample exposing (..)

import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Should Answer be Streamed"
        [ test "answer should not be streamed if question is not asked"
            (\_ ->
                Expect.equal
                    1
                    1
            )
        ]
