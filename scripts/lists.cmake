#[[
set(myList a list of five elements)

list(LENGTH myList numberOfElements)
message(${myList})
message("is ${numberOfElements} elements")

set(myList "a;list;of;five;elements")

list(LENGTH myList numberOfElements)
message(${myList})
message("is ${numberOfElements} elements")

set(myList a list "of;five;elements")

list(LENGTH myList numberOfElements)
message(${myList})
message("is ${numberOfElements} elements")
]]

set(FOO FALSE)
if(FOO)
  message("condition is true")
else()
  message("condition is false")
endif()