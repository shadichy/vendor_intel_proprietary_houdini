set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/system/bin/* 0 2000 0755
set_perm_recursive $MODPATH/system/etc/binfmt_misc 0 0 0755 0755
set_perm_recursive $MODPATH/system/lib* 0 0 0755 0644
set_perm_recursive $MODPATH/system/etc 0 0 0755 0644

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/vendor/bin/* 0 2000 0755
set_perm_recursive $MODPATH/vendor/etc/binfmt_misc 0 0 0755 0755
set_perm_recursive $MODPATH/vendor/lib* 0 0 0755 0644
set_perm_recursive $MODPATH/vendor/etc 0 0 0755 0644
