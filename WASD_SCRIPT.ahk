#SingleInstance
#Hotif WinActive("ahk_exe Warcraft III.exe")
w::Up
s::Down
a::Left
d::Right
1::z
2::x
3::c
4::v
F1::Send "{f}+{q}+{v}"
F2::Send "{f}+{w}+{v}"
F3::Send "{f}+{e}+{v}"
F4::Send "{f}+{r}+{v}"
Tab::Send "{F1}"
#SuspendExempt
Enter::{

  Suspend
  Send "{Enter}"

}
#SuspendExempt false
