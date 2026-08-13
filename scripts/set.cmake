set(MyString1 "Text1")
set([[My String2]] "Text2")
set("My String 3" "Text3")
message(${MyString1})
message(${My\ String2})
message(${My\ String\ 3})

#[=[
    As you can see, it is not advisable to use whitespace with to set variables.
    When referencing the variable later, the whitespace must be escaped using \. 
]=]
