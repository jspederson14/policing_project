require 'csv'
require 'set'
require 'date'
require 'time'

def any_type_set(filename, key)
    return CSV.foreach(filename, headers: true, converters: %i[numeric date]).inject(Set.new) do |result, row|
        result << row[key]
    end
end

def any_type_hash(filename, key)
    # key is the name of any column header for a row
    result = Hash.new(0)
    CSV.foreach(filename, headers: true, converters: %i[numeric date]) do |row|
        result[row[key]] += 1
    end
    return result
end

def csv_sorter(oldfile, newfile, key, sortval)
    #sorts data into a new csv file from a particular piece of data they have in common
    CSV.foreach(oldfile, headers: true, converters: %i[numeric date]) do |row|
        if(row[key]==sortval)
            CSV.open(newfile, 'ab') do |csv|
                csv << row
            end
        end
    end
end

def csv_sorter2(oldfile, newfile1, newfile2, key, *sortval)
    #sorts data into 2 csv files
    CSV.foreach(oldfile, headers: true, converters: %i[numeric date]) do |row|
        if(sortval.include? row[key])
            CSV.open(newfile1, 'ab') do |csv|
                csv << row
            end
        else
            CSV.open(newfile2, 'ab') do |csv|
                csv << row
            end
        end
    end
end

def hash_count(filename, key, *sortval)
    #counts number elements that meet a particular requirement 
    result = 0
    CSV.foreach(filename, headers: true, converters: %i[numeric date]) do |row|
        if(sortval.include? row[key])
            result += 1
        end
    end
    return result
end

def txt_cons(filename)
    #takes a long list of zip codes and makes it one line 
    result = ''
    File.open(filename).each_line do |row|
        result += (row.strip + ', ')
    end
    return result[0...-2]
end

if __FILE__ == $0
    ga = 'ga_statewide_2020_04_01.csv'
    gashort = 'ga_short.csv'
    il = 'il_statewide_2020_04_01.csv'
    ilshort = 'il_short.csv'
    ilsp = 'il_state_patrol.csv'
    tst = 'test.csv'
    
    # any_type_set(il, 'department_name')

    # csv_sorter(il, ilsp, 'department_name', 'ILLINOIS STATE POLICE')

    csv_sorter2(ga, 'ga_metro.csv','ga_rural.csv','county_name','Fulton County','Dekalb County','Cobb County','Gwinnett County','Clayton County')
    ATLtotal = hash_count(ga, 'county_name', 'Fulton County','Dekalb County','Cobb County','Gwinnett County','Clayton County')
    p 'ATL total: ' + ATLtotal.to_s
    p 'non-ATL total: ' + (499-ATLtotal).to_s
    p 'ATL race data: '
    p any_type_hash('ga_metro.csv','subject_race')
    p 'non ATL race data: '
    p any_type_hash('ga_rural.csv','subject_race')
    p 'ATL gender data: '
    p any_type_hash('ga_metro.csv','subject_sex')
    p 'non ATL gender data: '
    p any_type_hash('ga_rural.csv','subject_sex')
    
    csv_sorter2(ilsp, 'il_metro.csv','il_rural.csv','location', 60430, 60429, 60438, 60439, 60443, 60445, 60452, 60453, 60456, 60455, 60458, 60457, 60459, 60462, 60461, 60464, 60463, 60466, 60465, 60467, 60469, 60472, 60471, 60473, 60476, 60475, 60478, 60477, 60480, 60482, 60501, 60499, 60513, 60521, 60526, 60525, 60527, 60534, 60546, 60558, 60601, 60603, 60602, 60605, 60604, 60607, 60606, 60609, 60608, 60611, 60610, 60613, 60612, 60615, 60614, 60617, 60616, 60619, 60618, 60621, 60620, 60623, 60622, 60625, 60624, 60628, 60626, 60630, 60629, 60632, 60631, 60634, 60633, 60637, 60418, 60636, 60639, 60638, 60641, 60640, 60644, 60643, 60646, 60645, 60649, 60647, 60652, 60651, 60654, 60653, 60656, 60655, 60659, 60657, 60661, 60660, 60668, 60666, 60669, 60677, 60675, 60686, 60688, 60687, 60690, 60693, 60695, 60696, 60699, 60707, 60706, 60714, 60712, 60804, 60803, 60827, 60805, 60487, 60290, 60169, 60004, 60005, 60008, 60007, 60010, 60011, 60016, 60018, 60017, 60019, 60022, 60026, 60025, 60029, 60038, 60043, 60053, 60056, 60062, 60067, 60068, 60642, 60070, 60074, 60077, 60076, 60090, 60089, 60091, 60093, 60103, 60104, 60107, 60120, 60130, 60131, 60133, 60153, 60155, 60154, 60160, 60159, 60162, 60164, 60163, 60165, 60171, 60173, 60172, 60176, 60179, 60192, 60194, 60193, 60196, 60195, 60202, 60201, 60204, 60203, 60208, 60302, 60301, 60304, 60305, 60406, 60402, 60409, 60412, 60411, 60415, 60419, 60422, 60425, 60428, 60426)
    CHItotal = hash_count(ilsp, 'location', 60430, 60429, 60438, 60439, 60443, 60445, 60452, 60453, 60456, 60455, 60458, 60457, 60459, 60462, 60461, 60464, 60463, 60466, 60465, 60467, 60469, 60472, 60471, 60473, 60476, 60475, 60478, 60477, 60480, 60482, 60501, 60499, 60513, 60521, 60526, 60525, 60527, 60534, 60546, 60558, 60601, 60603, 60602, 60605, 60604, 60607, 60606, 60609, 60608, 60611, 60610, 60613, 60612, 60615, 60614, 60617, 60616, 60619, 60618, 60621, 60620, 60623, 60622, 60625, 60624, 60628, 60626, 60630, 60629, 60632, 60631, 60634, 60633, 60637, 60418, 60636, 60639, 60638, 60641, 60640, 60644, 60643, 60646, 60645, 60649, 60647, 60652, 60651, 60654, 60653, 60656, 60655, 60659, 60657, 60661, 60660, 60668, 60666, 60669, 60677, 60675, 60686, 60688, 60687, 60690, 60693, 60695, 60696, 60699, 60707, 60706, 60714, 60712, 60804, 60803, 60827, 60805, 60487, 60290, 60169, 60004, 60005, 60008, 60007, 60010, 60011, 60016, 60018, 60017, 60019, 60022, 60026, 60025, 60029, 60038, 60043, 60053, 60056, 60062, 60067, 60068, 60642, 60070, 60074, 60077, 60076, 60090, 60089, 60091, 60093, 60103, 60104, 60107, 60120, 60130, 60131, 60133, 60153, 60155, 60154, 60160, 60159, 60162, 60164, 60163, 60165, 60171, 60173, 60172, 60176, 60179, 60192, 60194, 60193, 60196, 60195, 60202, 60201, 60204, 60203, 60208, 60302, 60301, 60304, 60305, 60406, 60402, 60409, 60412, 60411, 60415, 60419, 60422, 60425, 60428, 60426)
    # p txt_cons('CookCountyZIPcodes.txt')
    p 'CHI total: ' + CHItotal.to_s
    p 'non-CHI total: ' + (499-CHItotal).to_s
    p 'CHI race data: '
    p any_type_hash('il_metro.csv','subject_race')
    p 'non CHI race data: '
    p any_type_hash('il_rural.csv','subject_race')
    p 'CHI gender data: '
    p any_type_hash('il_metro.csv','subject_sex')
    p 'non CHI gender data: '
    p any_type_hash('il_rural.csv','subject_sex')

end