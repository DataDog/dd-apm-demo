#!/bin/bash
# If health check URL provided, wait till it passes.
if [ -n "$HEALTH_CHECK_URL" ]; then
  STATUS=${HEALTH_CHECK_STATUS:-204}
  INTERVAL=${HEALTH_CHECK_INTERVAL:-5}

  echo -e "\n== Health check =="
  echo "Target:              $HEALTH_CHECK_URL"
  echo "Healthy status:      $STATUS"
  echo "Poll interval:       $INTERVAL seconds"
  echo "** Polling until healthy state... **"
  echo "** Waiting $INTERVAL seconds..."
  sleep $INTERVAL
  while [[ "$(curl --max-time $INTERVAL -s -o /dev/null -w ''%{http_code}'' $HEALTH_CHECK_URL)" != $STATUS ]]; do
    echo "** Waiting $INTERVAL seconds..."
    sleep $INTERVAL
  done
  echo -e "== Health check done. ==\n"
fi

# Start the load test
echo "== Starting load test... =="

if [[ $# -eq 0 ]] ; then
  echo "** No load test specified: pass wrk args as a command. **"
  echo "== Load test aborted. =="
  exit 1
else
  COMMAND="wrk $@"
  echo "Command: $COMMAND"
  /bin/bash -c "$COMMAND"
  echo "== Load test done. =="
  exit 0
fi
