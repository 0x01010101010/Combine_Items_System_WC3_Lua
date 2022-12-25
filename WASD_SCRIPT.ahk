#SingleInstance
#Hotif WinActive("Warcraft III Public Test") or WinActive("Warcraft III")
w::Up
s::Down
a::Left
d::Right
1::z
2::x
3::c
4::v
#SuspendExempt
Enter::{

  Suspend
  Send "{Enter}"

}
#SuspendExempt false
