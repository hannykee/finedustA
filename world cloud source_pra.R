#서울시 응답소 데이터 워드 클라우
getwd()

setwd("c:\\r_temp")

#instatll.packages("KoNLP")
library(KoNLP) #한글 단어 분석기

install.packages("wordcloud") 
library(wordcloud)
install.packages("stringr")
library(stringr)


useSejongDic() #한글사전

#               read는 한 글자씩, readLines는 한줄씩 리스트 형태로 들어옴
data1 <- readLines("sum1.txt")
data1

#   데이터 중에서 명사만 골라내어 변수 할당
data2 <- sapply(data1,extractNoun,USE.NAMES=F)
#sapply()여러 건의 데이터를 한꺼번에 저장하는 함수


#extractNoun()함수 문장을 단어로 만든 후 명사만 추출 #공백도 하나의 단어로 처리함

#USE>NAMES는 해당 데이터 머리끈 없습니다.

data2
#계층으로 쪼개져서 처음 리스트 안에 또다른 리스트가 들어있음

#추출된 명사를 30개만 출력해서 확인
head(unlist(data2),30)
#     리스트 계층이 사라진다.

data3 <- unlist(data2)

#출력 결과에서 원하지 않는 내용 걸러 내기
#gsub("변경전글자","변경후글자","원본데이터")

data3 <- gsub("\\d+","",data3)
#               숫자
data3 <- gsub("뉴스제목","",data3)
data3 <- gsub("요약내용","",data3)
data3 <- gsub("원문링크","",data3)
data3 <- gsub("내용","",data3)
data3 <- gsub(" ","",data3)
data3 <- gsub("-","",data3)
data3
head(unlist(data3),30)

#공백을 지우기 위해서는
#저장을 해서 바깥으로 내보냈다가 read.table로 읽어온다.
#여기에서 공백의 정의는 ""    (" "는 스페이스 바)



#파일로 저장한 후 테이블 형태로 변환하여 불러오기
write(unlist(data3),"sumedit.txt")

#수정 완료된 파일을 read.table명령어로 다시 변수로
data4 <- read.table("sumedit.txt")
data4

#화면에 그래픽으로 출력하기 전에 text형태로 결과를 확인
nrow(data4)
#변수에 데이터가 몇 건이 있는지 조회

wordcount <- table(data4)
wordcount

head(sort(wordcount, decreasing=T),20)

data3 <- gsub("b","",data3)
data3 <- gsub("뉴스","",data3)
data3 <- gsub("링크","",data3)
data3 <- gsub("요약","",data3)
data3 <- gsub("원문","",data3)
data3 <- gsub("제목","",data3)
data3 <- gsub("한","",data3)
data3 <- gsub("타","",data3)
data3 <- gsub("들","",data3)
data3 <- gsub("것","",data3)
data3 <- gsub("때문","",data3)
data3 <- gsub("이","",data3)
data3 <- gsub("수","",data3)

##gsub for문으로 따로 저장하기
#txt <- readLines("gsubfile.txt")
#txt
#cnt_txt <- length(txt)
#cnt_txt
#for(i in 1:cnt_txt){
# data3 <- gsub((txt[i]),"",data3)
#}
#data3
##############

write(unlist(data3),"sumedit2.txt")
data4 <-read.table("sumedit2.txt")
#그래프 그려서 빈도수 만들 때!!

wordcount<-table(data4) 
#                 워드카운트에는 데이터와 빈도수 들어있음
head(sort(wordcount,decreasing = T),20)

#word cloud 형태로 그래픽 출력
library(RColorBrewer)
palete <- brewer.pal(9,"Set3")

#wordcloud에서 min.freq에 있는 항목이 언급된 횟수로 최소 1회 이상 언급된 단어만 출력하라
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per = 0.25,min.freq = 1, random.order = F, random.color = T,colors = palete)
#          넣을 데이터      빈도수=실제 내용 글자크기 1~5사이
#0이면 가로글씨 1이면 세로글씨  그려질 때 빈도수 순서 랜덤 아님(순서대로 그려라)
#               최소 빈도수 1 (워닝메세지 다 못나옴)
legend(0.3,1,"서울시 응답소 요청사항 분석",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")
#범례 만들어주기



#test
wordcloud(names(wordcount),freq=wordcount,scale=c(1,7),min.freq = 3,max.words = 50,random.order= TRUE,random.color = FALSE,rot.per = .1,ordered.colors = FALSE,use.r.layout = FALSE,fixed.asp = TRUE)

wor