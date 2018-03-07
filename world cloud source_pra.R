#����� ����� ������ ���� Ŭ���
getwd()

setwd("c:\\r_temp")

#instatll.packages("KoNLP")
library(KoNLP) #�ѱ� �ܾ� �м���

install.packages("wordcloud") 
library(wordcloud)
install.packages("stringr")
library(stringr)


useSejongDic() #�ѱۻ���

#               read�� �� ���ھ�, readLines�� ���پ� ����Ʈ ���·� ����
data1 <- readLines("sum1.txt")
data1

#   ������ �߿��� ���縸 ��󳻾� ���� �Ҵ�
data2 <- sapply(data1,extractNoun,USE.NAMES=F)
#sapply()���� ���� �����͸� �Ѳ����� �����ϴ� �Լ�


#extractNoun()�Լ� ������ �ܾ�� ���� �� ���縸 ���� #���鵵 �ϳ��� �ܾ�� ó����

#USE>NAMES�� �ش� ������ �Ӹ��� �����ϴ�.

data2
#�������� �ɰ����� ó�� ����Ʈ �ȿ� �Ǵٸ� ����Ʈ�� �������

#����� ���縦 30���� ����ؼ� Ȯ��
head(unlist(data2),30)
#     ����Ʈ ������ �������.

data3 <- unlist(data2)

#��� ������� ������ �ʴ� ���� �ɷ� ����
#gsub("����������","�����ı���","����������")

data3 <- gsub("\\d+","",data3)
#               ����
data3 <- gsub("��������","",data3)
data3 <- gsub("��೻��","",data3)
data3 <- gsub("������ũ","",data3)
data3 <- gsub("����","",data3)
data3 <- gsub(" ","",data3)
data3 <- gsub("-","",data3)
data3
head(unlist(data3),30)

#������ ����� ���ؼ���
#������ �ؼ� �ٱ����� �����´ٰ� read.table�� �о�´�.
#���⿡�� ������ ���Ǵ� ""    (" "�� �����̽� ��)



#���Ϸ� ������ �� ���̺� ���·� ��ȯ�Ͽ� �ҷ�����
write(unlist(data3),"sumedit.txt")

#���� �Ϸ�� ������ read.table���ɾ�� �ٽ� ������
data4 <- read.table("sumedit.txt")
data4

#ȭ�鿡 �׷������� ����ϱ� ���� text���·� ����� Ȯ��
nrow(data4)
#������ �����Ͱ� �� ���� �ִ��� ��ȸ

wordcount <- table(data4)
wordcount

head(sort(wordcount, decreasing=T),20)

data3 <- gsub("b","",data3)
data3 <- gsub("����","",data3)
data3 <- gsub("��ũ","",data3)
data3 <- gsub("���","",data3)
data3 <- gsub("����","",data3)
data3 <- gsub("����","",data3)
data3 <- gsub("��","",data3)
data3 <- gsub("Ÿ","",data3)
data3 <- gsub("��","",data3)
data3 <- gsub("��","",data3)
data3 <- gsub("����","",data3)
data3 <- gsub("��","",data3)
data3 <- gsub("��","",data3)

##gsub for������ ���� �����ϱ�
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
#�׷��� �׷��� �󵵼� ���� ��!!

wordcount<-table(data4) 
#                 ����ī��Ʈ���� �����Ϳ� �󵵼� �������
head(sort(wordcount,decreasing = T),20)

#word cloud ���·� �׷��� ���
library(RColorBrewer)
palete <- brewer.pal(9,"Set3")

#wordcloud���� min.freq�� �ִ� �׸��� ��޵� Ƚ���� �ּ� 1ȸ �̻� ��޵� �ܾ ����϶�
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per = 0.25,min.freq = 1, random.order = F, random.color = T,colors = palete)
#          ���� ������      �󵵼�=���� ���� ����ũ�� 1~5����
#0�̸� ���α۾� 1�̸� ���α۾�  �׷��� �� �󵵼� ���� ���� �ƴ�(������� �׷���)
#               �ּ� �󵵼� 1 (���׸޼��� �� ������)
legend(0.3,1,"����� ����� ��û���� �м�",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")
#���� ������ֱ�



#test
wordcloud(names(wordcount),freq=wordcount,scale=c(1,7),min.freq = 3,max.words = 50,random.order= TRUE,random.color = FALSE,rot.per = .1,ordered.colors = FALSE,use.r.layout = FALSE,fixed.asp = TRUE)

wor