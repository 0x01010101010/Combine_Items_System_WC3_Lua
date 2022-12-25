#SingleInstance
#Hotif WinActive("Warcraft III Public Test") or WinActive("Warcraft III")
w::Up
s::Down
a::Left
d::Right

#SuspendExempt
Enter::{

  Suspend
  Send "{Enter}"

}
#SuspendExempt false
