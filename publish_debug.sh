#!/bin/sh
#create publish dir
echo "-------------create publish dir-------------------"
if [ ! -d "../publish" ];
	then
		mkdir "../publish"
fi
CURTIME=`date "+%y-%m-%d-cel_server-debug-0.00"`
CURTIME=${CURTIME}$@
PUBLISHROOT=../publish/${CURTIME}

rm -rf ${PUBLISHROOT}
mkdir ${PUBLISHROOT}

mkdir $PUBLISHROOT/logs
mkdir $PUBLISHROOT/patches


cp -f ./chmod.sh ${PUBLISHROOT}/
cp -f ./start_server.sh ${PUBLISHROOT}/
cp -f ./stop_all.sh ${PUBLISHROOT}/

echo "---------------------cp src------------------------"
mkdir ${PUBLISHROOT}/3rd
cp -rf ./3rd/lualogging ${PUBLISHROOT}/3rd
mkdir ${PUBLISHROOT}/3rd/skynet
cp -rf ./3rd/skynet/cservice ${PUBLISHROOT}/3rd/skynet
cp -rf ./3rd/skynet/luaclib ${PUBLISHROOT}/3rd/skynet
cp -rf ./3rd/skynet/lualib ${PUBLISHROOT}/3rd/skynet
cp -rf ./3rd/skynet/service ${PUBLISHROOT}/3rd/skynet
cp -rf ./3rd/skynet/test ${PUBLISHROOT}/3rd/skynet
cp -rf ./3rd/skynet/skynet ${PUBLISHROOT}/3rd/skynet
cp -rf ./3rd/skynet/examples ${PUBLISHROOT}/3rd/skynet

mkdir ${PUBLISHROOT}/common
cp -rf ./common/* ${PUBLISHROOT}/common

mkdir ${PUBLISHROOT}/config
cp -rf ./config/* ${PUBLISHROOT}/config

mkdir ${PUBLISHROOT}/server
cp -rf ./server/cservice ${PUBLISHROOT}/server
cp -rf ./server/luaclib ${PUBLISHROOT}/server
cp -rf ./server/lualib ${PUBLISHROOT}/server
cp -rf ./server/service ${PUBLISHROOT}/server

#find ${PUBLISHROOT} -type f -name '*.lua' -print -exec 3rd/skynet/3rd/lua/luac -o {} {} \;

find ${PUBLISHROOT} -type f -name '*.c' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name '*.h' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name '*.o' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name '*.a' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name '*.txt' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name 'LICENSE' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name '*Makefile*' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name '*.md' -print -exec rm {} \;
find ${PUBLISHROOT} -type f -name '*.log' -print -exec rm {} \;

tar -zcvf ${PUBLISHROOT}.tar.gz ${PUBLISHROOT}

rm -rf ${PUBLISHROOT}

#ehco
echo "****************************************************************************"
echo "publish on ${PUBLISHROOT}"
echo "you should cp config.example to config and change it,if not existed!"
echo "type kill <pid> to stop launch! or ./stop_all.sh"
echo "type ./start.sh to start launch!"
echo "****************************************************************************"

exit 1