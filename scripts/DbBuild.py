#University of Toronto Wood Species Catalog Database Script
#Development: Shane Guignard
#Research Lead: Chris Preece
#Date: January 15, 2017

import xlrd, os
import time
from datetime import date
from PIL import Image


def html(title="mock-"+time.strftime('%y-%m-%d')):
        writeToFile(title +'.html','<html>'+head(title)+body()+'</html>')

def head(title):
        return '<head>'+docTitle(title)+metaTags()+script(title)+style(title)+'</head>'


def docTitle(title):
        return '<title>'+title+'</title>'
def metaTags():
        content=[]
        content.append('<meta name="viewport" content="width=device-width, initial-scale=1">')

def script(title):
        content=[]
        contents = '/n'.join(content)
        writeToFile(title+'.js', contents)
        
        return '<script type="text/javascript"src="'+title+'.js"></script>'

def style(title):
        style = []
        style.append('img, object{width:inherit; height:inherit;}')
        style.append('html{background-image:url(images/background.jpg);background-repeat:no-repeat;}')
        style.append('#header{background:black; color:white; text-decoration:none;padding:10px;width:100%;position:fixed;top:0;}')
        style.append('a{text-decoration:inherit;color:inherit;text-align:left;}')
        style.append('th,tr,td{text-align:left;font-family:sans-serif; font-size:12pt;}')
        style.append(".item{padding-top:10px; padding-left:5px; padding-right:5px; margin:5px; display:flex; float:left; height:300px; width:450px;}")
        style.append(".picture{width:200px;padding-right:5px;}")
        style.append(".specs,.detail{padding-left:5px;}")
        style.append('body{text-align:center;padding-top:200px;margin:0;}')
        boundStyle = '\n'.join(style)
        writeToFile(title+'.css',boundStyle)
        return '<link rel="stylesheet" type="text/css" href="'+title+'.css"/>'
   
def body():
        content=[]
        #Display The last time the website was updated
        content.append('<div id="header">')
        content.append('<h6>Last updated: '+time.strftime('%c')+'</h6>')
        content.append('<h1>University of Toronto Forestry Digital Wood Library</h1>')
        content.append(sortOptions())
        content.append('<input type="text" value="search"></input>')
        content.append('by Chris Preece, <a href="mailto:shaneguignard@gmail.com">Shane Guignard</a>, and Matt Lefebvre')
        content.append('</div>')
        content.append(excelToHtmlTable('UofTCatClean.xlsx'))

        contents ='\n'.join(content)
        return '<body>'+contents+'</body>'

def sortOptions():
        sort = []
        options = ["Type", "Num", "Genus", "Species", "Family", "Common Name", "Location", "Collector", "Contributor", "Date"]
        sort.append('<select id="sortBy" onchange="sortList(this.value)">')
        for i in range(len(options)):
                if i==3:
                        sort.append("<option value='"+str(i)+"' selected>"+options[i]+"</option>")
                        continue
                sort.append("<option value='"+str(i)+"'>"+options[i]+"</option>")
        sort.append('</select>')
        sortx = '\n'.join(sort)
        return sortx

                    
def imgConvert(path = 'name folder'):
        os.chdir(path)
        for img in os.listdir('.'):
                if img.endswith('.tif'):
                        orgimg = Image.open(img)
                        orgimg.save('jpeg/'+os.path.splitext(img)[0]+'.jpeg')
                else:

                        print('Did not find any files ending in tif')

def writeToFile(fileName, contents):
        f= open(fileName, 'w')
        f.write(contents)
        f.close
        print('Updated: '+fileName)
                
def update():
        book = xlrd.open_workbook('UofTCatClean.xlsx')
        lSeries = book.sheet_by_index(0)
        lCell = lSeries.cell_value
        lRows = []
        charCount = 0
        for rx in range(lSeries.nrows):
                lCols = []
                for cx in range(lSeries.ncols):
                        lCols.append(cx)
                        try:
                                lCols[cx] = ('"'+lCell(0,cx)+'":"'+lCell(rx,cx)+'"')
                                
                                charCount= charCount + len(lCols[cx])

                        except:
                                lCols[cx] = ('"'+str(lCell(0, cx))+'":"'+str(int(lCell(rx,cx)))+'"')
                                charCount= charCount + len(lCols[cx])
                                
                lCols = ','.join(lCols)
                lRows.append(rx)
                lRows[rx] = '{'+lCols+'}'
        file = ',\n'.join(lRows)
        file = '['+file+']'
        writeToFile('data/db.json', file)
        excelToJs(file, str(len(lRows)))


def excelToJs(data, NumRows):
        jsTitle = 'db.js'
        javaScript = []
        javaScript.append('var database =' + data)
        javaScript.append('var numRows =' + NumRows)
        
        jS = ";".join(javaScript)
        jS = jS+';'
        writeToFile(jsTitle,jS)

def excelToHtmlTable(excelFile = 'UofTCatClean.xlsx'):
        html = []
        sheet= []
        book = xlrd.open_workbook(excelFile)
        sheet.append(book.sheet_by_index(0))
        cell = sheet[0].cell_value
        for row in range(sheet[0].nrows):
                if row>1:
                        num = str(cell(row,1))
                        if num=='':
                                break
                        a = num.find('.')
                        b = len(num)
                        num = num.replace(num[a:b],'')#removed link to view full image
                        html.append('<div class="item"><div class="picture"><object type="image/jpeg" data="images/jpeg/'+num+'l(a).jpeg"><img src="images/uoftForestry.jpg"></object></div><table>')
#                        html.append('<table><td rowspan="'+str(sheet[0].ncols+1)+'"><a href="images/'+num+'l(a).tif" target="_page"><object type="image/jpeg" data="images/jpeg/'+num+'l(a).jpeg"></a><img src="images/uoftForestry.jpg">')
                        for col in range(sheet[0].ncols):
                                html.append("<tr><td class='specs'>"+str(cell(0,col))+"</td><td class='detail'>"+str(cell(row,col))+"</td></tr>")
#                                html.append('<tr><th width="20px">'+str(cell(0,col))+':</th><td width="30px">'+str(cell(row,col))+'</td></tr>')
#                        html.append('</td></table>')
                        html.append('</table></div>')
        bound = '\n'.join(html)
        return bound
