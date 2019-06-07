------------------------------------------Installation------------------------------------
Python and required libraries are already installed.
Extract the python_3.7.0.rar file
--------------------------------------------How to run---------------------------------------------------
Place .res files of new build in folder 1_New_logs
Place .res files of old build in folder 2_Old_logs
Double click run.cmd
(If no comparision is required just fill 1_New_folder and keep 2_Old_folder empty)
-------------------------------------Out put files---------------------------------------------------
1_generated..xlsx will contain data from 1_New_logs folder
2_generated..xlsx will contain data from 2_Old_logs folder
Diff_.xlsx will contain the compared data only
Compared.xlsx will have data of all the above mentioned files.
------------------------------------Configure.json-----------------------------------------
Copy the .xlsx files to somewhere else before running again as they will be overwritten.
Modify the cofigure.json file according to your needs
preferred_columns : column names that you would like to have in output file
Allow_Split_of_Performance_AllResults : split the Performance_AllResults  column with “|” as delimiter into multiple columns and add it as a new sheet in xlsx.
columns_to_be_compared : compares the given columns between the two builds and adds it in diff_.xlsx
excel_file_name_prefix : xlsx output file name
Folder_1
Folder_2 : folders to place the files in.
numeric_columns : These columns will be converted to numeric type to allow numeric operations.
                                           Columns can’t be compared if they are not numeric.
compared_excel_colums: columns which should be present in compared.xlsx
                                                          prefix NEW = columns from New build
                                                          prefix OLD = columns from Old build
                                                          prefix DIFF = columns from difference between the two builds.
 
----------------------------------------------------------------errors---------------------
The script will fail if the above mentioned .xlsx files are open in Excel while running run.cmd
For successful comparision no of .res files must be equal in both the folders.
 

