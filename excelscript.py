#TO-DO Redundant code has to be removed
import pandas as pd
import glob as gb
import json as js
import os 
#import datetime
import openpyxl
#dir_path = os.path.dirname(os.path.realpath(__file__))
current_working_directory = os.getcwd()
print(current_working_directory)
json_data_file = open(current_working_directory+"\\excel_script.json", "r")
data = js.load(json_data_file)   
preferred_columns = data["preferred_columns"]
numeric_columns = data["numeric_columns"]
columns_to_be_compared = data["columns_to_be_compared"]
Allow_Split_of_Performance_AllResults = data["Allow_Split_of_Performance_AllResults"]
excel_file_name_prefix = data["excel_file_name_prefix"]
compared_excel_colums = data["compared_excel_colums"]

#loc = r'C:\Users\chkiran\Desktop\Performance_Res\2.14.53(CCN009)\*.res'
Folder_1 = '\\'+data["Folder_1"]
Folder_2 = '\\'+data["Folder_2"]
y=[]

def func(x):
     if isinstance(x, str) :
          return x.strip()
     else :
          return x


def create_table(location):   
    List_of_files = gb.glob(location+'\\*.res')
    row_names = ['r1','r2']
    main_df = pd.DataFrame()
    split_df = pd.DataFrame()

    column_names = pd.read_csv(
                            List_of_files[1],
                            delimiter="=",
                            names = row_names,
                            header =None
                            ).transpose().applymap(func).loc['r1']
    #column_names = column_names.applymap(func).loc['r1']
    for itr in List_of_files :
        temp_df = pd.read_csv(
                             itr,
                             delimiter="=",
                             names = row_names, 
                             header =None
                             ).transpose()
        main_df = main_df.append(
                             temp_df.loc[['r2'],] , 
                             ignore_index = True
                             )

    main_df = main_df.rename(columns = column_names)
    
    if Allow_Split_of_Performance_AllResults:
        split_df= pd.DataFrame(main_df['Performance_AllResults'].str.split('|').tolist())
        split_df[0] = main_df['TESTName']
        #split_df = split_df.apply(pd.to_numeric,axis=0)
    
    main_df = main_df.applymap(func)
    main_df[numeric_columns] = main_df[numeric_columns].apply(pd.to_numeric,axis=0)
    main_df[columns_to_be_compared] = main_df[columns_to_be_compared].apply(pd.to_numeric,axis=0)
    main_df_1 = main_df[preferred_columns]
    return main_df_1,split_df


    
list_of_tables = create_table(current_working_directory+Folder_1)



writer = pd.ExcelWriter("1_"+excel_file_name_prefix+".xlsx")

list_of_tables[0].to_excel(writer,
                          sheet_name='Performance_Report',
                          index=False
                          )
if Allow_Split_of_Performance_AllResults:
    list_of_tables[1].to_excel(writer,
                          sheet_name='Readings',
                         index=False
                          )
writer.save()

if len(os.listdir(current_working_directory+Folder_2) ) == 0:
   print("folder is empty")
else :
    writer = pd.ExcelWriter("2_"+excel_file_name_prefix+".xlsx")

    list_of_tables_2 = create_table(current_working_directory+Folder_2)

    list_of_tables_2[0].to_excel(writer,
                          sheet_name='Performance_Report',
                          index=False
                          )
    if Allow_Split_of_Performance_AllResults:
        list_of_tables_2[1].to_excel(writer,
                          sheet_name='Readings',
                          index=False
                          )
    writer.save()
    diff_df =pd.DataFrame( list_of_tables[0][columns_to_be_compared].values - list_of_tables_2[0][columns_to_be_compared].values
                          , columns = columns_to_be_compared)
    diff_df.to_excel("diff_"+".xlsx")
    #y =[ list_of_tables[0]['TESTName'], list_of_tables_2[0]['Performance_Average'] , diff_df['Performance_Average']]
    #y = eval(compared_excel_colums)
    for itr in compared_excel_colums:
        itr=itr.replace("NEW","list_of_tables[0]")
        itr=itr.replace("OLD","list_of_tables_2[0]")
        itr=itr.replace("DIFF","diff_df")
       
        y.append(eval(itr))
        
    all_df = pd.concat(y,axis=1)
    writer = pd.ExcelWriter("compared.xlsx")
    all_df.to_excel(writer,
                          sheet_name='Performance_Report',
                          index=False
                          )
    if Allow_Split_of_Performance_AllResults:
        #list_of_tables_2[1] = pd.DataFrame(list_of_tables_2[1].iloc[:,1:10])
        readings_combined = pd.concat([list_of_tables[1],pd.DataFrame(list_of_tables_2[1].iloc[:,1:11])],axis=1)
        readings_combined.to_excel(writer,
                          sheet_name='Readings',
                          index=False
                          )
    writer.save()
    #pd.to_numeric(main_df['Performance_Average']) - pd.to_numeric(main_df['Performance_Max'])
    
   
#         'Performance_Median']] \
#    = main_df[['Performance_Max', 
#           'Performance_Min',
#           'Performance_Average',
#           'Performance_Median']] \
#           .apply(pd.to_numeric,axis =0 )
#           
#    return main_df  /    
           
#c = pd.DataFrame( main_df[['Performance_Max' , 'Performance_Min']].values - main_df[['Performance_Average','Performance_Median']].values)






