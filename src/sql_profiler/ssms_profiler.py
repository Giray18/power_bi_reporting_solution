import pyodbc
import time
from datetime import datetime, timedelta, date
import re
import os
import json
from collections import defaultdict
import pandas as pd
import numpy as np
import sys
sys.path.insert(0, 'C:/Users/Lenovo/Desktop/acronis test/task/power_bi_reporting_solution/src')
import dat


class ssms_profiler:
    '''A python class to create quick profiling of tables located on mysql server'''

    def __init__(self, DSN, password) -> None:
        self.DSN = DSN
        self.password = password

    def multiple_dataset_apply_profiling(self) -> pd.DataFrame: 
        ''' This function reads multiple tables from connected database  
        then runs all data profiling functions from dat package makes data profiling and
        saves outputs into an excel file on defined working directory '''

        # Creating connection variable
        cnxn = pyodbc.connect(f'DSN={self.DSN};PWD={self.password}')
        # Create a cursor from the connection variable
        cursor = cnxn.cursor()

        #Reading table names on database into read_tbl list
        cursor.execute("SELECT \
        *\
        FROM \
        Acronis_test.INFORMATION_SCHEMA.TABLES \
        WHERE \
        TABLE_TYPE = 'BASE TABLE';")
        myresult = cursor.fetchall()
        read_tbl = [table_name[2] for table_name in myresult]

        # Creating working directory for daily partitioning
        dir = os.path.join(
            "C:\\", "Users/Lenovo/Desktop/acronis test/task/power_bi_reporting_solution/data_profiling_results", f'{date.today()}')
        if not os.path.exists(dir):
            os.mkdir(dir)
        os.chdir(dir)

        # loop over the list of sql tables and read them into pandas dataframe
        for f in read_tbl:
            df = pd.read_sql(f'SELECT * FROM {f}', con=cnxn)
            # Applying methods to dataframes defined on analysis_dict.py file
            for key, value in dat.analysis_dict().items():
                if df.size != 0:
                    vars()[key] = value(df)
                    dat.save_dataframe_excel(
                        vars(), f"analysis_{f}_{date.today()}")
                else:
                    dat.save_dataframe_excel(
                        df, f"analysis_{f}_{date.today()}")
        return 'dataframes_profiled_results_saved_into_working_directory'
    
    def apply_sql_query(self, sql_command: str) -> pd.DataFrame:
        ''' This function gets sql statement as text input and runs it through connected 
         SQL db and saves result output into an excel file then into defined workind directory '''
        # Creating connection variable
        cnxn = pyodbc.connect(f'DSN={self.DSN};PWD={self.password}')

        # Create sql query and save results into pandas dataframe
        query_results = pd.read_sql(f'{sql_command}', con=cnxn)

        # Creating working directory for saving output into a file with daily partitioning
        dir = os.path.join(
            "C:\\", "Users/Lenovo/Desktop/acronis test/task/power_bi_reporting_solution/sql_query_results", f'{date.today()}')
        if not os.path.exists(dir):
            os.mkdir(dir)
        os.chdir(dir)

        # Saving pandas dataframe into created working directory
        if query_results.size != 0:
            sql_command = sql_command.replace("*", "ALL") # Saving * not possible in file name
            writer = pd.ExcelWriter(f"{sql_command[0:10]}_{date.today()}.xlsx", engine="xlsxwriter")
            query_results.to_excel(writer, sheet_name = 'sql_command')
            writer.close()
            return query_results
        else:
            return 'query results are empty'

        