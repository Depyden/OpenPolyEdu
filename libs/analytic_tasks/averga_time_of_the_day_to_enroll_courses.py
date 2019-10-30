import sys
import datetime
import pandas as pd
import re
from urllib.parse import unquote
from database_services import *


"""Retrieves unique course IDs from the connected database.
@param connection - connection to the target database;
@returns list of unique courses' IDs;
"""
def get_unique_course_ids(connection):
    unique_course_id_query = '''select DISTINCT (log_line ->> 
'context')::json ->> 'course_id' AS course_identifier from logs order by 
course_identifier
        '''
    connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cursor = connection.cursor()
    cursor.execute(unique_course_id_query)
    unique_course_ids = cursor.fetchall()
    cursor.close()
    connection.commit()
    return unique_course_ids

"""Retrieves average time to enroll any course.
@param connection - connection to the target database;
@returns average time to enroll any course;
"""
def get_average_time_to_enroll_any_course(connection):
    # NOTE: Getting average time to enroll the course based on every 
enrolling event.
    total_average_time_to_enroll_course = '''
      select enrolling_events.target_time from (
	select avg(to_timestamp(log_line ->> 'time', 
'YYYY-MM-DD"T"HH24:MI:SS')::TIME) as target_time
	from logs 
	where log_line ->> 'event_type' LIKE '%.activated'
	) enrolling_events
     '''
    
    connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cursor = connection.cursor()
    cursor.execute(total_average_time_to_enroll_course)
    average_time_to_enroll = cursor.fetchall()
    cursor.close()
    connection.commit()
    return average_time_to_enroll

def main(argv):
    print('Start calculating page activity on course distributed by 
day.')

    connection = open_db_connection(database_name, user_name)
    average_time_to_enroll_any_course = 
get_average_time_to_enroll_any_course(connection)
    print('Average time of the day to get enrolled into the course is 
{}'.format(average_time_to_enroll_any_course))
    close_db_connection(connection)


if __name__ == '__main__':
    main(sys.argv)

