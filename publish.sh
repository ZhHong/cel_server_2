#!/bin/sh
#create publish dir
echo "-------------create publish dir-------------------"
if [ ! -d "../publish" ];
	then
		mkdir "../publish"
fi
CURTIME=`date "+%y-%m-%d-v"`
CURTIME=${CURTIME}$@
PUBLISHROOT=../publish/${CURTIME}

rm -rf ${PUBLISHROOT}
mkdir ${PUBLISHROOT}

echo "-----------------compile luac----------------------"
find ./ -type f -name '\*.luac' 2 >/dev/null -exec rm {} \;
find ./ -type f -name '\*.lua' 2 >/dev/null -exec 3rd/skynet/3rd/lua/luac -o *.luac *.lua

mkdir $PUBLISHROOT/cel_server
mkdir $PUBLISHROOT/logs


cp -f ./chmod.sh ${PUBLISHROOT}/cel_server
cp -f ./start_server.sh ${PUBLISHROOT}/cel_server
cp -f ./stop_all.sh ${PUBLISHROOT}/cel_server


echo "---------------------cp luac------------------------"
mkdir ${PUBLISHROOT}/3rd
cp -rf ./3rd/* ${PUBLISHROOT}/3rd
find ${PUBLISHROOT}/3rd -type -f -name '*.lua' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/3rd -type -f -name '*.c' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/3rd -type -f -name '*.h' 2>/dev/null -exec rm {}\;

mkdir ${PUBLISHROOT}/common
cp -rf ./common/* ${PUBLISHROOT}/common
find ${PUBLISHROOT}/common -type -f -name '*.lua' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/common -type -f -name '*.c' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/common -type -f -name '*.h' 2>/dev/null -exec rm {}\;

mkdir ${PUBLISHROOT}/config
cp -rf ./config/* ${PUBLISHROOT}/config
find ${PUBLISHROOT}/config -type -f -name '*.lua' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/config -type -f -name '*.c' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/config -type -f -name '*.h' 2>/dev/null -exec rm {}\;

mkdir ${PUBLISHROOT}/server
cp -rf ./server/* ${PUBLISHROOT}/server
find ${PUBLISHROOT}/server -type -f -name '*.lua' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/server -type -f -name '*.c' 2>/dev/null -exec rm {}\;
find ${PUBLISHROOT}/server -type -f -name '*.h' 2>/dev/null -exec rm {}\;

#ehco
echo "****************************************************************************"
echo "publish on ${PUBLISHROOT}"
echo "you should cp bwmachined.conf to ~/.bwmachined.conf,and change it!"
echo "you should cp launch.cfg.example to launch.cfg and change it,if not existed!"
echo "you should cp log.cfg.example to log.cfg and change it,if not existed!"
echo "type kill <pid> to stop launch!"
echo "type ./start.sh to start launch!"
echo "****************************************************************************"

exit 1