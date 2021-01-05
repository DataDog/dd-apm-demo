echo "Waiting to start.."
sleep 5
echo "Starting load test..."
wrk -t1000 -c1000 -d43200s -s /app/case_a.lua http://api/test/case_a
echo "Finished load test."
