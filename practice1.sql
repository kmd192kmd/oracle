-- practice1.sql

select * from tblCountry;

select name, capital from tblCountry;

select
    name as "[국가명]",
    capital as "[수도명]",
    population as "[인구수]",
    area as "[면적]",
    continent as "[대륙]"
from tblCountry;
    