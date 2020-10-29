Uses Stanford Open Policing Project Data found here: https://openpolicing.stanford.edu/

1. download csv files for GA state patrol and IL state patrol
2. sorted IL data into just data taken by 'ILLINOIS STATE POLICE' 
   use method csv_sorter() with new data going into il_state_patrol.csv 
3. sort using csv_sorter2() on both data sets for both urban and rural counties
   ga_statewide_2020_04_01.csv -> ga_rural.csv, ga_urban.csv 
   il_state_patrol.csv -> il_rural.csv, il_urban.csv
4. run method any_type_hash() to sort through data sets finding what you need