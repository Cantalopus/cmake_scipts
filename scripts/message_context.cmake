function(foo)
  list(APPEND CMAKE_MESSAGE_CONTEXT "foo")
  message("foo message")
endfunction()

list(APPEND CMAKE_MESSAGE_CONTEXT "top")
message("Before `foo`")
foo()
message("After `foo`")

message("---------------")

list(APPEND CMAKE_MESSAGE_INDENT " ")
message("Befor `foo`")
foo()
message("After `foo`")