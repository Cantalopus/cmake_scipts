set(MyList 1 2 3)
foreach(VAR IN LISTS MyList ITEMS e f)
  message(${VAR})
endforeach() 

message("--------------")

set(L1 "one;two;three;four")
set(L2 "1;2;3;4;5")
foreach(num IN ZIP_LISTS L1 L2)
  message("word=${num_0}, num=${num_1}")
endforeach()

message("--------------")

foreach(word num IN ZIP_LISTS L1 L2)
  message("word=${word}, num=${num}")
endforeach()