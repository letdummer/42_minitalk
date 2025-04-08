#!/bin/bash

./server &
SERVER_PID=$!
sleep 1
./client $SERVER_PID "Este é um exemplo simples de texto gerado automaticamente com exatamente cem caracteres."
sleep 1
leaks $SERVER_PID
kill $SERVER_PID
