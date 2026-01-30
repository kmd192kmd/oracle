create table MovieUser (
    seq number,
    name varchar2(30) not null,
    
    constraint PK_MovieUser primary key (seq),
    constraint UK_MovieUser_Name unique (name)
);

create table MovieExpert(
    seq number,
    name varchar2(30) not null,
    
    
    constraint PK_MovieExpert primary key (seq),
    constraint UK_MovieExpert_Name unique (name)
);

create table UserReview(
    seq number,
    content varchar2(4000),
    review_date date default sysdate,
    rating number not null,
    user_seq number not null,
    movie_seq number not null,
    
    constraint PK_UserReview primary key (seq),
    constraint FK_UserReview_User foreign key (user_seq) references MovieUser(seq),
    constraint FK_UserReview_Movie foreign key (movie_seq) references Movie(seq)    
);

create table ExpertReview(
    seq number,
    content varchar2(4000),
    rating number not null,
    expert_seq number not null,
    movie_seq number not null,
    
    constraint PK_ExpertReview primary key (seq),
    constraint FK_ExpertReview_Expert foreign key (expert_seq) references MovieExpert(seq) ,
    constraint FK_ExpertReview_Movie foreign key (movie_seq) references Movie(seq)
);

