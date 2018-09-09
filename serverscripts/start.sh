while true
do
	./copy.sh
	./mta-server64
	echo "Reiniciando em "
	for i in 3 2 1
	do
		echo "$i"
		sleep 1	
	done
	echo "Reiniciando"
done

