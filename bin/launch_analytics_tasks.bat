@echo off
set BIN_DIR=%~dp0
call %BIN_DIR%set_env.bat

:enterTaskName
echo.
echo Select the task number to be executed:
echo.
echo Main analytics:
echo   1. Calculate total user time on course and user time distributed per day.
echo   2. Calculate users, who enrolled the course, but didn't started it.
echo   3. Calculate users, who started the course, but didn't finish it (didn't try to pass any exam).
echo   4. Calculate users, who finished the course (tried to pass any exam).
echo   5. Show activity type for all users (or for particular user) on course depending on the date.
echo   6. Calculate visits count for page(URL) distributed by day.
echo   7. Calculate total visits count for page(URL).
echo   8. Show the user way over the pages (URL).
echo   9. Get average time to enrol.
echo   10. Show words from pdf search field.
echo   11. Show amount of unique pdfs views.
echo.
echo Utility analytics:
echo   12. Calculate unique user names.
echo   13. Calculate unique event names.
echo   14. Calculate unique user names and ids.
echo   15. Calculate mapping for URLs and course section names
echo   16. Show amount of video play events per day.
echo   17. Show amount of unique pdfs scrolling.
echo.
echo In development:
echo   18. Get count of each event /for every user.
echo   19. Compare courses launches.
echo.
echo   20. Exit
echo.
echo   NOTE: the result of analytics can be found in "result" directory or the browser will be opened automatically.
echo.
set /p TASK_TO_EXECUTE="Task number to execute: "
echo.

IF NOT DEFINED TASK_TO_EXECUTE SET "TASK_TO_EXECUTE=0"
IF "%TASK_TO_EXECUTE%"=="1" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%user_time_on_course.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%01_user_time_on_course.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="2" (
   call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%users_who_enrolled_but_not_started.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%02_users_who_enrolled_but_not_started.csv
   goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="3" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%users_who_started_but_not_finished_the_course.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%03_users_who_started_but_not_finished_the_course.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="4" (
    call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%users_who_finished_the_course.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%04_users_who_finished_the_course.csv
    goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="5" (
     call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%distribution_of_user_actions_on_course_by_day.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%05_distribution_of_user_actions_on_course_by_day.csv
     goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="6" (
   call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%page_activity_on_course_distributed_by_day.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%06_page_activity_on_course_distributed_by_day.csv
   goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="7" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%page_activity_on_course_total_number_of_visits.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%07_page_activity_on_course_total_number_of_visits.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="8" (
   call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%show_user_way.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%08_show_user_way.txt
   goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="9" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%average_time_of_the_day_to_enroll.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%09_average_time_of_the_day_to_enroll.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="10" (
   call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%words_from_pdf_search.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%10_words_from_pdf_search.csv
   goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="11" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%unique_views_of_available_pdf.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%11_unique_views_of_available_pdf.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="12" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%unique_user_names.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%12_unique_user_names.txt
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="13" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%unique_event_names.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%13_unique_event_names.txt
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="14" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%unique_user_names_and_ids.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%14_unique_user_names_and_ids.txt
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="15" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%urls_and_names_mapping.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%15_urls_and_names_mapping.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="16" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%play_video_count_per_day.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%16_play_video_count_per_day.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="17" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%unique_scrolling_of_available_pdf.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%17_unique_scrolling_of_available_pdf.csv
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="18" (
  call %PYTHON_HOME%\python.exe %PY_SCRIPT_DIR%unique_user_names_ids_events.py %DATABASE_NAME% %USER_NAME% %RESULT_DIR%18_unique_user_names_ids_events_counts
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="19" (
  @rem TODO: Put here invocation of the required implementation '..\libs\analytic_tasks'
  echo TODO
  goto enterTaskName
) ELSE IF "%TASK_TO_EXECUTE%"=="20"  (
  echo Thank you for using the tool!
  goto end
) ELSE (
  echo Selected unsupported option.
  goto enterTaskName
)

:end
@rem ============================================================================================
