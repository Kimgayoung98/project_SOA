import csv
import os
import sqlite3 as sql
import datetime

def getFiletime(dtms):
	if(dtms == 0):
		return (0)
	else:
		seconds, micros = divmod(dtms, 1000000)
		days, seconds = divmod(seconds, 86400)
		return str(datetime.datetime(1601, 1, 1) + (datetime.timedelta(days, seconds, micros)))

def print_url(int):
	for num,row in enumerate(rows):
		if(row[0] == int):
			temp = row[1]
			return temp

def url_details(int):
	for num,row in enumerate(rows):
		if(row[0] == int):
			temp = row[2]
			return temp

def Last_Visit_time(int):
	for num,row in enumerate(rows):
		if(row[0] == int):
			temp = row[5]
			return str(getFiletime(temp))			


# userhome = os.path.expanduser('~')          

# USER_NAME = os.path.split(userhome)[-1]  
conn = sql.connect(r"C:\Users\gayou\AppData\Local\Google\Chrome\User Data\Default\History")
cur = conn.cursor()
cur2 = conn.cursor()
cur3 = conn.cursor()


cur2 = conn.cursor()

cur.execute("SELECT * FROM urls")
cur2.execute("SELECT url, visit_time FROM visits")
cur3.execute("SELECT url, id FROM urls")


rows = cur.fetchall()
rows2 = cur2.fetchall()
rows3 = cur3.fetchall()

#urls
print('------------------------------------URL_INFOMATION-------------------------------------')
for num,row in enumerate(rows):
	print ('URL list [' + str(num + 1) + ']' + '\n''URL ' +  ': ' + str(row[1])
		+ '\n''Details ' +  ': ' + str(row[2]) + '\n''Visit_Count ' +  ': ' + str(row[3])
		+ '\n''last_visit_time ' +  ': ' + getFiletime(row[5]))
			
	print ('-------------------------------------------------------------------------------------\n')
	print('\n')
	print('\n')
	print('\n')
print ('---------------------------------------------------------------------------------------')
print('-------------------------------------VISIT_HISTORY-------------------------------------')

for num,row in enumerate(rows2):
	print('Url_Id : ' + str(row[0]) + '\n' + 'URL: ' + print_url(row[0]) + '\n' + 'URL_Detail: ' + str(url_details(row[0])) 
		+ '\n'+ 'Visit_Time : ' + getFiletime(row[1]))
	print ('====================================================================================')	

#visits

# #Save URL_INFO

# for num, row in enumerate(rows3):
# 	url_id = row[1]
# 	url_info = row[0]

# 	URL_INFO = [url_id, url_info]
# 	#URL_INFO[0] == url_id
# 	#URL_INFO[1] == url_info

# for num, row in enumerate(rows2):
# 	url_id2 = row[0]
# 	visit_time = getFiletime(row[1])

# 	VISIT_INFO = [url_id2, visit_time]
# 	#VISIT_INFO[0] == url_id2
# 	#VISIT_INFO[1] == visit_time

# for row in rows3: #urls
# 	for num in rows2: #visits
# 		# print(URL_INFO[0])
# 		# print(VISIT_INFO[0])

# 		if(URL_INFO[0] == VISIT_INFO[0]):
# 			print("success")
# 			Visit = [URL_INFO[1], VISIT_INFO[1]]
# 			print('test')
# 			continue


conn.close()

#username 변경 가능하게 해야함.